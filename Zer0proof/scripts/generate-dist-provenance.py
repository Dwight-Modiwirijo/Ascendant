#!/usr/bin/env python3
"""Generate or verify the TAR-to-Ascendant distribution provenance."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
import sys


EXPECTED_BUNDLES = ("successor-release", "ti-release")
EXPECTED_TOOLCHAIN = "leanprover/lean4:v4.20.1"


class ProvenanceError(RuntimeError):
    pass


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def manifest_rows(path: Path) -> dict[str, str]:
    if not path.is_file():
        raise ProvenanceError(f"manifest missing: {path}")
    rows: dict[str, str] = {}
    for number, raw in enumerate(path.read_text(encoding="ascii").splitlines(), 1):
        match = re.fullmatch(r"([0-9a-f]{64}) [ *](.+)", raw)
        if not match:
            raise ProvenanceError(f"malformed manifest row {path}:{number}: {raw!r}")
        digest, relative = match.groups()
        relative = relative.removeprefix("./")
        if relative in rows:
            raise ProvenanceError(f"duplicate manifest path: {path}: {relative}")
        rows[relative] = digest
    if not rows:
        raise ProvenanceError(f"empty manifest: {path}")
    return rows


def verify_manifest(path: Path, root: Path, expected: set[str]) -> None:
    rows = manifest_rows(path)
    if set(rows) != expected:
        raise ProvenanceError(
            f"manifest coverage mismatch: {path}: "
            f"missing={sorted(expected - set(rows))} "
            f"unexpected={sorted(set(rows) - expected)}"
        )
    for relative, expected_hash in rows.items():
        target = root / relative
        if not target.is_file():
            raise ProvenanceError(f"manifest target missing: {target}")
        actual_hash = sha256(target)
        if actual_hash != expected_hash:
            raise ProvenanceError(
                f"SHA256 mismatch: {target}: expected={expected_hash} actual={actual_hash}"
            )


def bundle_record(certificates: Path, name: str) -> dict[str, object]:
    bundle = certificates / name
    pins = certificates / f"{name}.SHA256SUMS"
    provenance_path = bundle / "provenance.json"
    if not bundle.is_dir():
        raise ProvenanceError(f"required bundle missing: {bundle}")
    try:
        provenance = json.loads(provenance_path.read_text(encoding="ascii"))
    except (OSError, json.JSONDecodeError) as error:
        raise ProvenanceError(f"invalid bundle provenance: {provenance_path}: {error}") from error
    if provenance.get("producer") != "TAR" or provenance.get("producerDirty") is not False:
        raise ProvenanceError(f"bundle is not from a clean TAR producer: {bundle}")
    if provenance.get("toolchain") != EXPECTED_TOOLCHAIN:
        raise ProvenanceError(f"bundle toolchain mismatch: {bundle}")
    tar_commit = provenance.get("tarCommit")
    if not isinstance(tar_commit, str) or not re.fullmatch(r"[0-9a-f]{40}", tar_commit):
        raise ProvenanceError(f"invalid TAR commit in {provenance_path}: {tar_commit!r}")
    modules = provenance.get("modules")
    if not isinstance(modules, list) or not modules or not all(isinstance(x, str) for x in modules):
        raise ProvenanceError(f"invalid module list in {provenance_path}")
    files = {
        path.relative_to(bundle).as_posix()
        for path in bundle.rglob("*")
        if path.is_file()
    }
    verify_manifest(bundle / "SHA256SUMS", bundle, files - {"SHA256SUMS"})
    verify_manifest(pins, bundle, files)
    return {
        "name": name,
        "tarCommit": tar_commit,
        "modules": modules,
        "internalManifestSha256": sha256(bundle / "SHA256SUMS"),
        "externalPinsSha256": sha256(pins),
    }


def document(certificates: Path) -> dict[str, object]:
    return {
        "schemaVersion": 1,
        "toolchain": EXPECTED_TOOLCHAIN,
        "bundles": [bundle_record(certificates, name) for name in EXPECTED_BUNDLES],
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--certificates", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    try:
        rendered = json.dumps(
            document(args.certificates.resolve()),
            indent=2,
            sort_keys=True,
        ) + "\n"
        if args.check:
            if not args.output.is_file():
                raise ProvenanceError(f"distribution provenance missing: {args.output}")
            if args.output.read_text(encoding="ascii") != rendered:
                raise ProvenanceError(f"distribution provenance differs: {args.output}")
            print(f"[PROVENANCE] PASS: {args.output}")
        else:
            args.output.write_text(rendered, encoding="ascii", newline="\n")
            print(f"[PROVENANCE] wrote: {args.output}")
    except (OSError, UnicodeError, ValueError, ProvenanceError) as error:
        print(f"[PROVENANCE] ERROR: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
