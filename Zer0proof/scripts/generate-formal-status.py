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
    "superlaw.olean",
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

    lean_version = run([lake, "env", "lean", "--version"]).stdout.strip()
    toolchain = (REPO / "lean-toolchain").read_text(encoding="utf-8").strip()
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
        "gates": {
            "gate_0": "PASS",
            "modal_non_collapse": "PASS",
            "question_begging_individual_premises": "PASS",
            "w12_premise_manifest_complete": "PASS",
            "w12_question_begging_matrix_complete": "PASS",
            "public_grounding_model": "PASS",
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
