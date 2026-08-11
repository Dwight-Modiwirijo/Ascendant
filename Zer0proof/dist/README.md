# Ascendant.Zero — Public Safety Certificate
## **Scope**

This repository publishes a *public verification surface* (Lean sources + build artifacts) and a small interface layer.
The intent is that third parties can rebuild the project and inspect the *exported* API.

Strong claims are outside the public module export boundary. A negative-guard source file exists at `tests/NoExport_NecessaryExistence.lean`; it is separate from `CertificateAudit.lean`, which performs only `#check` and `#print axioms` inspection.

Compiled `.olean` artifacts are build-verifiable: rebuilds and hash checks can detect tampering or mismatches, but do not make tampering impossible. This certificate concerns the public API surface only; private proof routes and implementation details remain out of scope.

### Public □◇ compatibility layer

In S5 modal logic the following schema holds:

- **◇□p → □p**

Informally: *if it is possible that `p` is necessary, then `p` is necessary.*

The public interface does not establish the antecedent `◇□p`. Its exported theorem is instead

$$
\operatorname{Pos}(P) \to \Box\Diamond\exists x\,P(x).
$$

This necessary-possibility compatibility statement does **not** imply `\Box\exists x\,P(x)` in S5. In particular, `\Box\Diamond p \to \Box p` is not an S5-valid schema.

### Public versus private result boundary

- **Public export:** `Pos(P) → □◇∃x P(x)` through `PosPossibility` and `ax_5`.
- **Private Alt Route:** kernel-verified proof terms for `□∃x Ω(x)`, `□∃!x Ω(x)`, and `∃x □∀y (Ω(y) ↔ y=x)`.

The limited public interface is an export boundary, not a reduction of the strong private theorem status.

#### Important Scope Note

The `Modal` interface exposes K, T, 4, and 5 as abstract axioms. T and 4 do not establish termination or convergence of grounding chains. The valid S5/Brouwer schema `◇□p → □p` is distinct from the public `□◇` result and is not invoked by `necPossible_of_Pos`.

### Intermezzo: Proof Semantics (BHK Interpretation)

Lean kernel acceptance establishes theoremhood of an exact type: $t : \varphi$. This is distinct from the derivation context $\Gamma \vdash \varphi$, the semantic consequence $\mathcal M \models \Gamma \to \mathcal M \models \varphi$, and the paper's intended-actuality thesis $\mathcal R \models \Gamma$. BHK/Curry–Howard characterizes proof objects and theoremhood within Lean; it does not itself make the ontological step from a proof object to actuality. Public export boundaries do not alter the kernel status of private proof terms.

---
This document describes the **publicly verifiable safety guarantees** provided by the Ascendant.Zero Lean package.  
The goal of this README is precision: each attack vector is listed together with **where** it is checked, **how strong** that check is, and **what is deliberately left out of the public surface**.


---

## Summary Table — Attack Vectors and Coverage

|  # | Attack Vector                           | Status           | Where it’s checked (File & Section)                                                                          |
| -: | --------------------------------------- | ---------------- | ------------------------------------------------------------------------------------------------------------ |
|  1 | `sorry` / placeholder leakage           | **Tracked**      | No `sorry`-specific check is performed by `CertificateAudit.lean` or the current `scripts/ci.sh`.             |
|  2 | Logical explosion (*ex falso*)          | **Audited**      | `PublicTests.lean` exposes the standard `exFalsoQuodlibet` lemma; it does not prove non-derivability of `False`. |
|  3 | Triviality / “everything is true”       | **Scoped witness** | `TrivialModel` witnesses only the bare `Modal` K/T/4/5 fragment.                                             |
|  4 | Circular grounding                      | **Out of public scope** | `Interface.lean` contains no full circular-grounding protection.                                         |
|  5 | Infinite regress                        | **Demonstration only** | `PublicTests.lean` proves well-foundedness for `Nat.lt`, not the full grounding context.                 |
|  6 | Accidental export of strong claims      | **Guard source present** | `tests/NoExport_NecessaryExistence.lean` is separate from `CertificateAudit.lean`; current CI does not run it. |
|  7 | Namespace / symbol shadowing            | **Scoped**       | Public declarations use `namespace AltRoute`; broader shadowing resistance is not certified here.             |
|  8 | Artifact tampering (.olean spoofing)    | **Detectable**   | Rebuild and SHA-256 verification in `scripts/ci.sh` can detect mismatches.                                   |
|  9 | Instance hijacking                      | **Tracked**      | `Positive` is a public typeclass; Gate 0 hardening addresses over-broad `PosPossibility` instantiation.       |
| 10 | Notation spoofing                       | **Scoped**       | Lean checks elaborated terms; no separate notation-spoofing audit is present.                                 |
| 11 | Axiom pollution                         | **Audited**      | `CertificateAudit.lean` prints selected global axiom footprints.                                              |
| 12 | Modal collapse                          | **Guarded by scope** | The exported result is `□◇`; no public theorem asserts `□◇p → □p`.                                       |


---

## Detailed Explanation

### 1. `sorry` / Placeholder Injection

**Threat**: Incomplete proofs silently bypass verification.

**Public status**: `CertificateAudit.lean` inspects exported declarations and global axiom footprints; it does not scan for placeholders. The current CI script builds and packages the distribution but does not contain a `sorry` gate.

**Strength**: Tracked, not a public prevention claim.

---

### 2. Logical Explosion (`ex falso quodlibet`)

**Threat**: If `False` becomes derivable, every proposition becomes provable.

**Mitigation**:

* `PublicTests.lean` exposes the standard theorem `exFalsoQuodlibet : False → P`.
* This makes the consequence of a proof of `False` explicit; it does not establish that `False` is unprovable from the complete context.

**Strength**: Audited canary artifact, not a non-explosion proof.

---

### 3. Triviality / Verum ex Quodlibet

**Threat**: The logic collapses so that all propositions become necessarily true.

**Mitigation**:

* `TrivialModel` (Box = Dia = identity) is a witness for the bare `Modal` K/T/4/5 fragment.

**Clarification**:

* It is not a model of the full Ω, `PosPossibility`, or grounding context.

**Strength**: Scoped modal-fragment witness, not full-context consistency certification.

---

### 4. Circular Grounding

**Threat**: Entities ground each other in cycles, invalidating grounding semantics.

**Public Status**: `Interface.lean` does not define or prove complete circular-grounding protection.

**Strength**: Out of the public certificate's scope.

---

### 5. Infinite Regress

**Threat**: Grounding chains never terminate, preventing convergence.

**Public Status**: `PublicTests.lean` demonstrates `WellFounded` for `Nat.lt`. This is an illustrative well-foundedness result, not a proof of termination or convergence for the public interface or the complete grounding context.

**Strength**: Demonstration only.

---

### 6. Accidental Export of Strong Existence Claims

**Threat**: Necessary-existence theorems become publicly derivable.

**Mitigation**:

* `tests/NoExport_NecessaryExistence.lean` is a negative-guard source that intentionally refers to a non-exported symbol.
* `CertificateAudit.lean` does not run this guard; it only checks known public declarations and prints axiom footprints. The current CI script does not invoke the negative target.

**Strength**: Guard source and export-boundary audit, not a current hard-CI claim.

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

Philosophical, semantic, probabilistic, and external critiques are not thereby invalid; they address questions outside kernel-level refutation, including the suitability of axioms, interpretations, and the intended-actuality thesis. They are simply not Lean kernel refutations unless encoded as such under a stated context.

---

### Audit-of-the-Audit Requirement

Lean refutation artifacts submitted for repository audit should be subject to the same applicable build and dependency inspection as other Lean changes.

Specifically, every refutation submission must:

* be **kernel-verifiable** by Lean,
* state their declared axioms and hypotheses,
* be kernel-checkable,
* identify any added assumptions or imports, and
* be assessed against the public audit scope described in this certificate.

---
## Verification & Audit Scope

Claims described as kernel-verified are validated by Lean 4 proof objects accepted by the kernel relative to their declared contexts. The public certificate audits only the exported surface and named public artifacts.

Assessment of correctness therefore presupposes the ability to:
- inspect Lean theorems and definitions,
- trace axiom usage and scope,
- verify correspondence between claims and exported proof objects.

Reviewers may assess presentation, interpretation, and philosophical implications independently of kernel-level formal validity.
### CertificateAudit

Lean kernel acceptance determines theoremhood within the declared formal context. The competencies below support assessment of that formal layer.
#### Required Competencies

1. **Reproducible Build**

   * Ability to build the repository from source without modification.
   * Verification that all exported Lean modules compile successfully.

2. **Claim–Theorem Correspondence**

   * Ability to map explicit claims in the paper to their corresponding Lean theorems.
   * Identification of module paths and namespaces for each referenced theorem.

3. **Axiom Footprint Analysis**

   * Ability to enumerate all axioms (explicit and transitive) on which a theorem depends.
   * Understanding of scope, imports, and potential classical dependencies.

4. **Export Boundary Inspection**

   * Ability to verify which theorems are publicly exported versus internally scoped.
   * Confirmation that no stronger claims are implicitly exposed.

5. **Guard and Failure Sensitivity**

   * Ability to interpret build or proof failures resulting from minimal changes.
   * Understanding of negative guards and intentional proof boundaries.
6. **Active Audit via Proof Contribution**
   Ability to submit Lean audit findings, including the addition or modification of Lean proof objects that:

   * refine or clarify existing claims,
   * demonstrate equivalence or non-equivalence of statements,
   * or formally encode objections as Lean-checkable artifacts.

   All audit claims must be expressible as Lean objects and be kernel-verifiable.
7. **Formal Refutation via Contradiction**
   Ability to demonstrate a kernel-level refutation by constructing a Lean-checkable contradiction such that:
     * the claim implies `False`, or
     * the claim is inconsistent with existing axioms or proven theorems under the same axiom footprint.

   Philosophical or semantic criticism remains relevant outside that kernel-level classification.
### Audit Scope Limitation

This is an object-based framework for formal claims: kernel-level refutations must be Lean-checkable (for example, `claim → False`) under a stated context. It does not classify non-formal philosophical or semantic criticism as automatically invalid.

---
## Final Statement

The public Lean package does **not** claim to prove everything.

It records the exported API, selected model and canary artifacts, and selected global axiom footprints. `TrivialModel` concerns only the bare modal fragment; Gate 0 and JointModel remain broader public-certification targets. The deliberate public export boundary does not alter the kernel-verified status of the private strong Alt Route theorems.
