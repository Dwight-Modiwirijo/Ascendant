# Ascendant.Zero — Public Safety Certificate

## Scope

This repository publishes a source-reproducible public verification route. It includes the world-indexed S5 interface, the C5 grounding theorems, the individual-premise audit, a joint non-collapsed model, negative guards, and an explicitly allow-listed distribution.

Compiled `.olean` files carry theorem declarations and proof terms. They support rebuild and integrity checks, but they are not an IP disclosure boundary. The private successor route is not distributed as source or theorem-bearing `.olean`; public kernel assurance for the strong Omega claims is supplied independently by `AscendantRoute.GroundingChain.C5_*`.

No public claim is made about the current internal build status of private `Final_*` declarations. Such a status requires separate non-public evidence and independent audit.

The separately pinned Successor and TI releases are **publicly certified, kernel-recheckable distributions of abstract contracts**. Each exposes only a clean-room contract, a countdown model, derived consequences, and an audit surface as three source/`.olean` pairs plus a minimal consumer `lakefile.lean`. A `.olean` is not an IP boundary. The internal Successor and TI implementations and the concrete Jump are undistributed and excluded from both exact release closures.

## Modal semantics

The public interface defines an S5 Kripke `Frame` with an accessibility relation, reflexivity, transitivity, and symmetry. `Box` and `Dia` are definitions over world-indexed propositions. T, 4, 5, K, duality, and actual-to-possible are derived theorems. `HyperModal.lean` imports the same interface, so there is one shared modal semantics.

## Public result boundary

- **Public compatibility API:** `necPossible_of_Pos`, a weak `Box (Dia ...)` result.
- **Public C5 grounding route:** `C5_NE`, `C5_BoxUnique`, and `C5_RigidWitness`, each with footprint `propext, Classical.choice, Quot.sound`.
- **Private successor route:** independent internal work, not distributed and not part of the public reproducibility claim.
- **Public clean-room Successor release:** source-plus-`.olean` certification of the abstract contract only, accepted through external SHA pins, plain kernel replay, reproducible rebuild comparison, and leak checks.
- **Public clean-room TI release:** source-plus-`.olean` certification of finite convergence to a unique fixed top under explicit contract requirements; it does not expose the internal TI implementation or establish a bridge to C5 `Omega`.

The C5 theorem parameters expose C1, `GroundObtains`, C3, C4a, and the obtaining datum directly. Positivity is absent. `GroundingModel` jointly instantiates the premise chain in a non-collapsed two-world frame.

## HyperModal repair boundary

The public `HyperModal.lean` layer has no global `axiom` declarations. It uses primitive grounding `G q p` and packages its visible assumptions in `HyperModalSetting`. The derived theorem `triad_core_holds` supplies the world-constant `T_core` predicate from the setting's formal A1/A3 fields. The deprecated `triad_holds` compatibility alias has the same empty footprint.

`PosT` is **Preservation-Relative Positivity**; its designated `Pos_T` specialization is **Core-Relative Positivity (A1/A3)**. `posT_iff_box` records the honesty equivalence under explicit preservation, `posT_box_core` is the `T_core` specialization, and `posT_not_both` requires explicit `F.Dia Omega w0`. None of these declarations supplies an Omega-existence premise.

The A5 component of the philosophical Triad is not formalized, and no `Triad -> Box PreservesICO` theorem is claimed. A4 follows from the fixed logical-semantic background alone. `meta_logic` is only double-boxed non-contradiction, not A5 closure.

`HyperModal.Model.setting_inhabited` is an axiom-free, non-collapsed two-world witness with an obtaining datum, contingent material, necessary logic, possible Omega, and non-empty `G`. Four historical refutation records document the deleted universal statements; the no-export and primitive-grounding negative guards prevent their accidental return.

## Attack-vector coverage

| # | Attack vector | Public mechanism |
|---:|---|---|
| 1 | Placeholder or `sorryAx` leakage | Clean Lean build plus `#print axioms`; CI rejects `sorryAx` in public audit output. |
| 2 | Explosion | The historical inconsistent extensional bundle remains isolated in `GroundingAudit`; the current C5 route ships a joint model. |
| 3 | Modal collapse | `box_not_identity`, `contingency_witness`, `certificate_not_trivial`, and `GroundingModel.m_not_collapsed`. |
| 4 | Circular grounding | C5 takes grounding as primitive and states only the required obtaining transmission through `GroundObtains`. |
| 5 | Infinite regress | C3 and `terminus_above`; the latter constructs a terminus by classical dependent witness selection. |
| 6 | Accidental private export | `NoExport_NecessaryExistence.lean` runs against the actually shipped public environment. |
| 7 | Namespace or private-module leakage | Explicit package allow-list plus forbidden path scan. |
| 8 | Artifact substitution | Two clean-build hash comparison and `dist/SHA256SUMS` verification. |
| 9 | Instance hijacking | `Positive.proper`, hostile positivity guards, and hostile frame guards. Gate 0 is PASS. |
| 10 | Notation spoofing | Public theorem types are printed from Lean's elaborated environment. |
| 11 | Axiom pollution | `PublicCertificateAudit` prints the public C5 terms and footprints; positivity is absent from them. |
| 12 | Question-begging premise | `GroundingChainAudit` refutes all four `Yields*` forms for each individual C5 premise. |
| 13 | Vacuous public derivation | `GroundingModel` satisfies the C5 context with genuine contingency and non-collapse. |
| 14 | Distribution leakage or drift | Explicit package allow-list, post-package leak scan, generated status, and document-sync checker. |
| 15 | HyperModal variable capture | Four axiom-free historical refutation records plus `NoExport_HyperModalLegacy.lean`. |
| 16 | Extensional grounding recreates forbidden edges | Primitive `G`, `Reject_NecGroundedInAnything.lean`, and the inhabited setting witness. |
| 17 | Certificate artifact substitution or internal leakage | External repository pins, exact ten-file allow-lists, plain-mode kernel replay, source rebuild byte comparison, and forbidden-symbol scans for every discovered bundle. |
| 18 | A verification command silently omits a route | `verify-published.sh` discovers every shipped `.olean` and every `*-release` bundle, then verifies all of them or exits non-zero. |

## Release policy

The release flow is:

1. clean public Lean build;
2. public theorem and model audit;
3. all negative guards;
4. second clean build and byte-for-byte public assembly comparison;
5. explicit package allow-list staging;
6. generated `formal-status.json` and `FORMAL_STATUS.md`;
7. document-sync check;
8. SHA-256 manifest generation and verification;
9. post-package leak scan in the shipped environment.
10. verify every discovered certificate bundle through the externally pinned kernel-replay and rebuild-comparison stage;
11. verify all shipped `dist` assemblies through the same route-agnostic one-command consumer.

The post-package leak scan checks both paths and `.olean` strings for forbidden private names and then repeats the no-export test from `dist/`. No recursive “copy every `.olean`” rule exists.

## Formal status

The machine-generated status contains the exact Lean theorem types, axiom footprints, toolchain, Git commit, public assembly hashes, gate results, audit date, private-route disclosure status, and auditor verdict. Lean/CI output is the source of truth. The independent auditor verdict remains `PENDING_INDEPENDENT_REVIEW` until an external rerun is supplied.

## Final statement

The public package kernel-verifies and reproduces the C5 strong Omega route relative to its explicit premise context. The model establishes non-vacuity of that public context. The clean-room Successor and TI releases disclose only their abstract contracts, models, consequences, and certificates; they disclose neither internal implementation nor the concrete Jump. The TI certificate proves finite convergence and a unique fixed top only within its explicit contract and supplies no identity bridge to the C5 `Omega` predicate. Philosophical actuality of the premise context remains an argument of the paper rather than a Lean theorem.