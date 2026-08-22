# Ascendant.Zero — Public Safety Certificate

## Scope

This repository publishes a source-reproducible public verification route. It includes the world-indexed S5 interface, the C5 grounding theorems, the individual-premise audit, a joint non-collapsed model, negative guards, and an explicitly allow-listed distribution.

Compiled `.olean` files carry theorem declarations and proof terms. They support rebuild and integrity checks, but they are not an IP disclosure boundary. The private successor route is not distributed as source or theorem-bearing `.olean`; public kernel assurance for the strong Omega claims is supplied independently by `AscendantRoute.GroundingChain.C5_*`.

No public claim is made about the current internal build status of private `Final_*` declarations. Such a status requires separate non-public evidence and independent audit.

## Modal semantics

The public interface defines an S5 Kripke `Frame` with an accessibility relation, reflexivity, transitivity, and symmetry. `Box` and `Dia` are definitions over world-indexed propositions. T, 4, 5, K, duality, and actual-to-possible are derived theorems. `HyperModal.lean` imports the same interface, so there is one shared modal semantics.

## Public result boundary

- **Public compatibility API:** `necPossible_of_Pos`, a weak `Box (Dia ...)` result.
- **Public C5 grounding route:** `C5_NE`, `C5_BoxUnique`, and `C5_RigidWitness`, each with footprint `propext, Classical.choice, Quot.sound`.
- **Private successor route:** independent internal work, not distributed and not part of the public reproducibility claim.

The C5 theorem parameters expose C1, `GroundObtains`, C3, C4a, and the obtaining datum directly. Positivity is absent. `GroundingModel` jointly instantiates the premise chain in a non-collapsed two-world frame.

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

The post-package leak scan checks both paths and `.olean` strings for forbidden private names and then repeats the no-export test from `dist/`. No recursive “copy every `.olean`” rule exists.

## Formal status

The machine-generated status contains the exact Lean theorem types, axiom footprints, toolchain, Git commit, public assembly hashes, gate results, audit date, private-route disclosure status, and auditor verdict. Lean/CI output is the source of truth. The independent auditor verdict remains `PENDING_INDEPENDENT_REVIEW` until an external rerun is supplied.

## Final statement

The public package kernel-verifies and reproduces the C5 strong Omega route relative to its explicit premise context. The model establishes non-vacuity of that public context. The package discloses no private successor implementation or theorem-bearing private assembly. Philosophical actuality of the premise context remains an argument of the paper rather than a Lean theorem.