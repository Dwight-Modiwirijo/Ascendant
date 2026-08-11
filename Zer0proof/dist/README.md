# Ascendant.Zero — Public Safety Certificate
## **Scope**

This repository publishes a *public verification surface* (Lean sources + build artifacts) and a small interface layer.
The intent is that third parties can rebuild the project and inspect the *exported* API.

The public export boundary is supported by `tests/NoExport_NecessaryExistence.lean`; `CertificateAudit.lean` inspects the exported declarations and their selected axiom footprints.

Compiled `.olean` artifacts are build-verifiable: rebuilds and hash checks can detect tampering or mismatches, but do not make tampering impossible. This certificate concerns the public API surface only; private proof routes and implementation details remain out of scope.

### Public □◇ compatibility layer

In S5 modal logic the following schema holds:

- **◇□p → □p**

Informally: *if it is possible that `p` is necessary, then `p` is necessary.*

The public interface exports

$$
\mathrm{Pos}(P) \to \Box\Diamond\exists x\,P(x).
$$

The strong Ω-theorems are carried by the private Alt Route.

### Public versus private result boundary

- **Public export:** `Pos(P) → □◇∃x P(x)` through `PosPossibility` and `ax_5`.
- **Private Alt Route:** kernel-verified `Final_NE_Proof` ($\Box\exists x\,\Omega(x)$), `Final_BoxUnique_Proof` ($\Box\exists!x\,\Omega(x)$), and `Final_RigidWitness_Proof` ($\exists x\,\Box\forall y\,(\Omega(y)\leftrightarrow y=x)$).

The limited public interface is an export boundary, not a reduction of the strong private theorem status.

### Kernel acceptance

Lean accepts a proof term inhabiting its exact theorem type. Public and private export boundaries determine disclosure scope; they do not alter kernel acceptance.

---
This document describes the **publicly verifiable safety guarantees** provided by the Ascendant.Zero Lean package.  
The goal of this README is precision: each attack vector is listed with its corresponding repository mechanism.


---

## Summary Table — Attack Vectors and Coverage

|  # | Attack Vector                           | Status           | Where it’s checked (File & Section)                                                                          |
| -: | --------------------------------------- | ---------------- | ------------------------------------------------------------------------------------------------------------ |
|  1 | `sorry` / placeholder leakage           | **Source/build audit** | Public Lean source and build artifacts are available for inspection and rebuild.                              |
|  2 | Logical explosion (*ex falso*)          | **Canary**       | `PublicTests.lean` exposes `exFalsoQuodlibet` as an explicit kernel-checked consequence of `False`.           |
|  3 | Triviality / “everything is true”       | **Model witness** | `TrivialModel` supplies the bare `Modal` K/T/4/5 witness.                                                   |
|  4 | Circular grounding                      | **Private route** | The private Alt Route carries the grounding construction; the public interface remains route-agnostic.       |
|  5 | Infinite regress                        | **Well-foundedness canary** | `PublicTests.lean` proves `WellFounded` for `Nat.lt`; the private successor/measure route supplies termination. |
|  6 | Accidental export of strong claims      | **Export guard** | `tests/NoExport_NecessaryExistence.lean` checks the intended public symbol boundary.                         |
|  7 | Namespace / symbol shadowing            | **Namespace boundary** | Public declarations are namespaced under `AltRoute` and inspected by `CertificateAudit.lean`.           |
|  8 | Artifact tampering (.olean spoofing)    | **Rebuild and hash checks** | `scripts/ci.sh` rebuilds, packages, and verifies SHA-256 sums.                                         |
|  9 | Instance hijacking                      | **Gate 0 hardening** | Gate 0 tracks the public `Positive`/`PosPossibility` instantiation boundary.                                |
| 10 | Notation spoofing                       | **Typed elaboration** | Lean checks elaborated terms rather than textual notation alone.                                             |
| 11 | Axiom pollution                         | **Axiom audit**  | `CertificateAudit.lean` prints selected global axiom footprints.                                              |
| 12 | Modal collapse                          | **Modal boundary** | The public API exports the `□◇` compatibility theorem; the strong Ω-theorems remain private.              |


---

### 7. Formal Refutation via Kernel-Checkable Contradiction

This is a repository **audit policy** for formal claims. A Lean-checkable contradiction under an explicit, declared context is a kernel-level refutation. Typical forms are:

* **Direct contradiction**
  A proof object of the form:

  ```lean
  claim → False
  ```

* **Context inconsistency**
  A proof that the union of:

  ```
  {declared axioms} ∪ {previous theorems} ∪ {claim}
  ```

  entails `False`, under the **same axiom footprint** and without introducing additional assumptions.

The declared theorem type, axioms, and hypotheses define the context of the refutation.

---
## Final Statement

The public Lean package certifies the exported API, model and canary artifacts, axiom footprints, and artifact-integrity checks. The private Alt Route carries the kernel-verified strong Ω-theorems. The public export boundary preserves the disclosure scope without altering their theorem status.
