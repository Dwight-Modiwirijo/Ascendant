#!/usr/bin/env python3
"""Check machine-verifiable document claims against generated formal status."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re
import sys
from urllib.parse import unquote

REPO = Path(__file__).resolve().parents[1]
DOCS = ["Paper.md", "PUBLIC_SAFETY_CERTIFICATE.md", "README.md"]


def markdown_content_lines(text: str) -> list[str]:
    """Return lines outside fenced code blocks."""
    lines: list[str] = []
    fence_char: str | None = None
    fence_length = 0
    for line in text.splitlines():
        stripped = line.lstrip()
        if fence_char is not None:
            closing = re.match(rf"^{re.escape(fence_char)}{{{fence_length},}}\s*$", stripped)
            if closing:
                fence_char = None
                fence_length = 0
            continue
        opening = re.match(r"^(`{3,}|~{3,})", stripped)
        if opening:
            marker = opening.group(1)
            fence_char = marker[0]
            fence_length = len(marker)
            continue
        lines.append(line)
    return lines


def github_heading_targets(text: str) -> set[str]:
    """Approximate GitHub's Unicode-aware Markdown heading IDs."""
    content = "\n".join(markdown_content_lines(text))
    targets = {
        match.group(1)
        for match in re.finditer(r'<a\s+[^>]*id=["\']([^"\']+)["\']', content)
    }
    seen: dict[str, int] = {}
    for match in re.finditer(r"(?m)^#{1,6}\s+(.+?)\s*$", content):
        heading = re.sub(r"\s+#+\s*$", "", match.group(1))
        heading = re.sub(r"<[^>]+>", "", heading).lower()
        base = re.sub(r"[^\w\s-]", "", heading)
        base = re.sub(r"[ \t]", "-", base).strip("-")
        if not base:
            continue
        duplicate = seen.get(base, 0)
        seen[base] = duplicate + 1
        targets.add(base if duplicate == 0 else f"{base}-{duplicate}")
    return targets


def broken_internal_links(text: str) -> tuple[list[str], int]:
    content = "\n".join(markdown_content_lines(text))
    links = sorted(
        {
            unquote(match.group(1))
            for match in re.finditer(r"\]\(#([^)]+)\)", content)
        }
    )
    targets = github_heading_targets(text)
    return [link for link in links if link not in targets], len(links)


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

    hypermodal_current = [
        "Preservation-Relative Positivity",
        "Core-Relative Positivity",
        "T_core",
        "triad_holds",
        "HyperModalSetting",
        "setting_inhabited",
        "posT_iff_box",
        "posT_box_core",
        "posT_not_both",
        "A4 is not derived from the Triad but from the fixed logical-semantic background alone.",
    ]
    for document, text in texts.items():
        for needle in hypermodal_current:
            if needle not in text:
                errors.append(f"{document}: missing W14 claim: {needle}")

    hypermodal_banned = [
        "axiom perfect_positivity",
        "axiom consciousness_axiom",
        "axiom anti_regress",
        "axiom perfect_being_exists",
        "def ground (p q",
        "ground(p, q) :=",
        r"Pos(P) \equiv \neg \exists Q",
        "Axiom A2 (Perfect Positivity)",
    ]
    for document, text in texts.items():
        for needle in hypermodal_banned:
            if needle in text:
                errors.append(f"{document}: stale W14 claim remains: {needle}")

    if status["gates"].get("hypermodal_setting_model") != "PASS":
        errors.append("status: HyperModal setting model gate must pass")
    if status["gates"].get("hypermodal_legacy_guards") != "PASS":
        errors.append("status: HyperModal legacy guard gate must pass")

    required = {
        "Paper.md": [
            "one shared world-indexed S5 semantics",
            "Gate 0 status: PASS",
            "public compatibility API",
            "public C5 grounding proof surface",
            "publicly certified, kernel-recheckable abstract S-Machine contract",
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

    successor_release_current = [
        "publicly certified, kernel-recheckable distribution of the abstract Successor contract",
        "A `.olean` is not an IP boundary.",
        "TI and the concrete Jump remain private",
    ]
    for document in ("README.md", "PUBLIC_SAFETY_CERTIFICATE.md"):
        for needle in successor_release_current:
            if needle not in texts[document]:
                errors.append(f"{document}: missing W15R claim: {needle}")


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

    w16_current = [
        "The public compatibility layer proves □◇; the independent public C5 grounding route proves the three strong Ω-results from its explicit hypotheses.",
        "| Route | Status in this paper |",
        "C4a.identity connects terminus-existence with Ω-existence at each world; C4a.unique and C4a.rigid are the load-bearing carriers of the uniqueness and rigidity conclusions.",
        "If the actual grounding structure satisfies the complete C5 context Γ, then the kernel theorem applies to that intended interpretation.",
        "Establishing $\\mathcal R\\models\\Gamma_{C5}$ is the paper's philosophical argument, not a consequence of Tarski, BHK, or Lean.",
        "The S-Machine is publicly presented as an abstract successor semantics and formal machine contract.",
    ]
    for needle in w16_current:
        if needle not in texts["Paper.md"]:
            errors.append(f"Paper.md: missing W16 current claim: {needle}")

    protected_phrases = [
        "The proof does not generate actuality but presupposes it",
        "removes quotation marks; it does not mediate ontology",
        "undeniable",
        "modally impossible",
        "Gödel and Turing as Ontological Premises",
        "a primal halting program must exist",
    ]
    for needle in protected_phrases:
        if needle not in texts["Paper.md"]:
            errors.append(f"Paper.md: missing owner-protected phrase: {needle}")

    w16_stale = [
        "public export surface exposes a weaker $\\Box\\Diamond$-compatibility layer, while the private route carries the full $\\Box$-strength results",
        "Strong statements—such as necessary existence, uniqueness, and rigidity of Ω—are intentionally excluded from the public export boundary.",
        "Accordingly, this appendix certifies only the integrity and scope of the public API for the exported $\\square\\Diamond$-fragment",
        "The public repository does not aim to expose `t` for the private theorem.",
        "neither adds strength",
        "This subsection records the axiom dependencies of the strongest internally proven Ω-claims",
        "Gate 0 / JointModel: ongoing hardening",
        "ongoing Gate 0 / assumption-manifest hardening items",
        "Gate 0 hardening ongoing",
        "hardening against adversarial instantiation is ongoing (Gate 0)",
    ]
    for needle in w16_stale:
        if needle in texts["Paper.md"]:
            errors.append(f"Paper.md: stale W16 claim remains: {needle}")

    w16_hard_zero = [
        "Final_NE_Proof",
        "Final_BoxUnique_Proof",
        "Final_RigidWitness_Proof",
        "kernel-accepted proof terms",
        "private kernel route",
        "W15R",
        "owner-gated",
        "release candidate",
        "hash pins",
        "lean4checker",
        "verified local release evidence",
    ]
    for needle in w16_hard_zero:
        if re.search(re.escape(needle), texts["Paper.md"], flags=re.IGNORECASE):
            errors.append(f"Paper.md: forbidden W16 process claim remains: {needle}")

    approved_private_sentence = (
        "The concrete Jump construction and the internal Ascendant Route and TI proof "
        "architectures remain private."
    )
    private_count = len(re.findall(r"\bprivate\b", texts["Paper.md"], flags=re.IGNORECASE))
    if texts["Paper.md"].count(approved_private_sentence) != 1 or private_count != 1:
        errors.append(
            "Paper.md: IP boundary must contain exactly the approved private sentence "
            f"and exactly one 'private' token (found {private_count})"
        )

    synthesis = (REPO / "assets" / "synthesis.svg").read_text(encoding="utf-8")
    for needle in ("FORMAL CONTRACT", "PHILOSOPHICAL ROUTE", "PUBLIC C5 / GroundingChain"):
        if needle not in synthesis:
            errors.append(f"assets/synthesis.svg: missing W16 lane label: {needle}")
    for needle in ("owner-gated", "VERIFIED CANDIDATE", "NOT PUBLICLY AUDITED"):
        if needle.lower() in synthesis.lower():
            errors.append(f"assets/synthesis.svg: stale W16 status remains: {needle}")
    broken, link_count = broken_internal_links(texts["Paper.md"])
    if broken:
        for target in broken:
            errors.append(f"Paper.md: broken internal anchor: #{target}")
    else:
        print(f"internal anchor check PASS: 0 broken of {link_count} internal links")

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
