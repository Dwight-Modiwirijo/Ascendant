#!/usr/bin/env python3
"""Check machine-verifiable document claims against generated formal status."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys

REPO = Path(__file__).resolve().parents[1]
DOCS = ["Paper.md", "PUBLIC_SAFETY_CERTIFICATE.md", "README.md"]


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("status_json")
    args = parser.parse_args()
    status = json.loads(Path(args.status_json).read_text(encoding="utf-8"))
    texts = {name: (REPO / name).read_text(encoding="utf-8") for name in DOCS}
    errors: list[str] = []

    footprint = "propext, Classical.choice, Quot.sound"
    for theorem in status["public_theorems"]:
        short = theorem["name"].rsplit(".", 1)[-1]
        for document, text in texts.items():
            if short not in text:
                errors.append(f"{document}: missing public theorem {short}")
        if theorem["axioms"] != ["propext", "Classical.choice", "Quot.sound"]:
            errors.append(f"status: unexpected footprint for {short}")
    for document, text in texts.items():
        if footprint not in text:
            errors.append(f"{document}: missing current public footprint")

    required = {
        "Paper.md": [
            "one shared world-indexed S5 semantics",
            "Gate 0 status: PASS",
            "public compatibility API",
            "public C5 grounding proof surface",
            "private successor route",
            "Classical Witness-Selecting Successor Sketch",
            "research blueprint, not the engine",
            "complexity consequence, not an IP protection mechanism",
        ],
        "PUBLIC_SAFETY_CERTIFICATE.md": [
            "explicit package allow-list",
            "post-package leak scan",
            "not distributed as source or theorem-bearing `.olean`",
            "GroundingChainAudit",
        ],
        "README.md": [
            "explicit package allow-list",
            "post-package leak scan",
            "not distributed as source or theorem-bearing `.olean`",
            "formal-status.json",
        ],
    }
    for document, needles in required.items():
        for needle in needles:
            if needle not in texts[document]:
                errors.append(f"{document}: missing synchronized claim: {needle}")

    banned = {
        "Paper.md": [
            "two distinct Lean formalizations of S5",
            "Gate 0 status: PENDING",
            "constrained only by monotonicity",
            "Constructive Successor Function",
            "public surface is intentionally restricted to the □◇-layer",
            "exported interface certifies only the intended S5-compatibility layer",
        ],
        "README.md": [
            "missing source-free certificate assembly",
            "compiled declarations and their dependencies are the intended public certification surface",
            "certificates/AscendantRoute/StrongCertificates.olean",
        ],
        "PUBLIC_SAFETY_CERTIFICATE.md": [
            "AscendantRoute.CertificateAudit",
            "pins every certificate assembly",
            "strong phase runs only when the assembly is present",
        ],
    }
    for document, needles in banned.items():
        for needle in needles:
            if needle in texts[document]:
                errors.append(f"{document}: stale claim remains: {needle}")

    if status["private_route"]["status"] != "NOT_DISTRIBUTED":
        errors.append("status: private route must be NOT_DISTRIBUTED")
    if status["auditor_verdict"] != "PENDING_INDEPENDENT_REVIEW":
        errors.append("status: auditor verdict must remain pending until independent review")

    if errors:
        print("document sync failed:", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1
    print("document sync PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())