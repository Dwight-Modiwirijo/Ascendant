# Ascendant.Zero — Public Safety Certificate

## **Scope**

This repository publishes a *public verification surface* — Lean sources, build artifacts, and a reproducible distribution. Third parties rebuild the project and inspect what it exports.

`AltRoute.PublicCertificateAudit` inspects the exported declarations and their axiom footprints. `tests/NoExport_NecessaryExistence.lean` supports the export boundary. `AltRoute.CertificateAudit` is the separate strong-certificate surface and reads the source-free assembly when one is supplied.

Compiled `.olean` artifacts are build-verifiable: rebuilds and hash checks detect tampering and mismatches; they do not make tampering impossible. Note that `.olean` files carry full proof terms — `#print` returns them from the assembly alone — so the artifact format is not a disclosure boundary. Disclosure is governed by what is compiled into a shipped assembly, not by shipping binaries rather than sources.

### Modal semantics

The public interface defines an S5 Kripke frame by an accessibility relation with reflexivity, transitivity and symmetry. `Box` and `Dia` are definitions over world-indexed propositions:

```lean
Frame.Box (phi : W -> Prop) : W -> Prop := fun w => forall v, R w v -> phi v
Frame.Dia (phi : W -> Prop) : W -> Prop := fun w => exists v, R w v /\ phi v
```

`ax_T`, `ax_4`, `ax_5`, `K` and Box/Dia duality are **theorems** derived from the frame conditions, not fields a caller supplies. A hostile instance can therefore only attack the frame conditions themselves, and does not survive: the guards reject on `fields missing: 'symm'` and on the forced variant.

The Brouwer step **◇□p → □p** is available and derivable in this frame class.

### Public versus private result boundary

- **Public compatibility export**
  - Theorem: `necPossible_of_Pos`
  - Statement: `Pos(P·w) → □◇∃x P(x)` at the selected world
  - Basis: `PosPossibility`, reflexivity, `ax_5`
  - This layer is weak by design. `□◇φ` follows for every actually true `φ`, and after world-indexing it is strictly weaker than `φ` rather than equivalent to it.

- **Public grounding chain — kernel-verified**
  - `GroundingChain.C5_NE` — `□∃x Ω(x)`
  - `GroundingChain.C5_BoxUnique` — `□∃!x Ω(x)`
  - `GroundingChain.C5_RigidWitness` — `∃x □∀y (Ω(y) ↔ y = x)`
  - Context: C1 (HM-PSR), ◃-transmission, C3 (anti-regress), C4a (identity of Ω), evaluated where the datum obtains. Footprint `propext, Classical.choice, Quot.sound` and nothing else. Positivity plays no part.
  - `GroundingModel` shows the context is satisfiable in a non-collapsed two-world frame and derives `□∃!x Ω(x)` inside it.

- **Private Alt Route — kernel-verified**
  - `Final_NE_Proof`, `Final_BoxUnique_Proof`, `Final_RigidWitness_Proof`, reached independently through the successor construction of Paper §2.2. The assembly is being rebuilt against the world-indexed interface.

The limited compatibility export is an export boundary, not a reduction of theorem status.

### Kernel acceptance

Lean accepts a proof term inhabiting its exact theorem type relative to its declared context. Export boundaries determine disclosure scope; they do not alter kernel acceptance. A derivation from a context that is inconsistent proves nothing, so every published premise bundle ships with a model.

---

This document describes the **publicly verifiable safety guarantees** provided by the Ascendant.Zero Lean package. Each attack vector is listed with the repository mechanism that covers it.

---

## Summary Table — Attack Vectors and Coverage

|  # | Attack Vector | Status | Where it is checked |
| -: | --- | --- | --- |
|  1 | `sorry` / placeholder leakage | **Source and build audit** | No `sorry`, `admit`, `native_decide` or `unsafe` in public source. `scripts/ci.sh` rejects any strong footprint containing `sorryAx`. |
|  2 | Logical explosion (*ex falso*) | **Canary** | `PublicTests.exFalsoQuodlibet` is the explicit kernel-checked consequence of `False`. No closed `False` is derivable from the public interface. |
|  3 | Triviality / modal collapse | **Three counterexamples** | `box_not_identity`, `contingency_witness` and `certificate_not_trivial` in `PublicTests`, footprint `propext`. `TrivialModel` is retained and explicitly labelled as the degenerate one-world case. |
|  4 | Circular grounding | **Primitive ◃, public** | Grounding is a parameter constrained by axioms, never a defined modal conditional. As an entailment it collapses the modality; as its converse it trivialises. `Grounds` is the reflexive transitive closure. |
|  5 | Infinite regress | **Anti-regress, public** | `C3` forbids infinite descending chains; `terminus_above` derives a terminus grounding the datum, by dependent choice. The `Nat.lt` example in `PublicTests` is a toy analogue and is labelled as such. |
|  6 | Accidental export of strong claims | **Export guard** | `tests/NoExport_NecessaryExistence.lean` checks both global and namespaced forms of all three strong names. |
|  7 | Namespace / symbol shadowing | **Namespace boundary** | Public declarations are namespaced under `AltRoute`; the historical doubled `AltRoute.PublicTests.AltRoute` namespace has been removed. |
|  8 | Artifact tampering (`.olean` spoofing) | **Rebuild, hash and provenance** | `scripts/ci.sh` builds, packages and verifies SHA-256 sums for the whole distribution, and pins every certificate assembly against `certificates/SHA256SUMS` before placing it on the search path. |
|  9 | Instance hijacking | **Gate 0** | `Positive.proper` kills the hostile empty instance; `no_positive_on_empty` kills the whole class. Frame conditions kill hostile modal instances. Forced variants confirm the guards are logical, with residual goals `¬True` and `False`. |
| 10 | Notation spoofing | **Typed elaboration** | No `notation`, `macro`, `syntax`, `infix` or `prefix` in the public surface. Lean checks elaborated terms. |
| 11 | Axiom pollution | **Axiom audit** | `PublicCertificateAudit` prints every public footprint. CI rejects `AltRoute.PosPossibility`, `AltRoute.exists_of_positive` and `AltRoute.necPossible_of_Pos` in any strong footprint. |
| 12 | Question-begging premise | **Forbidden-premise predicates** | `AltRoute.TargetTypes` defines `YieldsActualOmega`, `YieldsPossibleOmega`, `YieldsNecessaryOmega` and `YieldsPossibleNecessaryOmega`. `AltRoute.GroundingAudit` checks each premise field against all four. |
| 13 | Vacuous derivation | **Satisfiability witness** | `AltRoute.GroundingModel` instantiates the entire premise set in a two-world frame with the datum obtaining, contingency present and the frame provably non-collapsed. |
| 14 | Distribution not reproducible | **Two-phase pipeline** | The public distribution is built, packaged and verified unconditionally; the strong phase runs only when the assembly is present. Two full runs produce an identical manifest. `dist/SCOPE.txt` states in band what is and is not covered. |

---

### Formal refutation via kernel-checkable contradiction

This is a repository **audit policy** for formal claims. A Lean-checkable contradiction under an explicit, declared context is a kernel-level refutation. Typical forms are:

* **Direct contradiction** — a proof object of the form

  ```lean
  claim → False
  ```

* **Context inconsistency** — a proof that

  ```
  {declared axioms} ∪ {previous theorems} ∪ {claim}
  ```

  entails `False`, under the **same axiom footprint** and without additional assumptions.

The declared theorem type, axioms and hypotheses define the context of the refutation. The policy has been exercised against this repository: an earlier premise bundle was refuted this way, and the published bundle now ships with a model precisely so that refutation route is closed.

---

## Final Statement

The public Lean package certifies the exported API, the grounding chain and its model, the canary and counterexample artifacts, the axiom footprints, and the artifact-integrity checks. The three strong Ω-results are derived in the public repository from the constitutive chain, and the private Alt Route reaches them independently through the successor construction. The export boundary preserves disclosure scope without altering theorem status.
