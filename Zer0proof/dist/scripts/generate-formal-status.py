#!/usr/bin/env python3
"""Generate public formal status from current Lean output and build artifacts."""

from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys

REPO = Path(__file__).resolve().parents[1]
THEOREMS = [
    "AscendantRoute.GroundingChain.C5_NE",
    "AscendantRoute.GroundingChain.C5_BoxUnique",
    "AscendantRoute.GroundingChain.C5_RigidWitness",
]
EXPECTED_AXIOMS = ["propext", "Classical.choice", "Quot.sound"]
HYPERMODAL_EXPECTED_AXIOMS = {
    "HyperModal.logic_necessity": [],
    "HyperModal.meta_logic": [],
    "HyperModal.posT_box": EXPECTED_AXIOMS,
    "HyperModal.posT_iff_box": EXPECTED_AXIOMS,
    "HyperModal.triad_core_holds": [],
    "HyperModal.triad_holds": [],
    "HyperModal.posT_box_core": EXPECTED_AXIOMS,
    "HyperModal.posT_not_both": EXPECTED_AXIOMS,
    "HyperModal.Historical.perfect_positivity_refutation": [],
    "HyperModal.Historical.consciousness_axiom_refutation": [],
    "HyperModal.Historical.anti_regress_refutation": [],
    "HyperModal.Historical.logic_material_trio_refutation": [],
    "HyperModal.Model.setting_inhabited": [],
    "HyperModal.Model.omega_possible": [],
    "HyperModal.Model.grounding_nonempty": [],
    "HyperModal.Model.frame_not_collapsed": [],
}
QUESTION_AUDITS = [
    "AscendantRoute.GroundingChainAudit.c1_refutes_all",
    "AscendantRoute.GroundingChainAudit.ground_obtains_refutes_all",
    "AscendantRoute.GroundingChainAudit.c3_refutes_all",
    "AscendantRoute.GroundingChainAudit.c4a_refutes_all",
    "AscendantRoute.GroundingChainAudit.datum_obtains_refutes_all",
]
W12_MATRIX = [
    ("C1", "actual_omega", "AscendantRoute.GroundingChainAudit.c1_not_actual"),
    ("C1", "possible_omega", "AscendantRoute.GroundingChainAudit.c1_not_possible"),
    ("C1", "necessary_omega", "AscendantRoute.GroundingChainAudit.c1_not_necessary"),
    ("C1", "possible_necessary_omega", "AscendantRoute.GroundingChainAudit.c1_not_possible_necessary"),
    ("GroundObtains", "actual_omega", "AscendantRoute.GroundingChainAudit.ground_obtains_not_actual"),
    ("GroundObtains", "possible_omega", "AscendantRoute.GroundingChainAudit.ground_obtains_not_possible"),
    ("GroundObtains", "necessary_omega", "AscendantRoute.GroundingChainAudit.ground_obtains_not_necessary"),
    ("GroundObtains", "possible_necessary_omega", "AscendantRoute.GroundingChainAudit.ground_obtains_not_possible_necessary"),
    ("C3", "actual_omega", "AscendantRoute.GroundingChainAudit.c3_not_actual"),
    ("C3", "possible_omega", "AscendantRoute.GroundingChainAudit.c3_not_possible"),
    ("C3", "necessary_omega", "AscendantRoute.GroundingChainAudit.c3_not_necessary"),
    ("C3", "possible_necessary_omega", "AscendantRoute.GroundingChainAudit.c3_not_possible_necessary"),
    ("C4a", "actual_omega", "AscendantRoute.GroundingChainAudit.c4a_not_actual"),
    ("C4a", "possible_omega", "AscendantRoute.GroundingChainAudit.c4a_not_possible"),
    ("C4a", "necessary_omega", "AscendantRoute.GroundingChainAudit.c4a_not_necessary"),
    ("C4a", "possible_necessary_omega", "AscendantRoute.GroundingChainAudit.c4a_not_possible_necessary"),
    ("datum_obtains", "actual_omega", "AscendantRoute.GroundingChainAudit.datum_not_actual"),
    ("datum_obtains", "possible_omega", "AscendantRoute.GroundingChainAudit.datum_not_possible"),
    ("datum_obtains", "necessary_omega", "AscendantRoute.GroundingChainAudit.datum_not_necessary"),
    ("datum_obtains", "possible_necessary_omega", "AscendantRoute.GroundingChainAudit.datum_not_possible_necessary"),
]
EXPECTED_W12_PREMISES = [
    "C1",
    "GroundObtains",
    "C3",
    "C4a",
    "datum_obtains",
]
EXPECTED_W12_TARGETS = [
    "actual_omega",
    "possible_omega",
    "necessary_omega",
    "possible_necessary_omega",
]
EXPECTED_W12_MANIFEST = [
    ("C1", "AscendantRoute.GroundingChainAudit.c1_refutes_all"),
    ("GroundObtains", "AscendantRoute.GroundingChainAudit.ground_obtains_refutes_all"),
    ("C3", "AscendantRoute.GroundingChainAudit.c3_refutes_all"),
    ("C4a", "AscendantRoute.GroundingChainAudit.c4a_refutes_all"),
    ("datum_obtains", "AscendantRoute.GroundingChainAudit.datum_obtains_refutes_all"),
]
EXPECTED_C5_BINDERS = {
    "C5_NE": ["Omega", "hC1", "hGO", "hC3", "hC4a", "I", "w0", "hI"],
    "C5_BoxUnique": ["Omega", "hC1", "hGO", "hC3", "hC4a", "I", "w0", "hI"],
    "C5_RigidWitness": ["Omega", "hC1", "hGO", "hC3", "hC4a", "I", "w0", "hI"],
}
NEGATIVE_TESTS = [
    ("tests/Reject_HostilePositiveEmpty.lean", "fields missing: 'proper'"),
    ("tests/Reject_HostileModal.lean", "fields missing: 'symm'"),
    ("tests/Reject_ForcedPositiveEmpty.lean", "⊢ ¬True"),
    ("tests/Reject_ForcedHostileModal.lean", "⊢ False"),
    ("tests/Reject_BoxCollapse.lean", "Reject_BoxCollapse.box_collapse"),
    ("tests/Reject_DiaCollapse.lean", "Reject_DiaCollapse.dia_collapse"),
    ("tests/Reject_NoContingency.lean", "Reject_NoContingency.no_contingency_anywhere"),
    ("tests/Reject_CertificateCollapse.lean", "Reject_CertificateCollapse.certificate_equals_existence"),
    ("tests/NoExport_NecessaryExistence.lean", "unknown identifier 'Final_NE_Proof'"),
    ("tests/NoExport_HyperModalLegacy.lean", "unknown identifier 'HyperModal.perfect_positivity'"),
    ("tests/Reject_NecGroundedInAnything.lean", "target is not an inductive datatype"),
]
ASSEMBLIES = [
    "AscendantRoute/Interface.olean",
    "AscendantRoute/PublicTests.olean",
    "AscendantRoute/TargetTypes.olean",
    "AscendantRoute/GroundingAudit.olean",
    "AscendantRoute/GroundingChain.olean",
    "AscendantRoute/GroundingChainAudit.olean",
    "AscendantRoute/GroundingModel.olean",
    "AscendantRoute/PublicCertificateAudit.olean",
    "HyperModal.olean",
]


def run(command: list[str], *, expect_success: bool = True) -> subprocess.CompletedProcess[str]:
    result = subprocess.run(
        command,
        cwd=REPO,
        text=True,
        encoding="utf-8",
        errors="replace",
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    if expect_success and result.returncode != 0:
        raise RuntimeError(f"command failed ({result.returncode}): {' '.join(command)}\n{result.stdout}")
    return result


def block(output: str, kind: str, name: str) -> str:
    begin = f"FORMAL_STATUS_{kind}_BEGIN {name}"
    end = f"FORMAL_STATUS_{kind}_END {name}"
    start = output.find(begin)
    stop = output.find(end, start + len(begin))
    if start < 0 or stop < 0:
        raise RuntimeError(f"missing Lean status markers for {kind} {name}")
    return output[start + len(begin):stop].strip()


def block_text(output: str, begin: str, end: str) -> str:
    start = output.find(begin)
    stop = output.find(end, start + len(begin))
    if start < 0 or stop < 0:
        raise RuntimeError(f"missing Lean status markers {begin} / {end}")
    return output[start + len(begin):stop].strip()


def parse_axioms(output: str, name: str) -> list[str]:
    text = block(output, "AXIOMS", name)
    if "does not depend on any axioms" in text:
        return []
    match = re.search(r"depends on axioms:\s*\[([^]]*)\]", text, re.S)
    if not match:
        raise RuntimeError(f"cannot parse axiom footprint for {name}: {text}")
    return [item.strip() for item in match.group(1).replace("\n", " ").split(",") if item.strip()]


TARGET_TRIPLE_RE = re.compile(r"^[A-Za-z0-9_]+(?:-[A-Za-z0-9_.]+){2,}$")


def normalize_lean_version(raw: str) -> str:
    """Drop the host target triple from `lean --version`.

    The reported version embeds the platform it ran on
    (`x86_64-w64-windows-gnu` versus `x86_64-unknown-linux-gnu`). Since the
    distribution is tracked, that lone difference rewrote the status on every
    run from a different platform, while saying nothing about the audit. The
    Lean version and kernel commit are what identify the toolchain, and they
    are platform-independent.
    """
    match = re.fullmatch(r"Lean \((.*)\)", raw.strip(), re.S)
    if not match:
        return raw.strip()
    fields = [field.strip() for field in match.group(1).split(",")]
    kept = [field for field in fields if not TARGET_TRIPLE_RE.fullmatch(field)]
    return "Lean (" + ", ".join(kept) + ")"


SUCCESSOR_BUNDLE = REPO / "certificates" / "successor-release"
SUCCESSOR_CERTIFICATE = "AscendantRoute/Release/Successor/SuccessorCertificate.lean"
SUCCESSOR_EXPECTED_DECLARATIONS = (
    "AscendantRoute.Release.Successor.Machine",
    "AscendantRoute.Release.Successor.Machine.State",
    "AscendantRoute.Release.Successor.Machine.S",
    "AscendantRoute.Release.Successor.Machine.meas",
    "AscendantRoute.Release.Successor.Machine.dec",
    "AscendantRoute.Release.Successor.Machine.terminal",
    "AscendantRoute.Release.Successor.Machine.zeroUnique",
    "AscendantRoute.Release.Successor.iterate",
    "AscendantRoute.Release.Successor.terminates",
    "AscendantRoute.Release.Successor.coverage",
    "AscendantRoute.Release.Successor.Omega",
    "AscendantRoute.Release.Successor.omega_iff",
    "AscendantRoute.Release.Successor.omega_fixed",
    "AscendantRoute.Release.Successor.existsUniqueOmegaReached",
    "AscendantRoute.Release.Successor.existsUniqueOmega",
    "AscendantRoute.Release.Successor.NatMachine",
    "AscendantRoute.Release.Successor.natStart",
    "AscendantRoute.Release.Successor.natMachine_terminates",
    "AscendantRoute.Release.Successor.natMachine_coverage",
    "AscendantRoute.Release.Successor.natMachine_omega_iff",
    "AscendantRoute.Release.Successor.natMachine_omega_fixed",
    "AscendantRoute.Release.Successor.natMachine_existsUniqueOmegaReached",
    "AscendantRoute.Release.Successor.natMachine_existsUniqueOmega",
)
TI_BUNDLE = REPO / "certificates" / "ti-release"
TI_CERTIFICATE = "AscendantRoute/Release/TI/TICertificate.lean"
TI_EXPECTED_DECLARATIONS = (
    "AscendantRoute.Release.TI.Contract",
    "AscendantRoute.Release.TI.Contract.State",
    "AscendantRoute.Release.TI.Contract.advance",
    "AscendantRoute.Release.TI.Contract.rank",
    "AscendantRoute.Release.TI.Contract.IsTop",
    "AscendantRoute.Release.TI.Contract.descends",
    "AscendantRoute.Release.TI.Contract.top_iff_zero",
    "AscendantRoute.Release.TI.Contract.top_unique",
    "AscendantRoute.Release.TI.Contract.top_fixed",
    "AscendantRoute.Release.TI.iterate",
    "AscendantRoute.Release.TI.iterate_zero",
    "AscendantRoute.Release.TI.iterate_succ",
    "AscendantRoute.Release.TI.iterate_succ_arg",
    "AscendantRoute.Release.TI.converges",
    "AscendantRoute.Release.TI.top_characterization",
    "AscendantRoute.Release.TI.isTop_fixed",
    "AscendantRoute.Release.TI.existsUniqueTop",
    "AscendantRoute.Release.TI.NatContract",
    "AscendantRoute.Release.TI.natOrigin",
    "AscendantRoute.Release.TI.natContract_converges",
    "AscendantRoute.Release.TI.natContract_top_characterization",
    "AscendantRoute.Release.TI.natContract_top_fixed",
    "AscendantRoute.Release.TI.natContract_existsUniqueTop",
)
FOOTPRINT_RE = re.compile(
    r"'([^']+)'\s+(?:(does not depend on any axioms)|depends on axioms:\s*\[([^]]*)\])",
    re.S,
)


def successor_certificate_rows(lake: str):
    """Axiom footprints of the published Successor contract.

    The bundle has its own kernel-recheck lane, but its results never reached
    the machine-readable status, which recorded only the C5 and HyperModal
    routes. A reader comparing the paper's claims against formal-status.json
    therefore found 23 published declarations missing. Record them here, from
    the shipped bundle itself, so the status covers every public theorem.
    """
    source = SUCCESSOR_BUNDLE / SUCCESSOR_CERTIFICATE
    if not source.is_file():
        # Fail closed. Returning None here would silently emit a status that
        # claims nothing about the Successor route while still reporting
        # success -- exactly the shape of an audit that passes because it did
        # not look.
        raise RuntimeError(f"missing successor certificate source: {source}")

    output = run(
        [lake, "-R", "env", "env", f"LEAN_PATH={SUCCESSOR_BUNDLE}", "lean", str(source)]
    ).stdout
    if "sorryAx" in output:
        raise RuntimeError("successor certificate output contains sorryAx")

    rows = []
    for match in FOOTPRINT_RE.finditer(output):
        name, axiom_free, axiom_list = match.group(1), match.group(2), match.group(3)
        axioms = (
            []
            if axiom_free
            else [item.strip() for item in axiom_list.replace("\n", " ").split(",") if item.strip()]
        )
        rows.append({"name": name, "axioms": axioms})

    names = [row["name"] for row in rows]
    duplicates = sorted({name for name in names if names.count(name) > 1})
    if duplicates:
        raise RuntimeError(f"duplicate successor declarations: {duplicates}")

    expected = set(SUCCESSOR_EXPECTED_DECLARATIONS)
    missing = sorted(expected - set(names))
    unexpected = sorted(set(names) - expected)
    if missing or unexpected:
        raise RuntimeError(
            f"successor certificate surface changed: missing={missing} unexpected={unexpected}"
        )

    non_empty = [row["name"] for row in rows if row["axioms"]]
    if non_empty:
        raise RuntimeError(f"successor declarations with nonempty footprint: {non_empty}")
    return rows


def ti_certificate_rows(lake: str):
    """Axiom footprints of the optional public TI contract certificate."""
    if not TI_BUNDLE.exists():
        print("[FORMAL-STATUS] optional TI certificate absent; skipping")
        return []
    if not TI_BUNDLE.is_dir():
        raise RuntimeError(f"TI certificate path is not a directory: {TI_BUNDLE}")
    source = TI_BUNDLE / TI_CERTIFICATE
    if not source.is_file():
        raise RuntimeError(f"missing TI certificate source: {source}")

    output = run(
        [lake, "-R", "env", "env", f"LEAN_PATH={TI_BUNDLE}", "lean", str(source)]
    ).stdout
    if "sorryAx" in output:
        raise RuntimeError("TI certificate output contains sorryAx")

    rows = []
    for match in FOOTPRINT_RE.finditer(output):
        name, axiom_free, axiom_list = match.group(1), match.group(2), match.group(3)
        axioms = (
            []
            if axiom_free
            else [item.strip() for item in axiom_list.replace("\n", " ").split(",") if item.strip()]
        )
        rows.append({"name": name, "axioms": axioms})

    names = [row["name"] for row in rows]
    duplicates = sorted({name for name in names if names.count(name) > 1})
    if duplicates:
        raise RuntimeError(f"duplicate TI declarations: {duplicates}")
    expected = set(TI_EXPECTED_DECLARATIONS)
    missing = sorted(expected - set(names))
    unexpected = sorted(set(names) - expected)
    if missing or unexpected:
        raise RuntimeError(
            f"TI certificate surface changed: missing={missing} unexpected={unexpected}"
        )
    non_empty = [row["name"] for row in rows if row["axioms"]]
    if non_empty:
        raise RuntimeError(f"TI declarations with nonempty footprint: {non_empty}")
    return rows


def parse_w12_list(output: str):
    text = block_text(output, "FORMAL_STATUS_W12_LIST_BEGIN", "FORMAL_STATUS_W12_LIST_END")
    lines = [line.strip() for line in text.splitlines() if line.strip()]
    premises = [line[len("W12_PREMISE=") :] for line in lines if line.startswith("W12_PREMISE=")]
    targets = [line[len("W12_TARGET=") :] for line in lines if line.startswith("W12_TARGET=")]
    manifest = []
    for line in lines:
        if line.startswith("W12_MANIFEST="):
            payload = line[len("W12_MANIFEST=") :]
            if "::" not in payload:
                raise RuntimeError(f"invalid W12_MANIFEST line: {line}")
            name, theorem = payload.split("::", 1)
            manifest.append((name, theorem))
    return premises, targets, manifest


def parse_binder_names(signature: str) -> list[str]:
    return [
        name
        for name in re.findall("[({]\\s*([A-Za-z_][A-Za-z0-9_]*)\\s*:\\s*[^){}]+[)}]", signature)
        if name not in {"u", "v"}
    ]

def verify_c5_signature(source: str, theorem: str, expected: list[str]) -> None:
    pattern = "theorem\\s+{}\\b([\\s\\S]*?)\\s*:=\\s*by".format(re.escape(theorem))
    m = re.search(pattern, source)
    if not m:
        raise RuntimeError(f"could not locate theorem signature for {theorem}")
    signature = m.group(1)
    actual = parse_binder_names(signature)
    if actual != expected:
        raise RuntimeError(f"unexpected binder names for {theorem}: {actual}")

def parse_lean_pairs(raw: list[str] | None) -> dict:
    return {key: value for key, value in raw} if raw is not None else {}


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def markdown(status: dict) -> str:
    lines = [
        "# Formal Status",
        "",
        "> Generated from current Lean/CI output. Do not edit by hand.",
        "",
        f"- Git commit: `{status['git_commit']}`",
        f"- Lean toolchain: `{status['lean_toolchain']}`",
        f"- Audit date: `{status['last_audit_date']}`",
        f"- Auditor verdict: **{status['auditor_verdict']}**",
        "",
        "## Public Theorems",
        "",
        "| Declaration | Axiom footprint |",
        "|---|---|",
    ]
    for theorem in status["public_theorems"]:
        footprint = ", ".join(theorem["axioms"]) or "none"
        lines.append(f"| `{theorem['name']}` | `{footprint}` |")
    lines += [
        "",
        "## HyperModal Core-Relative Audit",
        "",
        "| Declaration | Axiom footprint |",
        "|---|---|",
    ]
    for theorem in status["hypermodal_theorems"]:
        footprint = ", ".join(theorem["axioms"]) or "none"
        lines.append(f"| `{theorem['name']}` | `{footprint}` |")

    if status.get("successor_certificate"):
        lines += [
            "",
            "## Successor Certificate",
            "",
            "| Declaration | Axiom footprint |",
            "|---|---|",
        ]
        for theorem in status["successor_certificate"]:
            footprint = ", ".join(theorem["axioms"]) or "none"
            lines.append(f"| `{theorem['name']}` | `{footprint}` |")

    if status.get("ti_certificate"):
        lines += [
            "",
            "## TI Certificate",
            "",
            "| Declaration | Axiom footprint |",
            "|---|---|",
        ]
        for theorem in status["ti_certificate"]:
            footprint = ", ".join(theorem["axioms"]) or "none"
            lines.append(f"| `{theorem['name']}` | `{footprint}` |")

    lines += [
        "",
        "## W12 Question-Begging Matrix",
        "",
        f"- Audited premises: `{', '.join(status['w12_audit']['premise_names'])}`",
        f"- Audited targets: `{', '.join(status['w12_audit']['target_names'])}`",
        "",
        "| Premise | Target | Status |",
        "|---|---|---|",
    ]
    for row in status["w12_audit"]["matrix"]:
        lines.append(f"| `{row['premise']}` | `{row['target']}` | {row['status']} |")
    lines += [
        "",
        "## Gates",
        "",
    ]
    for key, value in status["gates"].items():
        lines.append(f"- {key.replace('_', ' ').title()}: **{value}**")
    lines += [
        "",
        "## Private Route",
        "",
        status["private_route"]["statement"],
        "",
        "## Public Assembly Hashes",
        "",
        "| Assembly | SHA-256 |",
        "|---|---|",
    ]
    for item in status["public_assemblies"]:
        lines.append(f"| `{item['path']}` | `{item['sha256']}` |")
    return "\n".join(lines) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-json", required=True)
    parser.add_argument("--output-md", required=True)
    parser.add_argument("--reproducible", action="store_true")
    args = parser.parse_args()
    if not args.reproducible:
        raise RuntimeError("status generation requires a completed reproducibility comparison")

    lake = os.environ.get("LAKE_BIN", "lake")
    audit = run([lake, "-R", "env", "lean", "scripts/FormalStatusAudit.lean"]).stdout
    if "sorryAx" in audit:
        raise RuntimeError("public audit output contains sorryAx")

    theorem_rows = []
    for name in THEOREMS:
        axioms = parse_axioms(audit, name)
        if axioms != EXPECTED_AXIOMS:
            raise RuntimeError(f"unexpected footprint for {name}: {axioms}")
        theorem_rows.append({"name": name, "type": block(audit, "TYPE", name), "axioms": axioms})

    hypermodal_rows = []
    hypermodal_source = (REPO / "HyperModal.lean").read_text(encoding="utf-8")
    if re.search(r"(?m)^\s*axiom\b", hypermodal_source):
        raise RuntimeError("HyperModal.lean still contains a global axiom declaration")
    for name, expected in HYPERMODAL_EXPECTED_AXIOMS.items():
        axioms = parse_axioms(audit, name)
        if axioms != expected:
            raise RuntimeError(f"unexpected HyperModal footprint for {name}: {axioms}")
        hypermodal_rows.append({"name": name, "axioms": axioms})

    if parse_axioms(audit, "AscendantRoute.GroundingModel.m_not_collapsed"):
        raise RuntimeError("m_not_collapsed unexpectedly depends on axioms")
    model_axioms = parse_axioms(audit, "AscendantRoute.GroundingModel.m_conclusion")
    if model_axioms != EXPECTED_AXIOMS:
        raise RuntimeError(f"unexpected model footprint: {model_axioms}")

    for name in QUESTION_AUDITS:
        if parse_axioms(audit, name):
            raise RuntimeError(f"question-begging audit is not axiom-free: {name}")

    w12_premises, w12_targets, w12_manifest = parse_w12_list(audit)
    if w12_premises != EXPECTED_W12_PREMISES:
        raise RuntimeError(f"unexpected W12 premise list: {w12_premises}")
    if w12_targets != EXPECTED_W12_TARGETS:
        raise RuntimeError(f"unexpected W12 target list: {w12_targets}")
    if w12_manifest != EXPECTED_W12_MANIFEST:
        raise RuntimeError(f"unexpected W12 manifest: {w12_manifest}")

    w12_matrix = []
    for premise, target, theorem in W12_MATRIX:
        if parse_axioms(audit, theorem):
            raise RuntimeError(f"W12 matrix entry is not axiom-free: {theorem}")
        w12_matrix.append({"premise": premise, "target": target, "theorem": theorem, "status": "PASS"})

    chain_source = (REPO / "AscendantRoute" / "GroundingChain.lean").read_text(encoding="utf-8")
    for theorem, binders in EXPECTED_C5_BINDERS.items():
        verify_c5_signature(chain_source, theorem, binders)

    for filename, expected in NEGATIVE_TESTS:
        result = run([lake, "-R", "env", "lean", filename], expect_success=False)
        if result.returncode == 0 or expected not in result.stdout:
            raise RuntimeError(f"negative guard mismatch: {filename}\n{result.stdout}")

    successor_rows = successor_certificate_rows(lake)
    ti_rows = ti_certificate_rows(lake)

    lean_version = normalize_lean_version(run([lake, "env", "lean", "--version"]).stdout)
    toolchain = (REPO / "lean-toolchain").read_text(encoding="utf-8").strip()
    commit = os.environ.get("FORMAL_STATUS_GIT_COMMIT", "").strip()
    if not commit:
        commit = run(["git", "rev-parse", "HEAD"]).stdout.strip()
    assembly_root = REPO / ".lake" / "build" / "lib" / "lean"
    assemblies = []
    for relative in ASSEMBLIES:
        path = assembly_root / relative
        if not path.is_file():
            raise RuntimeError(f"missing public assembly: {relative}")
        assemblies.append({"path": relative, "sha256": sha256(path)})

    status = {
        "schema_version": 1,
        "git_commit": commit,
        "lean_toolchain": toolchain,
        "lean_version": lean_version,
        "last_audit_date": dt.datetime.now(dt.timezone.utc).date().isoformat(),
        "public_theorems": theorem_rows,
        "hypermodal_theorems": hypermodal_rows,
        "successor_certificate": successor_rows,
        "ti_certificate": ti_rows,
        "gates": {
            "gate_0": "PASS",
            "modal_non_collapse": "PASS",
            "question_begging_individual_premises": "PASS",
            "w12_premise_manifest_complete": "PASS",
            "w12_question_begging_matrix_complete": "PASS",
            "public_grounding_model": "PASS",
            "hypermodal_setting_model": "PASS",
            "hypermodal_legacy_guards": "PASS",
            "public_reproducibility": "PASS",
            "explicit_package_allow_list": "PASS",
            "post_package_leak_scan": "PASS",
        },
        "private_route": {
            "status": "NOT_DISTRIBUTED",
            "publicly_reproducible": False,
            "statement": "The private successor route is not distributed as source or theorem-bearing .olean; no public verdict about its current internal build is asserted.",
        },
        "auditor_verdict": "PENDING_INDEPENDENT_REVIEW",
        "public_model": {
            "theorem": "AscendantRoute.GroundingModel.m_conclusion",
            "axioms": model_axioms,
            "non_collapsed": True,
        },
        "w12_audit": {
            "premise_names": w12_premises,
            "target_names": w12_targets,
            "manifest": [{"premise": p, "theorem": th} for (p, th) in w12_manifest],
            "matrix": w12_matrix,
        },
        "negative_guards": [{"file": f, "expected": e, "status": "PASS"} for f, e in NEGATIVE_TESTS],
        "public_assemblies": assemblies,
    }

    json_path = Path(args.output_json)
    md_path = Path(args.output_md)

    # The distribution is tracked in git, so a run that establishes nothing new
    # must not rewrite it. Commit hash and audit date change on every run by
    # construction, which would dirty four tracked files after every green
    # pipeline and invite unreviewed provenance commits. Keep the recorded
    # values whenever the substantive audit result is unchanged; update them the
    # moment anything else moves.
    # The pipeline builds into a staging directory and swaps it in wholesale, so
    # the output path is empty on every run. Compare against the tracked
    # distribution instead -- that is the artifact whose churn matters.
    VOLATILE = ("git_commit", "last_audit_date")
    reference = json_path if json_path.is_file() else REPO / "dist" / "formal-status.json"
    if reference.is_file():
        try:
            previous = json.loads(reference.read_text(encoding="utf-8"))
        except (json.JSONDecodeError, OSError):
            previous = None
        if isinstance(previous, dict):
            substantive_now = {k: v for k, v in status.items() if k not in VOLATILE}
            substantive_before = {k: v for k, v in previous.items() if k not in VOLATILE}
            if substantive_now == substantive_before:
                for key in VOLATILE:
                    if key in previous:
                        status[key] = previous[key]

    json_path.parent.mkdir(parents=True, exist_ok=True)
    md_path.parent.mkdir(parents=True, exist_ok=True)
    json_path.write_text(json.dumps(status, indent=2, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n")
    md_path.write_text(markdown(status), encoding="utf-8", newline="\n")
    print(f"generated {json_path} and {md_path}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as error:
        print(f"formal status generation failed: {error}", file=sys.stderr)
        raise SystemExit(1)
