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

The internal concrete successor route is not distributed as source or theorem-bearing `.olean`, and no internal assembly is required for the public audit. Public assurance is supplied by the public C5 source route, generated status files, distribution checks, and two disclosure-bounded clean-room certificates: Successor and TI.

### Public Successor Certificate

This repository includes a **publicly certified, kernel-recheckable distribution of the abstract Successor contract**. It contains only the clean-room API, the `Nat` countdown model, their derived consequences, and the certificate audit, each as source and `.olean`, plus a minimal dependency-free consumer `lakefile.lean`.

A `.olean` is not an IP boundary. Everything in that bundle is public-equivalent; the internal Successor implementation, the internal TI implementation, and the concrete Jump remain undistributed and outside its mechanically checked import closure.

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

### Public TI Certificate

The TI release is a separate clean-room contract, not the internal TI implementation. Its visible requirements are a state type, an advance operation, a natural-number rank, a top predicate, strict rank decrease away from the top, top characterization, uniqueness, and fixedness. Lean derives finite convergence and existence and uniqueness of the top; a `Nat` countdown model establishes non-vacuity. The exact three-module closure is shipped as source and `.olean` pairs with separate repository-controlled pins:

```text
certificates/ti-release/
certificates/ti-release.SHA256SUMS
```

The release does not disclose the internal TI construction, its proof architecture, modal bridge theorems, or any identity theorem connecting its top to the C5 `Omega` predicate.

## HyperModal Core-Relative Layer

`HyperModal.lean` uses the same `AscendantRoute.Interface` frame semantics as the C5 route and takes grounding as a primitive relation `G q p`, with the C5 argument order: the ground comes first. Its assumptions are bundled in `HyperModalSetting`; `triad_holds` derives the world-constant `T_core` predicate from that setting's A1 role, grounding strictness, and strict A3 role. There are no global `axiom` declarations in the module.

The generic **Preservation-Relative Positivity** predicate is `PosT`. Its designated `Pos_T` instance is **Core-Relative Positivity (A1/A3)** over `T_core`. Under the explicit preservation hypothesis, `posT_iff_box` shows that this classification is equivalent to the corresponding boxed property; `posT_box_core` specializes the result to `T_core`, and `posT_not_both` rejects simultaneous classification of `P` and `not P` when `F.Dia Omega w0` is supplied. This layer contributes no Omega-existence premise.

`T_core` is world-constant, so boxing it adds no modal strength. A contentful `ICO`, `Preserves`, genuine A5 closure, and a theorem from the full Triad to boxed ICO preservation remain future work. Until then, "Triad-Relative Positivity" is not a verified label. A4 is not derived from the Triad but from the fixed logical-semantic background alone. `meta_logic` is double-boxed non-contradiction, not a formalization of A5.

`HyperModal.Model.setting_inhabited` supplies an axiom-free, non-collapsed two-world witness with an obtaining datum, contingent `Material`, necessary `Logic`, possible `Omega`, and a non-empty primitive grounding relation. CI also checks the four historical refutation records, rejects the removed legacy exports, and verifies that the former extensional-grounding construction cannot manufacture an edge of primitive `G`.

## Build and Verify

For the complete public verification, including every shipped manifest and `.olean`:

```bash
bash scripts/verify-published.sh
```

That one command dynamically discovers every published compiled module and certificate bundle, verifies internal and external pins, runs pinned plain-mode `lean4checker` in dependency order, rebuilds every module from the shipped source with byte comparison, and scans every shipped bundle for forbidden internal symbols. It exits non-zero on any failure.

The broader project CI remains:

```bash
lake clean
lake build
lake -R env lean AscendantRoute/PublicCertificateAudit.lean
bash scripts/ci.sh
```

`scripts/ci.sh` invokes the route-agnostic bundle verifier, performs two clean public builds, compares public `.olean` hashes, runs negative guards, generates `dist/formal-status.json` and `dist/FORMAL_STATUS.md`, checks document sync, stages an explicit package allow-list, and runs the post-package leak scan. A successful public run exits with code 0.

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

Inside the container, the working directory is `/workspace/Zer0proof`. Verify every published assembly and certificate bundle with:

```bash
bash scripts/verify-published.sh
```

Run the broader source, model, negative-guard, packaging, and document audit with:

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

Fifteen compiled modules ship in this repository: nine under `dist/`, three in the Successor certificate, and three in the TI certificate. They are the objects a third party re-checks; the sources beside them are the cross-check. No account or login is required to confirm their pinned hashes:

```bash
cd Zer0proof/dist && sha256sum -c SHA256SUMS
```

Each certificate bundle carries internal pins and a separate repository-controlled trust anchor. Pin paths are relative to the bundle root:

```bash
(cd Zer0proof/certificates/successor-release && sha256sum -c ../successor-release.SHA256SUMS)
(cd Zer0proof/certificates/ti-release && sha256sum -c ../ti-release.SHA256SUMS)
```

`dist/formal-status.json` records the axiom footprints of the C5 route, HyperModal results, and all twenty-three declarations in each clean-room certificate. Run `bash scripts/verify-published.sh` for pinned kernel replay and byte-identical source rebuilds of all fifteen shipped assemblies.

## Audit Labels

- **Kernel-verified:** Lean accepts the proof term at the printed theorem type, relative to its explicit hypotheses and reported axioms.
- **Publicly reproducible:** a third party can rebuild the public source route and compare the generated hashes.
- **Private/internal:** not publicly reproducible unless separately disclosed and audited.