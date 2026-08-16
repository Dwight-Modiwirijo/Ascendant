# Zer0proof

Technical access point for the Alt Route Lean development and its public audit surface. The accompanying [paper](Paper.md) is authoritative for the argument, theorem status, and certification boundary.

## Verification boundary

The private Alt Route contains Lean kernel-accepted proof terms for the following strong Ω-results:

| Declaration | Exact theorem type |
|---|---|
| `Final_NE_Proof` | $\Box\exists x\,\Omega(x)$ |
| `Final_BoxUnique_Proof` | $\Box\exists!x\,\Omega(x)$ |
| `Final_RigidWitness_Proof` | $\exists x\,\Box\forall y\,(\Omega(y)\leftrightarrow y=x)$ |

These are **kernel-verified** results of the private Alt Route: Lean accepts proof objects inhabiting the stated theorem types relative to their declared contexts. The private source is a disclosure and IP boundary; its non-public status does not change the status of those kernel-accepted proof terms. See Paper §4.1 and Appendix A.2.3.

TI (Transcendental Induction) is a separate convergent route discussed only at the scope stated in Paper §3.3. Its internal construction is not published here.

## Public Verification Surface

`AltRoute.Interface` deliberately exports a narrower compatibility/API layer. In particular, `necPossible_of_Pos` has the form

$$
\operatorname{Pos}(P) \to \Box\Diamond\exists x\,P(x),
$$

using `PosPossibility` and the S5-style axiom `ax_5`. `SomePosNecPossible` and `somePosNecPossible_of_exists` package the same public compatibility layer.

This is an **export boundary**, not a weakening of the strong private theorem status. The public API is intentionally limited; the private kernel route carries the strong Ω-results listed above. Public source and audit artifacts let a third party build and inspect the exported layer, not reconstruct the private proof construction.

## Certification labels

The repository follows the terminology of Paper §4.2:

- **Kernel-verified:** a Lean proof object inhabits its exact theorem type relative to the declaration's axioms and hypotheses.
- **Publicly certified:** published signatures, manifests, and audit mechanisms are inspectable and rebuildable to the extent that they are present in this repository.
- **Publicly reproducible:** a third party can independently reproduce the particular artifact or build at issue.

The private strong proof construction is kernel-verified but not publicly reproducible. The public interface and its build are publicly reproducible from the published source. Certification is not a claim that the private proof term is exported.

## Theorem type and dependencies

Keep the exact theorem object and its derivation context distinct:

$$
t : \varphi \qquad\text{and}\qquad \Gamma \vdash \varphi.
$$

`#print axioms` reports global entries in Lean's axiom registry. It does not replace the theorem type or report explicit hypotheses carried by a declaration; those must be read from the declaration/signature and dependency record. The following table records the historical, pre-hardening output reported by Paper Appendix A.2.3. The strong bundle has not been rebuilt against the hardened interface, so every value is pending re-derivation and is not a current public certificate.

| Declaration | Pre-hardening reported footprint (pending re-derivation) |
|---|---|
| `Final_NE_Proof` | `propext`, `PosPossibility` |
| `Final_BoxUnique_Proof` | `propext` |
| `Final_RigidWitness_Proof` | `propext` |

These historical footprints are dependency bookkeeping only. They must be replaced by fresh `#print axioms` output after the real strong bundle is rebuilt and loaded.

## Audit hardening

**Gate 0** is closed in the public interface by proper positivity and Box/Dia duality. Because that interface is load-bearing for the old reported `Final_NE_Proof` footprint, all strong footprints remain explicitly pending until the real certificate bundle is rebuilt. **JointModel** remains a separate full-context certification question.

## Audit Model

The audit architecture tracks the following attack vectors: `sorry`/placeholder leakage, logical explosion (`ex falso`), triviality, circular grounding, infinite regress, accidental stronger exports, namespace or symbol shadowing, `.olean` artifact tampering, instance hijacking, notation spoofing, axiom pollution, and modal collapse.

Current public artifacts provide scoped audit hooks: `AltRoute.PublicCertificateAudit` checks exported declarations and prints selected axiom footprints; `AltRoute.PublicTests.TrivialModel` is a model witness for the bare modal interface; and `AltRoute.PublicTests.exFalsoQuodlibet` is an explosion canary. `AltRoute.CertificateAudit` is the separate strong-certificate audit and imports the source-free `AltRoute.StrongCertificates` assembly. These artifacts are guards and audit inputs for their stated scope. They are not a blanket pass claim for the full private Ω-theory.

## Build and Verify

The pinned Lean toolchain is declared in `lean-toolchain`; the package and pinned mathlib dependency are declared in `lakefile.lean`.

```bash
cd Zer0proof
lake update
lake build

# Inspect the public compatibility declarations and selected axiom footprints.
lake env lean AltRoute/PublicCertificateAudit.lean

# With certificates/AltRoute/StrongCertificates.olean and its compiled
# dependency closure installed, inspect the strong theorem declarations.
lake env lean AltRoute/CertificateAudit.lean

# Rebuild and create the current distribution/hash package.
./scripts/ci.sh
```

`scripts/ci.sh` performs a clean public build, runs the hostile-instance and no-export guards, verifies the pinned certificate hashes, loads and audits the source-free strong bundle, and only then generates the ignored `dist/` CI output with `SHA256SUMS`. It fails closed when the assembly, dependency closure, or provenance manifest is absent.

## Disclosure

The public repository exposes the interface, public tests, certificate audit, and build configuration. Generated `dist/` output is intentionally not tracked; it can be published as a workflow or release artifact only after the real bundle passes CI. The source of the private strong proof construction is confidential and available to reviewers only through the repository's disclosure process.
