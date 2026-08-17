# Zer0proof

Technical access point for the Ascendant.Zero Lean development. The accompanying [paper](Paper.md) gives the argument; the generated formal status records what the current public build mechanically establishes.

## Public theorem surface

The public source route proves the three strong Omega claims:

| Declaration | Result | Axiom footprint |
|---|---|---|
| `AltRoute.GroundingChain.C5_NE` | `Box (fun v => Exists fun x => Omega x v) w` | `propext, Classical.choice, Quot.sound` |
| `AltRoute.GroundingChain.C5_BoxUnique` | `Box (fun v => UniqueAt Omega v) w` | `propext, Classical.choice, Quot.sound` |
| `AltRoute.GroundingChain.C5_RigidWitness` | `Exists fun x => Box (fun v => forall y, Omega y v <-> y = x) w` | `propext, Classical.choice, Quot.sound` |

Their explicit context is C1 (HM-PSR), `GroundObtains`, C3 (anti-regress), C4a (identity, uniqueness, and rigidity of Omega), and an obtaining datum at the selected world. Positivity is not a premise.

`AltRoute.GroundingModel` instantiates this context in a non-collapsed two-world frame with genuine contingency and derives necessary unique existence. `AltRoute.GroundingChainAudit` separately gives an empty-domain countermodel for every individual C5 premise, refuting all four forbidden `Yields*` shapes premise by premise.

## Three public/private layers

1. The **public compatibility API** in `AltRoute.Interface` proves the deliberately weak positivity result `Pos(P at w) -> Box (Dia (Exists x, P x)) w`.
2. The **public C5 grounding proof surface** proves necessary existence, necessary uniqueness, and a rigid witness from the explicit constitutive premise chain.
3. The **private successor route** is an independent internal route. It is not distributed as source or theorem-bearing `.olean`, and this public repository asserts no current internal-build verdict for it.

A private theorem-bearing `.olean` contains proof terms and is not an IP disclosure boundary. The public assurance is therefore supplied by the independent public C5 source route, not by distributing a private binary.

## Shared modal semantics

`AltRoute.Interface` defines a world-indexed S5 `Frame` with an accessibility relation, reflexivity, transitivity, and symmetry. `Frame.Box` and `Frame.Dia` are definitions. T, 4, 5, K, duality, and actual-to-possible are theorems derived from the frame fields.

`superlaw.lean` imports this interface and aliases its modal operators to `Frame.Box` and `Frame.Dia`. The project has one shared world-indexed Kripke semantics with multiple grounding and proof layers above it.

## Gate 0 and non-collapse

`Positive` contains both monotonicity and `Positive.proper`, which forbids positivity of the constantly false predicate. The hostile empty-domain instances fail, including forced variants. Gate 0 is therefore PASS for the public interface.

`box_not_identity`, `contingency_witness`, and `certificate_not_trivial` provide permanent non-collapse counterexamples. `GroundingModel.m_not_collapsed` verifies that the complete public C5 premise model is also non-collapsed.

## Historical W11 finding

`AltRoute.GroundingAudit` preserves the earlier audit of a different extensional-grounding bundle. In that bundle, C1 plus a contingent datum is inconsistent because its `Ground q p` direction transmits `q -> p`. Those explosion-derived obligations remain explicitly named as audit findings and are not the current C5 proof route. The current route treats grounding as primitive and states the required obtaining transmission separately as `GroundObtains`; its joint model closes the vacuity gap.

## Machine-generated formal status

CI executes Lean `#check`, `#print`, and `#print axioms` commands through `scripts/FormalStatusAudit.lean`. `scripts/generate-formal-status.py` converts that actual output, guard results, build hashes, toolchain, commit, and audit date into:

- `dist/formal-status.json`
- `dist/FORMAL_STATUS.md`

These files are generated build artifacts rather than manually maintained status prose. `scripts/check-document-sync.py` checks machine-verifiable claims in `Paper.md`, `PUBLIC_SAFETY_CERTIFICATE.md`, and this README against `formal-status.json`.

## Distribution security

`scripts/ci.sh` uses an explicit package allow-list; it never recursively copies build or certificate directories. After packaging, `scripts/check-public-dist.sh` performs a post-package leak scan over:

- the exact shipped path set;
- forbidden private path names;
- strings in every shipped public `.olean`;
- the no-export test in the actually shipped Lean environment.

The private successor route is not distributed as source or theorem-bearing `.olean`. `dist/PUBLIC_ALLOWLIST.txt`, `dist/SCOPE.txt`, and `dist/SHA256SUMS` make the release boundary inspectable in band.

## Build and verify

```bash
cd Zer0proof
lake clean
lake build
lake -R env lean AltRoute/PublicCertificateAudit.lean
bash scripts/ci.sh
```

CI performs two clean builds and rejects differing public assembly hashes. It then generates and verifies the public distribution. A successful public run exits with code 0; no private assembly is required.

## Certification labels

- **Kernel-verified:** Lean accepts a proof term inhabiting its exact theorem type relative to its explicit context and reported axioms.
- **Publicly reproducible:** a third party can rebuild the public source route and compare the generated hashes.
- **Private/internal:** not publicly reproducible unless a separate disclosure decision and audit explicitly say otherwise.

The independent auditor verdict remains pending until the published commit is re-run outside the implementor's environment.