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

The private successor route is not distributed as source or theorem-bearing `.olean`, and no private assembly is required for the public audit. Public assurance is supplied by the public C5 source route, generated status files, and distribution checks.

## Build and Verify

```bash
lake clean
lake build
lake -R env lean AscendantRoute/PublicCertificateAudit.lean
bash scripts/ci.sh
```

`scripts/ci.sh` performs two clean public builds, compares public `.olean` hashes, runs negative guards, generates `dist/formal-status.json` and `dist/FORMAL_STATUS.md`, checks document sync, stages an explicit package allow-list, and runs the post-package leak scan. A successful public run exits with code 0.

## Docker Audit Image

For an isolated command-line audit environment:

```bash
docker build --build-arg ASCENDANT_COMMIT=$(git rev-parse HEAD) -t zer0proof-audit:local .
docker run --rm -it zer0proof-audit:local
```

Inside the container, the working directory is `/workspace/Zer0proof`:

```bash
lake build
bash scripts/ci.sh
lake -R env lean AscendantRoute/PublicCertificateAudit.lean
lake -R env lean tests/NoExport_NecessaryExistence.lean
```

The build leaves the public distribution in `dist/`, including `formal-status.json`, `FORMAL_STATUS.md`, `PUBLIC_ALLOWLIST.txt`, `SCOPE.txt`, `SHA256SUMS`, and the shipped public `.olean` files.

## Audit Labels

- **Kernel-verified:** Lean accepts the proof term at the printed theorem type, relative to its explicit hypotheses and reported axioms.
- **Publicly reproducible:** a third party can rebuild the public source route and compare the generated hashes.
- **Private/internal:** not publicly reproducible unless separately disclosed and audited.