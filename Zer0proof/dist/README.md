# Zer0proof

Technical access point for the Ascendant.Zero Lean development. The accompanying [paper](Paper.md) gives the argument; this repository gives the public Lean audit surface and command-line checks.

## What Lean Checks

The public source route proves the three strong Omega claims:

| Declaration | Result | Axiom footprint |
|---|---|---|
| `AscendantRoute.GroundingChain.C5_NE` | `Box (fun v => Exists fun x => Omega x v) w` | `propext, Classical.choice, Quot.sound` |
| `AscendantRoute.GroundingChain.C5_BoxUnique` | `Box (fun v => UniqueAt Omega v) w` | `propext, Classical.choice, Quot.sound` |
| `AscendantRoute.GroundingChain.C5_RigidWitness` | `Exists fun x => Box (fun v => forall y, Omega y v <-> y = x) w` | `propext, Classical.choice, Quot.sound` |

Their explicit context is C1, `GroundObtains`, C3, C4a, and an obtaining datum at the selected world. Positivity is not a premise of these C5 results.

`AscendantRoute.GroundingModel` gives a non-collapsed two-world model with genuine contingency and derives necessary unique existence inside that model. `AscendantRoute.GroundingChainAudit` gives premise-by-premise countermodels for the forbidden `Yields*` shapes.

## Public Scope

`AscendantRoute.Interface` defines one shared world-indexed S5 semantics. The public compatibility API proves the weak positivity compatibility result, while the public C5 grounding proof surface proves the strong Omega results from the explicit grounding context.

The private concrete successor route is not distributed as source or theorem-bearing `.olean`, and no private assembly is required for the public audit. Public assurance is supplied by the public C5 source route, generated status files, distribution checks, and the separate disclosure-bounded clean-room Successor certificate.

### Public Successor Certificate

This repository includes a **publicly certified, kernel-recheckable distribution of the abstract Successor contract**. It contains only the clean-room API, the `Nat` countdown model, their derived consequences, and the certificate audit, each as source and `.olean`, plus a minimal dependency-free consumer `lakefile.lean`.

A `.olean` is not an IP boundary. Everything in that optional bundle is public-equivalent; TI and the concrete Jump remain private and outside its mechanically checked import closure.

The payload and its separate repository-controlled trust anchor are at:

```text
certificates/successor-release/
certificates/successor-release.SHA256SUMS
```

Then run:

```bash
bash scripts/check-successor-release.sh
```

The stage verifies the external and internal hashes, pinned toolchain and provenance, `.olean` import compatibility, plain-mode `lean4checker` replay, isolated source rebuilds with byte comparison, certificate output, and leak guards. The published repository includes the bundle, so this stage runs as part of `scripts/ci.sh`.

## HyperModal Core-Relative Layer

`HyperModal.lean` uses the same `AscendantRoute.Interface` frame semantics as the C5 route and takes grounding as a primitive relation `G q p`, with the C5 argument order: the ground comes first. Its assumptions are bundled in `HyperModalSetting`; `triad_holds` derives the world-constant `T_core` predicate from that setting's A1 role, grounding strictness, and strict A3 role. There are no global `axiom` declarations in the module.

The generic **Preservation-Relative Positivity** predicate is `PosT`. Its designated `Pos_T` instance is **Core-Relative Positivity (A1/A3)** over `T_core`. Under the explicit preservation hypothesis, `posT_iff_box` shows that this classification is equivalent to the corresponding boxed property; `posT_box_core` specializes the result to `T_core`, and `posT_not_both` rejects simultaneous classification of `P` and `not P` when `F.Dia Omega w0` is supplied. This layer contributes no Omega-existence premise.

`T_core` is world-constant, so boxing it adds no modal strength. A contentful `ICO`, `Preserves`, genuine A5 closure, and a theorem from the full Triad to boxed ICO preservation remain future work. Until then, "Triad-Relative Positivity" is not a verified label. A4 is not derived from the Triad but from the fixed logical-semantic background alone. `meta_logic` is double-boxed non-contradiction, not a formalization of A5.

`HyperModal.Model.setting_inhabited` supplies an axiom-free, non-collapsed two-world witness with an obtaining datum, contingent `Material`, necessary `Logic`, possible `Omega`, and a non-empty primitive grounding relation. CI also checks the four historical refutation records, rejects the removed legacy exports, and verifies that the former extensional-grounding construction cannot manufacture an edge of primitive `G`.

## Build and Verify

```bash
lake clean
lake build
lake -R env lean AscendantRoute/PublicCertificateAudit.lean
bash scripts/ci.sh
```

`scripts/ci.sh` verifies the published Successor certificate, performs two clean public builds, compares public `.olean` hashes, runs negative guards, generates `dist/formal-status.json` and `dist/FORMAL_STATUS.md`, checks document sync, stages an explicit package allow-list, and runs the post-package leak scan. A successful public run exits with code 0.

## Docker Audit Image

The public audit image is available from Docker Hub:

```text
docker.io/dmodiwirijo/ascendant:latest
```

To download and start the published image:

```bash
docker pull dmodiwirijo/ascendant:latest
docker run --rm -it dmodiwirijo/ascendant:latest
```

Inside the container, the working directory is `/workspace/Zer0proof`. Run the full public audit with:

```bash
bash scripts/ci.sh
```

A successful audit ends with:

```text
[CI] Done
[CI] CI_RC=0
```

For direct Lean inspection inside the container:

```bash
lake build
lake -R env lean AscendantRoute/PublicCertificateAudit.lean
lake -R env lean tests/NoExport_NecessaryExistence.lean
cat dist/FORMAL_STATUS.md
```

To build the same audit image locally from this repository:

```bash
docker build --build-arg ASCENDANT_COMMIT=$(git rev-parse HEAD) -t zer0proof-audit:local .
docker run --rm -it zer0proof-audit:local
```

A run refreshes `dist/`, but you do not need to build anything to inspect it: the public distribution is tracked in this repository and arrives with a plain clone, so `dist/formal-status.json`, `FORMAL_STATUS.md`, `PUBLIC_ALLOWLIST.txt`, `SCOPE.txt`, `SHA256SUMS` and the compiled `.olean` files are already on disk after `git clone`.

## Verifying without building

Twelve compiled modules ship in this repository: nine under `dist/`, and the three of the Successor certificate under `certificates/successor-release/`. They are the objects a third party re-checks; the sources beside them are the cross-check. No account, no login and no build are required to confirm that what is published is what was audited:

```bash
cd Zer0proof/dist && sha256sum -c SHA256SUMS
```

The Successor bundle carries its own pins, which are relative to the bundle root — run them from there, or the paths will not resolve:

```bash
cd Zer0proof/certificates/successor-release && sha256sum -c ../successor-release.SHA256SUMS
```

`dist/formal-status.json` records the axiom footprint of every published declaration: the C5 route, the HyperModal results, and all twenty-three declarations of the Successor certificate. To go further and have the kernel replay the compiled modules, rather than trusting the hashes, run `scripts/check-successor-release.sh`.

## Audit Labels

- **Kernel-verified:** Lean accepts the proof term at the printed theorem type, relative to its explicit hypotheses and reported axioms.
- **Publicly reproducible:** a third party can rebuild the public source route and compare the generated hashes.
- **Private/internal:** not publicly reproducible unless separately disclosed and audited.