# Zer0proof

Technical access point for the Alt Route Lean development and its public audit surface. The accompanying [paper](Paper.md) is authoritative for the argument, theorem status, and certification boundary.

## Verification boundary

W10 replaces the collapsed `Prop -> Prop` modal encoding with a world-indexed Kripke frame. The strong certificate assembly is deliberately deferred until that interface is final. Consequently, the exact new Lean types and footprints of the three strong declarations are not yet public facts and are not reconstructed here.

| Declaration | Current W10 certification status | Intended mathematical claim |
|---|---|---|
| `Final_NE_Proof` | Pending rebuild and `#print` from the real assembly | Necessary existence of an Ω-witness |
| `Final_BoxUnique_Proof` | Pending rebuild and `#print` from the real assembly | Necessary unique existence of an Ω-witness |
| `Final_RigidWitness_Proof` | Pending rebuild and `#print` from the real assembly | Existence of a rigid Ω-witness |

These rows are claim labels, not invented Lean signatures. `AltRoute.CertificateAudit` is the authority for the exact declaration types once `certificates/AltRoute/StrongCertificates.olean` has been rebuilt and supplied. The private `.lean` implementation is not required for that public binary audit.

## The grounding chain is public

The three Ω-results are derivable here, in this repository, from the constitutive chain of Paper §3.2. `AltRoute.GroundingChain` proves them:

| Theorem | Type | Axiom footprint |
|---|---|---|
| `C5_NE` | `Box (fun v => ∃x, Ω x v) w` | `propext, Classical.choice, Quot.sound` |
| `C5_BoxUnique` | `Box (fun v => ∃!x, Ω x v) w` | `propext, Classical.choice, Quot.sound` |
| `C5_RigidWitness` | `∃x, Box (fun v => ∀y, Ω y v ↔ y = x) w` | `propext, Classical.choice, Quot.sound` |

The premises are C1 (HM-PSR), C3 (anti-regress), C3a (necessity of the terminus), C4 (coalescence) and C4a (identity of Ω). Positivity is not among them: A2 plays no part in existence or uniqueness, as Paper §3 states. The existence of the terminus comes from C3 alone, by dependent choice. Grounding is primitive throughout; taken as a modal conditional it collapses the modality in one direction and trivialises in the other.

`AltRoute.GroundingModel` exhibits a two-world model satisfying C1, C2, C3, C3a, C4 and C4a together, with contingency present and the frame provably non-collapsed. The chain therefore terminates somewhere rather than everywhere.

Build it and read the footprints:

```bash
lake build
lake env lean AltRoute/GroundingChain.lean
lake env lean AltRoute/GroundingModel.lean
```

The private Alt Route is the convergent second route Paper §3.1 describes. It reaches the same three results through the successor construction of §2.2. Its assembly remains outstanding, and the chain above does not wait on it.

What the kernel settles is the derivation. Whether C1–C4a hold is Paper §2.1.1, which argues that they are the conditions of intelligible contingent obtaining. Denial falls under the same conditions, since denial is an intelligible act.

TI (Transcendental Induction) is a separate convergent route discussed only at the scope stated in Paper §3.3. Its internal construction is not published here.

## Public verification surface

`AltRoute.Interface` defines an S5 frame by an accessibility relation with reflexivity, transitivity, and symmetry:

```lean
Frame W
Frame.Box : (W -> Prop) -> W -> Prop
Frame.Dia : (W -> Prop) -> W -> Prop
```

`ax_T`, `ax_4`, `ax_5`, `K`, and Box/Dia duality are proved from those definitions and frame conditions; they are not fields supplied by callers. Public theorems use option (a): they quantify over every frame and selected world.

For `P : iota -> W -> Prop`, the compatibility theorem has the shape

```lean
Positive.Pos (fun x => P x w) ->
  F.Box (F.Dia (fun world => Exists fun x => P x world)) w
```

The domain type `iota` is fixed across worlds, so constant-domain semantics is enforced by the encoding. Positivity itself remains world-independent and is applied to the extension at `w`. This means `exists_of_positive` already yields actual existence at `w`; reflexivity and axiom 5 then lift it to possibility and necessary possibility. World-indexing repairs modal collapse, but it does not remove the MacIntosh/vacuity concern from this weak public positivity claim: the substantive existence premise still enters before the modal step.

`SomePosNecPossible` and `somePosNecPossible_of_exists` package the same public compatibility layer.

## Non-collapse evidence

`AltRoute.PublicTests` permanently checks six W10 obligations:

1. S5 laws are derived theorems.
2. Box/Dia duality is a theorem.
3. `box_not_identity` gives a two-world counterexample to universal Box collapse.
4. `contingency_witness` exhibits genuine contingency.
5. `certificate_not_trivial` refutes equivalence of `Box (Dia phi)` with `phi` at every world.
6. `TrivialModel` preserves and explicitly labels the degenerate one-world case where Box and Dia do collapse.

The non-degenerate witnesses use the universal accessibility relation on `Bool` and `BoolWitness world := world = true`.


## W11 grounding acceptance result

`AltRoute.TargetTypes` fixes the exact world-indexed target propositions and explicit `GroundingPremises` bundle before any strong assembly is accepted. `AltRoute.GroundingAudit` checks every premise field against all four forbidden `Yields*` shapes.

The anti-regress clause now uses `StrictGround`: the paper's extensional `Ground` relation is reflexive, whereas Paper §2.2 requires strict decrease along an anti-regress chain. Every individual premise field has a compiled countermodel with an empty Ω-domain, so no field by itself yields actual, possible, necessary, or possibly-necessary Ω-existence.

The combined C1/C2 core does not pass. With the paper's definitions:

```text
C1: Cont(p) -> Exists q, Nec(q) /\ Ground(q, p)
C2: Cont(I)
Ground(q, p): forall w, q(w) -> p(w)
```

`Nec(q)` supplies `q` at every world and `Ground(q,p)` then supplies `p` at every world, contradicting `Cont(p)`, which includes a reachable world satisfying `Not p`. Lean therefore proves `GroundingPremises F Omega I -> False` without axioms.

Consequently the NE, BoxUnique, BoxUnique-reductio, and rigid-witness obligations are formally derivable only by explosion from this jointly inconsistent C1/C2 bundle. They are published under explicit `*_from_inconsistent_bundle` audit names and are not strong certificates. CI rejects positivity-derived dependencies and no `Final_*` declaration or replacement assembly is fabricated.

`superlaw.lean` now imports `AltRoute.Interface`; its modal operators are direct aliases of `Frame.Box` and `Frame.Dia`. All 19 pre-existing theorem footprints remain unchanged.

## Certification labels

- **Kernel-verified:** a Lean proof object inhabits its exact theorem type relative to the declaration's axioms and hypotheses.
- **Publicly certified:** published signatures, manifests, and audit mechanisms can be inspected.
- **Publicly reproducible:** a third party can independently reproduce the particular source build or artifact.

The public world-indexed interface is source-reproducible. The strong certificate remains pending until the real source-free assembly and its dependency closure are supplied; no placeholder is accepted.

## Theorem type and dependencies

Keep the exact theorem object and its derivation context distinct:

$$
t : \varphi \qquad\text{and}\qquad \Gamma \vdash \varphi.
$$

`#print axioms` reports global entries in Lean's axiom registry. It does not replace a theorem type or list explicit parameters carried in that type.

| Declaration | W10 footprint |
|---|---|
| `Final_NE_Proof` | Pending real assembly rebuild and inspection |
| `Final_BoxUnique_Proof` | Pending real assembly rebuild and inspection |
| `Final_RigidWitness_Proof` | Pending real assembly rebuild and inspection |

The public footprint table is emitted by `AltRoute.PublicTests` and `AltRoute.PublicCertificateAudit`. The constructive frame laws are axiom-free; duality and the positivity-to-existence chain use Lean's standard classical axioms where reported by `#print axioms`.

## Audit model

The audit architecture tracks placeholder leakage, explosion, triviality, circularity, infinite regress, accidental stronger exports, namespace shadowing, artifact substitution, instance hijacking, notation spoofing, axiom pollution, and modal collapse.

The hostile frame tests reject a non-symmetric preorder, both by omitted `symm` field and by the impossible forced proof. The no-export test confirms the strong names are unavailable from the public source interface. `box_not_identity`, `contingency_witness`, and `certificate_not_trivial` are constructive guards against recurrence of the old modal collapse.

## Build and verify

The pinned Lean toolchain is declared in `lean-toolchain`; the package and pinned mathlib dependency are declared in `lakefile.lean`.

```bash
cd Zer0proof
lake clean
lake build
lake -R env lean AltRoute/PublicTests.lean
lake -R env lean AltRoute/PublicCertificateAudit.lean
bash scripts/ci.sh
```

`scripts/ci.sh` performs a clean public build, verifies all negative sentinels, then fails closed with exit code 2 while the real strong assembly or provenance manifest is absent. If the bundle is supplied, CI verifies its hashes before installation and audit, then creates the ignored `dist/` output.

## Disclosure

The public repository exposes the interface, public tests, certificate audits, and build configuration. Generated `dist/` output is intentionally untracked. The source of the private strong proof construction may remain confidential; the compiled declarations and their dependencies are the intended public certification surface.
