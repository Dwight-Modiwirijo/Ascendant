/-
  AltRoute/TargetTypes.lean

  PUBLIC TARGET AND AUDIT VOCABULARY. Statements only.

  This file contains NO proofs, NO axioms and NO `sorry`. It fixes three
  strong conclusion types, an explicit premise bundle, and the forbidden
  one-premise consequence shapes used by the public audits. It deliberately
  declares no certificate theorem. Publishing the target vocabulary makes
  type and premise comparisons mechanical rather than a matter of judgement.

  Sources, quoted by section rather than reproduced:
    * Paper 2.1   — A1 (HM-PSR), A3 (Anti-Regress), A5 (Meta-Logical Closure)
    * Paper 3.2   — C1..C7, the compressed constitutive derivation
    * Paper 3     — "the positivity schema (A2) ... is not required for the
                     existence or uniqueness of Omega"

  That last sentence is the sharpest acceptance criterion in the whole paper,
  and it is the paper's own. See `AUDIT CHECKLIST` at the bottom.
-/
import AltRoute.Interface

namespace AltRoute.Target

universe u v

variable {W : Type u} {D : Type v}

/-! ## 1. Vocabulary, world-indexed, defined only from `Frame` -/

/-- `q` is necessary: it holds at every world of the frame. -/
def Nec (F : Frame W) (q : W -> Prop) : Prop :=
  forall w, F.Box q w

/-- Contingency, Paper 2.1: possible and possibly-not, at some world. -/
def Cont (F : Frame W) (p : W -> Prop) : Prop :=
  Exists fun w => F.Dia p w /\ F.Dia (fun v => Not (p v)) w

/-- Grounding `q ◃ p`, Paper 2.1 / A.6 `ground`, transposed to `Frame`. -/
def Ground (F : Frame W) (q p : W -> Prop) : Prop :=
  (forall w, q w -> p w) /\
  (forall w, q w -> F.Box (fun v => q v -> p v) w)

/-- A proper grounding step. `Ground` itself is reflexive, while Paper 2.2
    requires strict decrease along successor/anti-regress chains. -/
def StrictGround (F : Frame W) (q p : W -> Prop) : Prop :=
  Ground F q p /\ Not (forall w, q w <-> p w)

/-- A terminus: necessary, and grounded by nothing further. -/
def Terminus (F : Frame W) (q : W -> Prop) : Prop :=
  Nec F q /\ Not (Exists fun r => StrictGround F r q)

/-! ## 2. The three target types

These are fixed by Paper 3.1 and by `README.md`. They are not negotiable:
the strong certificates must inhabit exactly these, with `Box`/`Dia` being
`AltRoute.Frame.Box`/`AltRoute.Frame.Dia` and nothing else. -/

/-- Necessary-existence target: □∃x Ω(x), at the selected world. -/
def NE_Target (F : Frame W) (Omega : D -> W -> Prop) (w : W) : Prop :=
  F.Box (fun v => Exists fun x : D => Omega x v) w

/-- Uniqueness, spelled out so this file depends on nothing but core. -/
def UniqueAt (Omega : D -> W -> Prop) (v : W) : Prop :=
  Exists fun x : D => Omega x v /\ forall y : D, Omega y v -> y = x

/-- Boxed-uniqueness target: □∃!x Ω(x). -/
def BoxUnique_Target (F : Frame W) (Omega : D -> W -> Prop) (w : W) : Prop :=
  F.Box (fun v => UniqueAt Omega v) w

/-- Rigid-witness target: ∃x □∀y (Ω(y) ↔ y = x). -/
def RigidWitness_Target (F : Frame W) (Omega : D -> W -> Prop) (w : W) : Prop :=
  Exists fun x : D =>
    F.Box (fun v => forall y : D, Omega y v <-> y = x) w

/-! ## 3. The permitted premise bundle

Paper 3.2 C1..C4 plus C6. Every field is an explicit hypothesis, so
`#print` on any theorem taking this bundle displays the entire input.
No field may be strengthened into Omega-existence: see 4.

`coalescence` is the AltRoute minimality condition of Paper 2.2.2 (C4).
`terminus_is_Omega` is C6 read as a *definition* of the Omega predicate --
it says Omega denotes the terminus, not that a terminus exists. -/
structure GroundingPremises (F : Frame W) (Omega : D -> W -> Prop)
    (I : W -> Prop) : Prop where
  /-- C2: the datum. "I am" obtains contingently. -/
  datum_contingent : Cont F I
  /-- C1 / A1: every contingent truth has a necessary ground. -/
  hm_psr : forall p : W -> Prop, Cont F p ->
    Exists fun q : W -> Prop => Nec F q /\ Ground F q p
  /-- C3 / A3: no infinite strictly descending grounding chain. -/
  anti_regress : Not (Exists fun f : Nat -> (W -> Prop) =>
    forall n : Nat, StrictGround F (f (n + 1)) (f n))
  /-- C4: terminating chains converge to a single minimal endpoint. -/
  coalescence : forall q1 q2 : W -> Prop,
    Terminus F q1 -> Terminus F q2 -> forall w, q1 w <-> q2 w
  /-- C6: `Omega` denotes the terminus. Denotation only, no existence claim. -/
  terminus_is_Omega : forall w,
    (Exists fun x : D => Omega x w) <->
      Exists fun q : W -> Prop => Terminus F q /\ q w

/-! ## 4. Forbidden premise shapes

A premise is question-begging exactly when it already delivers the conclusion.
These predicates make that mechanically checkable rather than a matter of
opinion: for each hypothesis `H` of a strong certificate, the audit asks
whether `H` inhabits one of these. -/

/-- `H` already yields actual Omega-existence at every world. -/
def YieldsActualOmega (Omega : D -> W -> Prop) (H : Prop) : Prop :=
  H -> forall w : W, Exists fun x : D => Omega x w

/-- `H` already yields possible Omega-existence. -/
def YieldsPossibleOmega (F : Frame W) (Omega : D -> W -> Prop) (H : Prop) : Prop :=
  H -> forall w : W, F.Dia (fun v => Exists fun x : D => Omega x v) w

/-- `H` already yields necessary Omega-existence -- the conclusion itself. -/
def YieldsNecessaryOmega (F : Frame W) (Omega : D -> W -> Prop) (H : Prop) : Prop :=
  H -> forall w : W, NE_Target F Omega w

/-- `H` already yields possible necessary Omega-existence; under S5 this is
    equivalent to the conclusion, so it is forbidden too. -/
def YieldsPossibleNecessaryOmega (F : Frame W) (Omega : D -> W -> Prop)
    (H : Prop) : Prop :=
  H -> forall w : W, F.Dia (fun v => NE_Target F Omega v) w

/-! ## 5. The obligations

These are the statements the strong bundle must discharge. Stated as `Prop`s,
deliberately unproved here. -/

/-- Direct form: the premise bundle alone yields necessary existence. -/
def Obligation_NE (F : Frame W) (Omega : D -> W -> Prop) (I : W -> Prop)
    (w : W) : Prop :=
  GroundingPremises F Omega I -> NE_Target F Omega w

/-- Direct form: the premise bundle alone yields necessary uniqueness. -/
def Obligation_BoxUnique (F : Frame W) (Omega : D -> W -> Prop) (I : W -> Prop)
    (w : W) : Prop :=
  GroundingPremises F Omega I -> BoxUnique_Target F Omega w

/-- Direct form: the premise bundle alone yields the rigid witness. -/
def Obligation_RigidWitness (F : Frame W) (Omega : D -> W -> Prop)
    (I : W -> Prop) (w : W) : Prop :=
  GroundingPremises F Omega I -> RigidWitness_Target F Omega w

/-- Reductio form, Paper 3: assuming the premise bundle and the negation of
    the conclusion yields absurdity. Equivalent to `Obligation_BoxUnique`
    classically; stated because it is the shape the paper argues in. -/
def Obligation_BoxUnique_Reductio (F : Frame W) (Omega : D -> W -> Prop)
    (I : W -> Prop) (w : W) : Prop :=
  GroundingPremises F Omega I -> Not (BoxUnique_Target F Omega w) -> False

/-! ## AUDIT CHECKLIST

Any theorem advertised as discharging these target obligations should satisfy
all of the following. Every item is mechanical.

1. TYPE. `#print <declaration>` shows a type defeq to the advertised target,
   with `Frame.Box`/`Frame.Dia` as the modal operators.

2. PREMISES VISIBLE. All hypotheses appear as explicit arguments in `#print`.
   No load-bearing premise hides inside a typeclass instance. This is the
   MacIntosh objection made checkable.

3. FOOTPRINT -- MUST CONTAIN. `#print axioms <declaration>` shows the
   grounding architecture: the A1 / A3 / minimality content, whether as
   axioms or as discharged hypotheses of `GroundingPremises`.

4. FOOTPRINT -- MUST NOT CONTAIN. None of:
     `AltRoute.PosPossibility`      (Paper 3: A2 is not required for NE/uniqueness)
     `HyperModal.perfect_being_exists`
     `HyperModal.consciousness_axiom`
     `sorryAx`
   Any of these present means the certificate assumes what it certifies.
   Positivity in particular: the paper states A2 is an interpretive
   strengthening, not a premise of existence or uniqueness. If it appears in
   the footprint, either the certificate or the paper is wrong.

5. NOT A CANARY. The footprint must not consist of exactly the one axiom
   being "refuted". That pattern -- `H.foo_reductio` depending only on
   `H.foo` -- is `A, ¬A ⊢ ⊥`, and every `*_reductio` in `superlaw.lean`
   currently has it. A real derivation shows the OTHER premises and not the
   conclusion.

6. NO FORBIDDEN PREMISE. For each hypothesis `H`, `YieldsActualOmega`,
   `YieldsPossibleOmega`, `YieldsNecessaryOmega` and
   `YieldsPossibleNecessaryOmega` must all be refutable, or `H` is
   question-begging.

7. NON-COLLAPSE PRESERVED. The certificate is typed against a `Frame` for
   which `box_not_identity` and `contingency_witness` still hold. A proof
   that only works in the one-world frame is not a proof.
-/

end AltRoute.Target
