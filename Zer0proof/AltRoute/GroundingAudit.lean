import AltRoute.TargetTypes

/-!
Mechanical W11 audit of the paper-level grounding premise bundle.

The declarations below are audit witnesses, not strong certificates. They show
both sides of the result honestly: every premise field is individually
satisfiable without any Omega witness, while C1 and C2 are jointly inconsistent
under the published extensional `Ground` definition.
-/

namespace AltRoute.GroundingAudit

open AltRoute
open AltRoute.Target

universe u v

/-- Extensional grounding is reflexive; strict descent must therefore be explicit. -/
theorem ground_refl {W : Type u} (F : Frame W) (q : W -> Prop) :
    Ground F q q := by
  constructor
  · intro _ hq
    exact hq
  · intro _ _ world _ hq
    exact hq

/-- A globally necessary extensional ground makes its consequence non-contingent. -/
theorem necessary_ground_excludes_contingency {W : Type u}
    (F : Frame W) (q p : W -> Prop) (hNec : Nec F q)
    (hGround : Ground F q p) : Not (Cont F p) := by
  rintro ⟨_, _, ⟨world, _, hNotP⟩⟩
  have hQ : q world := F.ax_T q world (hNec world)
  exact hNotP (hGround.1 world hQ)

/-- The delivered C1 and C2 fields cannot be jointly inhabited. -/
theorem premises_false {W : Type u} {D : Type v} (F : Frame W)
    (Omega : D -> W -> Prop) (I : W -> Prop)
    (h : GroundingPremises F Omega I) : False := by
  rcases h.hm_psr I h.datum_contingent with ⟨q, hNec, hGround⟩
  exact necessary_ground_excludes_contingency F q I hNec hGround h.datum_contingent

/-! ## W11.3 obligation attempts

These compile only because `GroundingPremises` is empty. They are deliberately
named as audit findings and must not be exported as `Final_*` certificates.
-/

theorem obligation_NE_from_inconsistent_bundle {W : Type u} {D : Type v}
    (F : Frame W) (Omega : D -> W -> Prop) (I : W -> Prop) (w : W) :
    Obligation_NE F Omega I w := by
  intro h
  exact (premises_false F Omega I h).elim

theorem obligation_BoxUnique_from_inconsistent_bundle
    {W : Type u} {D : Type v} (F : Frame W)
    (Omega : D -> W -> Prop) (I : W -> Prop) (w : W) :
    Obligation_BoxUnique F Omega I w := by
  intro h
  exact (premises_false F Omega I h).elim

theorem obligation_BoxUnique_Reductio_from_inconsistent_bundle
    {W : Type u} {D : Type v} (F : Frame W)
    (Omega : D -> W -> Prop) (I : W -> Prop) (w : W) :
    Obligation_BoxUnique_Reductio F Omega I w := by
  intro h
  exact (premises_false F Omega I h).elim

theorem obligation_RigidWitness_from_inconsistent_bundle
    {W : Type u} {D : Type v} (F : Frame W)
    (Omega : D -> W -> Prop) (I : W -> Prop) (w : W) :
    Obligation_RigidWitness F Omega I w := by
  intro h
  exact (premises_false F Omega I h).elim

/-! ## The jointly inconsistent core is a forbidden premise bundle -/

def C1C2Core {W : Type u} (F : Frame W) (I : W -> Prop) : Prop :=
  Cont F I /\
    (forall p : W -> Prop, Cont F p ->
      Exists fun q : W -> Prop => Nec F q /\ Ground F q p)

theorem c1c2_false {W : Type u} (F : Frame W) (I : W -> Prop) :
    C1C2Core F I -> False := by
  rintro ⟨hCont, hPsr⟩
  rcases hPsr I hCont with ⟨q, hNec, hGround⟩
  exact necessary_ground_excludes_contingency F q I hNec hGround hCont

theorem c1c2_yields_actual {W : Type u} {D : Type v} (F : Frame W)
    (Omega : D -> W -> Prop) (I : W -> Prop) :
    YieldsActualOmega Omega (C1C2Core F I) := by
  intro h
  exact (c1c2_false F I h).elim

theorem c1c2_yields_possible {W : Type u} {D : Type v} (F : Frame W)
    (Omega : D -> W -> Prop) (I : W -> Prop) :
    YieldsPossibleOmega F Omega (C1C2Core F I) := by
  intro h
  exact (c1c2_false F I h).elim

theorem c1c2_yields_necessary {W : Type u} {D : Type v} (F : Frame W)
    (Omega : D -> W -> Prop) (I : W -> Prop) :
    YieldsNecessaryOmega F Omega (C1C2Core F I) := by
  intro h
  exact (c1c2_false F I h).elim

theorem c1c2_yields_possible_necessary {W : Type u} {D : Type v}
    (F : Frame W) (Omega : D -> W -> Prop) (I : W -> Prop) :
    YieldsPossibleNecessaryOmega F Omega (C1C2Core F I) := by
  intro h
  exact (c1c2_false F I h).elim

/-! ## Countermodels for every individual premise field -/

def UnitFrame : Frame Unit where
  R := fun _ _ => True
  refl := by intro _; trivial
  trans := by intro _ _ _ _ _; trivial
  symm := by intro _ _ _; trivial

def BoolFrame : Frame Bool where
  R := fun _ _ => True
  refl := by intro _; trivial
  trans := by intro _ _ _ _ _; trivial
  symm := by intro _ _ _; trivial

def EmptyOmega {W : Type u} : Empty -> W -> Prop :=
  fun x => x.elim

def RefutesAllYields {W : Type u} {D : Type v} (F : Frame W)
    (Omega : D -> W -> Prop) (H : Prop) : Prop :=
  Not (YieldsActualOmega Omega H) /\
  Not (YieldsPossibleOmega F Omega H) /\
  Not (YieldsNecessaryOmega F Omega H) /\
  Not (YieldsPossibleNecessaryOmega F Omega H)

/-- Any inhabited frame with an empty individual domain refutes all four yields. -/
theorem emptyOmega_refutes_all {W : Type u} (F : Frame W) (w : W)
    (H : Prop) (hH : H) : RefutesAllYields F (EmptyOmega (W := W)) H := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro hYield
    rcases hYield hH w with ⟨x, _⟩
    exact x.elim
  · intro hYield
    rcases hYield hH w with ⟨_, _, x, _⟩
    exact x.elim
  · intro hYield
    have hAt := F.ax_T (fun world => Exists fun x : Empty =>
      EmptyOmega x world) w (hYield hH w)
    rcases hAt with ⟨x, _⟩
    exact x.elim
  · intro hYield
    rcases hYield hH w with ⟨world, _, hNecessary⟩
    have hAt := F.ax_T (fun target => Exists fun x : Empty =>
      EmptyOmega x target) world hNecessary
    rcases hAt with ⟨x, _⟩
    exact x.elim

/-! C2 / datum field. -/

def BoolDatum (world : Bool) : Prop := world = true

theorem bool_datum_contingent : Cont BoolFrame BoolDatum := by
  refine ⟨true, ?_, ?_⟩
  · exact ⟨true, trivial, rfl⟩
  · exact ⟨false, trivial, by simp [BoolDatum]⟩

theorem datum_field_refutes_all :
    RefutesAllYields BoolFrame (EmptyOmega (W := Bool))
      (Cont BoolFrame BoolDatum) :=
  emptyOmega_refutes_all BoolFrame true _ bool_datum_contingent

/-! C1 / HM-PSR field. It is vacuously satisfiable on a one-world frame. -/

theorem unit_no_contingency (p : Unit -> Prop) : Not (Cont UnitFrame p) := by
  rintro ⟨_, ⟨x, _, hP⟩, ⟨y, _, hNotP⟩⟩
  cases x
  cases y
  exact hNotP hP

def UnitHmPsr : Prop :=
  forall p : Unit -> Prop, Cont UnitFrame p ->
    Exists fun q : Unit -> Prop => Nec UnitFrame q /\ Ground UnitFrame q p

theorem unit_hm_psr : UnitHmPsr := by
  intro p hCont
  exact (unit_no_contingency p hCont).elim

theorem hm_psr_field_refutes_all :
    RefutesAllYields UnitFrame (EmptyOmega (W := Unit)) UnitHmPsr :=
  emptyOmega_refutes_all UnitFrame () _ unit_hm_psr

/-! C3 / strict anti-regress field. -/

def UnitAntiRegress : Prop :=
  Not (Exists fun f : Nat -> (Unit -> Prop) =>
    forall n : Nat, StrictGround UnitFrame (f (n + 1)) (f n))

theorem unit_anti_regress : UnitAntiRegress := by
  rintro ⟨f, hChain⟩
  have h0 := hChain 0
  have h1 := hChain 1
  have hF1False : Not (f 1 ()) := by
    intro hF1
    have hF0 : f 0 () := h0.1.1 () hF1
    apply h0.2
    intro world
    cases world
    exact ⟨fun _ => hF0, fun _ => hF1⟩
  have hF1True : f 1 () := by
    have hF2False : Not (f 2 ()) := by
      intro hF2
      exact hF1False (h1.1.1 () hF2)
    have hFalse : False := by
      apply h1.2
      intro world
      cases world
      constructor
      · intro hF2
        exact (hF2False hF2).elim
      · intro hF1
        exact (hF1False hF1).elim
    exact hFalse.elim
  exact hF1False hF1True

theorem anti_regress_field_refutes_all :
    RefutesAllYields UnitFrame (EmptyOmega (W := Unit)) UnitAntiRegress :=
  emptyOmega_refutes_all UnitFrame () _ unit_anti_regress

/-! C4 / coalescence field and C6 / terminus-denotation field. -/

theorem unit_no_terminus (q : Unit -> Prop) : Not (Terminus UnitFrame q) := by
  rintro ⟨hNec, hMinimal⟩
  have hQ : q () := hNec () () trivial
  apply hMinimal
  refine ⟨(fun _ : Unit => False), ?_⟩
  constructor
  · constructor
    · intro _ hFalse
      exact hFalse.elim
    · intro _ hFalse
      exact hFalse.elim
  · intro hEqual
    exact (hEqual ()).mpr hQ

def UnitCoalescence : Prop :=
  forall q1 q2 : Unit -> Prop,
    Terminus UnitFrame q1 -> Terminus UnitFrame q2 ->
      forall w, q1 w <-> q2 w

theorem unit_coalescence : UnitCoalescence := by
  intro q1 _ hTerminus
  exact (unit_no_terminus q1 hTerminus).elim

theorem coalescence_field_refutes_all :
    RefutesAllYields UnitFrame (EmptyOmega (W := Unit)) UnitCoalescence :=
  emptyOmega_refutes_all UnitFrame () _ unit_coalescence

def UnitTerminusIsOmega : Prop :=
  forall w : Unit,
    (Exists fun x : Empty => EmptyOmega x w) <->
      Exists fun q : Unit -> Prop => Terminus UnitFrame q /\ q w

theorem unit_terminus_is_omega : UnitTerminusIsOmega := by
  intro world
  cases world
  constructor
  · rintro ⟨x, _⟩
    exact x.elim
  · rintro ⟨q, hTerminus, _⟩
    exact (unit_no_terminus q hTerminus).elim

theorem terminus_is_Omega_field_refutes_all :
    RefutesAllYields UnitFrame (EmptyOmega (W := Unit))
      UnitTerminusIsOmega :=
  emptyOmega_refutes_all UnitFrame () _ unit_terminus_is_omega

/-! ## Acceptance and finding footprints -/

#print axioms AltRoute.Target.Nec
#print axioms AltRoute.Target.Cont
#print axioms AltRoute.Target.Ground
#print axioms AltRoute.Target.StrictGround
#print axioms AltRoute.Target.Terminus
#print axioms AltRoute.Target.NE_Target
#print axioms AltRoute.Target.UniqueAt
#print axioms AltRoute.Target.BoxUnique_Target
#print axioms AltRoute.Target.RigidWitness_Target
#print axioms AltRoute.Target.GroundingPremises
#print axioms AltRoute.Target.YieldsActualOmega
#print axioms AltRoute.Target.YieldsPossibleOmega
#print axioms AltRoute.Target.YieldsNecessaryOmega
#print axioms AltRoute.Target.YieldsPossibleNecessaryOmega
#print axioms AltRoute.Target.Obligation_NE
#print axioms AltRoute.Target.Obligation_BoxUnique
#print axioms AltRoute.Target.Obligation_RigidWitness
#print axioms AltRoute.Target.Obligation_BoxUnique_Reductio

#print axioms ground_refl
#print axioms necessary_ground_excludes_contingency
#print axioms premises_false
#print axioms obligation_NE_from_inconsistent_bundle
#print axioms obligation_BoxUnique_from_inconsistent_bundle
#print axioms obligation_BoxUnique_Reductio_from_inconsistent_bundle
#print axioms obligation_RigidWitness_from_inconsistent_bundle
#print axioms c1c2_yields_actual
#print axioms c1c2_yields_possible
#print axioms c1c2_yields_necessary
#print axioms c1c2_yields_possible_necessary
#print axioms datum_field_refutes_all
#print axioms hm_psr_field_refutes_all
#print axioms anti_regress_field_refutes_all
#print axioms coalescence_field_refutes_all
#print axioms terminus_is_Omega_field_refutes_all

end AltRoute.GroundingAudit
