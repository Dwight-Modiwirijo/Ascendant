#!/usr/bin/env python3
"""Fail-closed verification of every published Lean assembly and bundle."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile


REPO = Path(__file__).resolve().parents[1]
CHECKER_REPOSITORY = "https://github.com/leanprover/lean4checker.git"
CHECKER_COMMIT = "ba94ec4b7f5fde6579858f33598eff3e64b9492d"
EXPECTED_TOOLCHAIN = "leanprover/lean4:v4.20.1"
FORBIDDEN = (
    "PosPossibility", "ConstantDomain", "sorryAx", "Final_NE_Proof",
    "Final_BoxUnique_Proof", "Final_RigidWitness_Proof", "TI_", "NE_Run",
    "Bridge", "Swap", "E_R", "J_R", "J_F", "Jump",
    "AscendantRoute.Private", "Private.Successor", "AltRoute",
)
IMPORT_RE = re.compile(r"^\s*import\s+([A-Za-z0-9_.]+)\s*$", re.MULTILINE)
AXIOM_RE = re.compile(
    rb"'([^']+)'\s+(?:(does not depend on any axioms)|depends on axioms:\s*\[([^]]*)\])",
    re.S,
)


class VerificationError(RuntimeError):
    pass


def log(message: str) -> None:
    print(f"[VERIFY] {message}", flush=True)


def run(command: list[str], *, cwd: Path = REPO, env: dict[str, str] | None = None) -> str:
    result = subprocess.run(
        command,
        cwd=cwd,
        env=env,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    if result.returncode != 0:
        raise VerificationError(
            f"command failed ({result.returncode}): {' '.join(command)}\n{result.stdout}"
        )
    return result.stdout


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def manifest_rows(path: Path) -> dict[str, str]:
    if not path.is_file():
        raise VerificationError(f"manifest missing: {path}")
    rows: dict[str, str] = {}
    for number, raw in enumerate(path.read_text(encoding="ascii").splitlines(), 1):
        match = re.fullmatch(r"([0-9a-f]{64}) [ *](.+)", raw)
        if not match:
            raise VerificationError(f"malformed manifest row {path}:{number}: {raw!r}")
        digest, relative = match.groups()
        relative = relative.removeprefix("./")
        if relative in rows:
            raise VerificationError(f"duplicate manifest path: {path}: {relative}")
        rows[relative] = digest
    if not rows:
        raise VerificationError(f"empty manifest: {path}")
    return rows


def verify_manifest(path: Path, root: Path, *, exact: set[str] | None = None) -> None:
    rows = manifest_rows(path)
    if exact is not None and set(rows) != exact:
        raise VerificationError(
            f"manifest coverage mismatch: {path}: missing={sorted(exact - set(rows))} "
            f"unexpected={sorted(set(rows) - exact)}"
        )
    for relative, expected in rows.items():
        target = root / relative
        if not target.is_file():
            raise VerificationError(f"manifest target missing: {target}")
        actual = sha256(target)
        if actual != expected:
            raise VerificationError(
                f"SHA256 mismatch: {target}: expected={expected} actual={actual}"
            )
    log(f"manifest PASS: {path} ({len(rows)} files)")


def scan_forbidden(root: Path) -> None:
    files = sorted(path for path in root.rglob("*") if path.is_file())
    if not files:
        raise VerificationError(f"leak scan has no files: {root}")
    for path in files:
        data = path.read_bytes()
        for symbol in FORBIDDEN:
            if symbol.encode("ascii") in data:
                raise VerificationError(f"forbidden private symbol {symbol!r}: {path}")
    log(f"leak scan PASS: {root} ({len(files)} files, {len(FORBIDDEN)} symbols)")


def module_path(module: str, suffix: str) -> Path:
    return Path(*module.split(".")).with_suffix(suffix)


def topological_modules(root: Path, modules: list[str]) -> list[str]:
    module_set = set(modules)
    dependencies: dict[str, set[str]] = {}
    for module in modules:
        source = root / module_path(module, ".lean")
        if not source.is_file():
            raise VerificationError(f"source missing for shipped module: {module}")
        dependencies[module] = set(IMPORT_RE.findall(source.read_text(encoding="utf-8"))) & module_set
    ordered: list[str] = []
    pending = dict(dependencies)
    while pending:
        ready = sorted(module for module, deps in pending.items() if deps <= set(ordered))
        if not ready:
            raise VerificationError(f"cyclic or unresolved shipped imports: {pending}")
        for module in ready:
            ordered.append(module)
            del pending[module]
    return ordered


def dependency_lean_path() -> list[str]:
    entries = [entry for entry in os.environ.get("LEAN_PATH", "").split(os.pathsep) if entry]
    public_build = str(REPO / ".lake" / "build" / "lib" / "lean").replace("\\", "/")
    return [entry for entry in entries if entry.replace("\\", "/") != public_build]


def lean_env(*roots: Path) -> dict[str, str]:
    env = os.environ.copy()
    entries = [str(root) for root in roots] + dependency_lean_path()
    env["LEAN_PATH"] = os.pathsep.join(dict.fromkeys(entries))
    return env


def checker_binary(lake: str) -> Path:
    cache_parent = Path(
        os.environ.get(
            "LEAN4CHECKER_CACHE_ROOT",
            str(Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache")) / "zer0proof"),
        )
    )
    root = cache_parent / f"lean4checker-{CHECKER_COMMIT}"
    cache_parent.mkdir(parents=True, exist_ok=True)
    if not (root / ".git").is_dir():
        if root.exists():
            raise VerificationError(f"checker cache is not a Git checkout: {root}")
        run(["git", "clone", "--filter=blob:none", "--no-checkout", CHECKER_REPOSITORY, str(root)])
        run(["git", "-C", str(root), "checkout", "--detach", CHECKER_COMMIT])
    if run(["git", "-C", str(root), "remote", "get-url", "origin"]).strip() != CHECKER_REPOSITORY:
        raise VerificationError("lean4checker remote mismatch")
    if run(["git", "-C", str(root), "rev-parse", "HEAD"]).strip() != CHECKER_COMMIT:
        raise VerificationError("lean4checker commit mismatch")
    if (root / "lean-toolchain").read_text(encoding="ascii").strip() != EXPECTED_TOOLCHAIN:
        raise VerificationError("lean4checker toolchain mismatch")
    run([lake, "build", "lean4checker"], cwd=root)
    binary = root / ".lake" / "build" / "bin" / "lean4checker"
    if os.name == "nt":
        binary = binary.with_suffix(".exe")
    if not binary.is_file():
        raise VerificationError(f"lean4checker executable missing: {binary}")
    log(f"lean4checker pin PASS: {CHECKER_COMMIT}")
    return binary


def replay(checker: Path, root: Path, modules: list[str]) -> None:
    env = lean_env(root)
    for module in modules:
        output = run([str(checker), "--verbose", module], env=env)
        print(output, end="")
        log(f"lean4checker plain PASS: {module}")


def rebuild(lean: str, root: Path, modules: list[str]) -> None:
    with tempfile.TemporaryDirectory(prefix="zer0proof-rebuild-") as temporary:
        output_root = Path(temporary)
        for module in modules:
            source = root / module_path(module, ".lean")
            expected = root / module_path(module, ".olean")
            output = output_root / module_path(module, ".olean")
            output.parent.mkdir(parents=True, exist_ok=True)
            run([lean, "-o", str(output), str(source)], cwd=root, env=lean_env(output_root))
            if output.read_bytes() != expected.read_bytes():
                raise VerificationError(f"rebuilt assembly differs byte-for-byte: {module}")
            log(f"source rebuild byte-identical PASS: {module}")


def certificate_footprints(lean: str, root: Path, module: str) -> None:
    source = root / module_path(module, ".lean")
    output = run([lean, str(source)], cwd=root, env=lean_env(root)).encode("utf-8")
    matches = list(AXIOM_RE.finditer(output))
    expected_count = source.read_text(encoding="utf-8").count("#print axioms")
    if expected_count == 0 or len(matches) != expected_count:
        raise VerificationError(
            f"certificate footprint count mismatch: {module}: expected={expected_count} actual={len(matches)}"
        )
    nonempty = [match.group(1).decode() for match in matches if not match.group(2)]
    if nonempty:
        raise VerificationError(f"nonempty certificate footprints: {nonempty}")
    log(f"certificate footprints PASS: {module} ({len(matches)} axiom-free declarations)")


def verify_bundle(bundle: Path, checker: Path, lean: str) -> None:
    provenance_path = bundle / "provenance.json"
    try:
        provenance = json.loads(provenance_path.read_text(encoding="ascii"))
    except (OSError, json.JSONDecodeError) as error:
        raise VerificationError(f"invalid provenance: {provenance_path}: {error}") from error
    modules = provenance.get("modules")
    closure = provenance.get("projectLocalClosure")
    if not isinstance(modules, list) or len(modules) != 3 or not all(isinstance(x, str) for x in modules):
        raise VerificationError(f"bundle must declare exactly three modules: {bundle}")
    if closure != modules:
        raise VerificationError(f"project-local closure differs from module list: {bundle}")
    if provenance.get("producer") != "TAR" or provenance.get("producerDirty") is not False:
        raise VerificationError(f"bundle is not from a clean TAR producer: {bundle}")
    if provenance.get("toolchain") != EXPECTED_TOOLCHAIN:
        raise VerificationError(f"bundle toolchain mismatch: {bundle}")
    checker_info = provenance.get("lean4checker", {})
    if checker_info != {"commit": CHECKER_COMMIT, "mode": "plain", "repository": CHECKER_REPOSITORY}:
        raise VerificationError(f"bundle checker provenance mismatch: {bundle}")
    if provenance.get("freshReplay") != "blocked upstream on v4.20.1, see diagnostic":
        raise VerificationError(f"bundle must record the approved --fresh exception: {bundle}")
    ordered = topological_modules(bundle, modules)
    if ordered != modules:
        raise VerificationError(f"provenance modules are not in dependency order: {bundle}")
    explicit_imports = set()
    for module in modules:
        source = bundle / module_path(module, ".lean")
        explicit_imports.update(IMPORT_RE.findall(source.read_text(encoding="utf-8")))
    unexpected_imports = explicit_imports - set(modules)
    if unexpected_imports:
        raise VerificationError(
            f"bundle imports modules outside its declared closure: {sorted(unexpected_imports)}"
        )
    log(f"exact project-local import closure PASS: {', '.join(modules)}")

    expected = {"SHA256SUMS", "lakefile.lean", "lean-toolchain", "provenance.json"}
    for module in modules:
        expected.add(module_path(module, ".lean").as_posix())
        expected.add(module_path(module, ".olean").as_posix())
    actual = {path.relative_to(bundle).as_posix() for path in bundle.rglob("*") if path.is_file()}
    if actual != expected:
        raise VerificationError(
            f"bundle inventory mismatch: {bundle}: missing={sorted(expected - actual)} "
            f"unexpected={sorted(actual - expected)}"
        )
    if any(path.is_symlink() for path in bundle.rglob("*")):
        raise VerificationError(f"symlink in bundle: {bundle}")
    internal_targets = expected - {"SHA256SUMS"}
    verify_manifest(bundle / "SHA256SUMS", bundle, exact=internal_targets)
    pins = bundle.with_suffix(".SHA256SUMS")
    verify_manifest(pins, bundle, exact=expected)
    if (bundle / "lean-toolchain").read_text(encoding="ascii").strip() != EXPECTED_TOOLCHAIN:
        raise VerificationError(f"bundle lean-toolchain mismatch: {bundle}")
    scan_forbidden(bundle)
    replay(checker, bundle, ordered)
    rebuild(lean, bundle, ordered)
    certificate_footprints(lean, bundle, ordered[-1])
    log(f"bundle PASS: {bundle.name}")


def public_modules(dist: Path) -> list[str]:
    modules = [
        ".".join(path.relative_to(dist).with_suffix("").parts)
        for path in dist.rglob("*.olean")
    ]
    if not modules:
        raise VerificationError("no published assemblies found in dist")
    return topological_modules(dist, modules)


def verify_dist(dist: Path, checker: Path, lean: str) -> None:
    files = {path.relative_to(dist).as_posix() for path in dist.rglob("*") if path.is_file()}
    verify_manifest(dist / "SHA256SUMS", dist, exact=files - {"SHA256SUMS"})
    run(["bash", "scripts/check-public-dist.sh", str(dist)])
    modules = public_modules(dist)
    replay(checker, dist, modules)
    rebuild(lean, dist, modules)
    log(f"public distribution PASS: {len(modules)} compiled modules")


def discover_bundles(root: Path) -> list[Path]:
    if not root.exists():
        log("optional certificate root absent; skipping all bundles")
        return []
    if not root.is_dir():
        raise VerificationError(f"certificate root is not a directory: {root}")
    bundles = sorted(path for path in root.glob("*-release") if path.is_dir())
    if not bundles:
        log("optional certificate bundles absent; skipping")
    return bundles


def self_tests(dist: Path, bundles: list[Path]) -> None:
    with tempfile.TemporaryDirectory(prefix="zer0proof-selftest-") as temporary:
        scratch = Path(temporary)
        rows = manifest_rows(dist / "SHA256SUMS")
        relative = next(name for name in rows if name.endswith(".olean"))
        target = scratch / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(dist / relative, target)
        (scratch / "SHA256SUMS").write_text(
            f"{rows[relative]}  {relative}\n", encoding="ascii", newline="\n"
        )
        data = bytearray(target.read_bytes())
        data[len(data) // 2] ^= 1
        target.write_bytes(data)
        try:
            verify_manifest(scratch / "SHA256SUMS", scratch, exact={relative})
        except VerificationError as error:
            log(f"negative control PASS: flipped byte rejected: {error}")
        else:
            raise VerificationError("negative control failed: flipped byte accepted")

        if bundles:
            leak_root = scratch / "leak"
            shutil.copytree(bundles[0], leak_root)
            smuggled = next(leak_root.rglob("*.olean"))
            smuggled.write_bytes(smuggled.read_bytes() + b"Final_NE_Proof")
            try:
                scan_forbidden(leak_root)
            except VerificationError as error:
                log(f"negative control PASS: smuggled symbol rejected: {error}")
            else:
                raise VerificationError("negative control failed: smuggled symbol accepted")

        empty = scratch / "empty-certificates"
        empty.mkdir()
        if discover_bundles(empty):
            raise VerificationError("negative control failed: empty bundle root did not skip")
        log("negative control PASS: bundle removed -> green skip")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--bundles-only", action="store_true")
    parser.add_argument("--skip-self-tests", action="store_true")
    args = parser.parse_args()

    toolchain = (REPO / "lean-toolchain").read_text(encoding="ascii").strip()
    if toolchain != EXPECTED_TOOLCHAIN:
        raise VerificationError(f"project toolchain mismatch: {toolchain}")
    lake = os.environ.get("LAKE_BIN", "lake")
    lean = os.environ.get("LEAN_BIN", "lean")
    certificate_root = Path(
        os.environ.get("VERIFY_CERTIFICATES_ROOT", str(REPO / "certificates"))
    ).resolve()
    bundles = discover_bundles(certificate_root)
    checker = checker_binary(lake)
    if not args.bundles_only:
        verify_dist(Path(os.environ.get("VERIFY_DIST_ROOT", str(REPO / "dist"))).resolve(), checker, lean)
    for bundle in bundles:
        verify_bundle(bundle, checker, lean)
    if not args.skip_self_tests:
        self_tests(Path(os.environ.get("VERIFY_DIST_ROOT", str(REPO / "dist"))).resolve(), bundles)
    log(f"DONE: bundles={len(bundles)}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as error:
        print(f"[VERIFY] ERROR: {error}", file=sys.stderr)
        raise SystemExit(1)
