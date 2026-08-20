import AltRoute.GroundingAudit
import AltRoute.GroundingChain

/-!
W12 audit matrix for the actual C5 premise surface.

This module certifies that each load-bearing premise used by
`GroundingChain.C5_NE`, `C5_BoxUnique`, and `C5_RigidWitness` does not by
itself yield any of the four target shapes:

- actual Omega: `∃ x, Ω(x)`
- possible Omega: `◇∃ x, Ω(x)`
- necessary Omega: `□∃ x, Ω(x)`
- possible-necessary Omega: `◇□∃ x, Ω(x)`

Each theorem below gives an explicit model where one premise is true and the
individual domain is empty. Consequently that single premise alone entails
none of the four forbidden targets.
-/

namespace AltRoute.GroundingChainAudit

open AltRoute
open AltRoute.Target
open AltRoute.GroundingAudit
open AltRoute.GroundingChain

/-- The audited C5 premise names in this public package. -/
def W12_PremiseNames : List String := [
  "C1",
  "GroundObtains",
  "C3",
  "C4a",
  "datum_obtains"
]

/-- The audited target names for W12 question-begging. -/
def W12_TargetNames : List String := [
  "actual_omega",
  "possible_omega",
  "necessary_omega",
  "possible_necessary_omega"
]

/-- Exact audit manifest used by the formal status generator and CI. -/
def W12_PremiseAuditManifest : List (String × String) :=
  [
    ("C1", "AltRoute.GroundingChainAudit.c1_refutes_all"),
    ("GroundObtains", "AltRoute.GroundingChainAudit.ground_obtains_refutes_all"),
    ("C3", "AltRoute.GroundingChainAudit.c3_refutes_all"),
    ("C4a", "AltRoute.GroundingChainAudit.c4a_refutes_all"),
    ("datum_obtains", "AltRoute.GroundingChainAudit.datum_obtains_refutes_all")
  ]

def NoGround (_ _ : Unit -> Prop) : Prop := False

def AllGround (_ _ : Unit -> Prop) : Prop := True

theorem unit_no_contingency (p : Unit -> Prop) : Not (GroundingChain.Cont UnitFrame p) := by
  rintro ⟨_, ⟨x, _, hpx⟩, ⟨y, _, hny⟩⟩
  cases x
  cases y
  exact hny hpx

theorem unit_c1 : GroundingChain.C1 UnitFrame NoGround := by
  intro p hCont
  exact (unit_no_contingency p hCont).elim

theorem unit_ground_obtains : GroundObtains NoGround := by
  intro _ _ hGround
  exact hGround.elim

theorem unit_c3 : GroundingChain.C3 NoGround := by
  rintro ⟨_, hChain⟩
  exact hChain 0

theorem all_ground_no_terminus (q : Unit -> Prop) :
    Not (Terminus AllGround q) := by
  intro hTerminus
  exact hTerminus ⟨q, trivial⟩

theorem empty_c4a :
    C4a AllGround (EmptyOmega (W := Unit)) where
  identity := by
    intro world
    constructor
    · rintro ⟨x, _⟩
      exact x.elim
    · rintro ⟨q, hTerminus, hq⟩
      exact (all_ground_no_terminus q hTerminus).elim
  unique := by
    intro _ x
    exact x.elim
  rigid := by
    intro x
    exact x.elim

def UnitDatum (_ : Unit) : Prop := True

theorem unit_datum_obtains : UnitDatum () := trivial

theorem c1_refutes_all :
    RefutesAllYields UnitFrame (EmptyOmega (W := Unit))
      (GroundingChain.C1 UnitFrame NoGround) :=
  emptyOmega_refutes_all UnitFrame () _ unit_c1

theorem ground_obtains_refutes_all :
    RefutesAllYields UnitFrame (EmptyOmega (W := Unit))
      (GroundObtains NoGround) :=
  emptyOmega_refutes_all UnitFrame () _ unit_ground_obtains

theorem c3_refutes_all :
    RefutesAllYields UnitFrame (EmptyOmega (W := Unit))
      (GroundingChain.C3 NoGround) :=
  emptyOmega_refutes_all UnitFrame () _ unit_c3

theorem c4a_refutes_all :
    RefutesAllYields UnitFrame (EmptyOmega (W := Unit))
      (C4a AllGround (EmptyOmega (W := Unit))) :=
  emptyOmega_refutes_all UnitFrame () _ empty_c4a

theorem datum_obtains_refutes_all :
    RefutesAllYields UnitFrame (EmptyOmega (W := Unit)) (UnitDatum ()) :=
  emptyOmega_refutes_all UnitFrame () _ unit_datum_obtains

theorem c1_not_actual :
    Not (YieldsActualOmega (EmptyOmega (W := Unit)) (GroundingChain.C1 UnitFrame NoGround)) :=
  (c1_refutes_all).1

theorem c1_not_possible :
    Not (YieldsPossibleOmega UnitFrame (EmptyOmega (W := Unit))
      (GroundingChain.C1 UnitFrame NoGround)) :=
  (c1_refutes_all).2.1

theorem c1_not_necessary :
    Not (YieldsNecessaryOmega UnitFrame (EmptyOmega (W := Unit))
      (GroundingChain.C1 UnitFrame NoGround)) :=
  (c1_refutes_all).2.2.1

theorem c1_not_possible_necessary :
    Not (YieldsPossibleNecessaryOmega UnitFrame (EmptyOmega (W := Unit))
      (GroundingChain.C1 UnitFrame NoGround)) :=
  (c1_refutes_all).2.2.2

theorem ground_obtains_not_actual :
    Not (YieldsActualOmega (EmptyOmega (W := Unit)) (GroundObtains NoGround)) :=
  (ground_obtains_refutes_all).1

theorem ground_obtains_not_possible :
    Not (YieldsPossibleOmega UnitFrame (EmptyOmega (W := Unit)) (GroundObtains NoGround)) :=
  (ground_obtains_refutes_all).2.1

theorem ground_obtains_not_necessary :
    Not (YieldsNecessaryOmega UnitFrame (EmptyOmega (W := Unit)) (GroundObtains NoGround)) :=
  (ground_obtains_refutes_all).2.2.1

theorem ground_obtains_not_possible_necessary :
    Not (YieldsPossibleNecessaryOmega UnitFrame (EmptyOmega (W := Unit)) (GroundObtains NoGround)) :=
  (ground_obtains_refutes_all).2.2.2

theorem c3_not_actual :
    Not (YieldsActualOmega (EmptyOmega (W := Unit)) (GroundingChain.C3 NoGround)) :=
  (c3_refutes_all).1

theorem c3_not_possible :
    Not (YieldsPossibleOmega UnitFrame (EmptyOmega (W := Unit)) (GroundingChain.C3 NoGround)) :=
  (c3_refutes_all).2.1

theorem c3_not_necessary :
    Not (YieldsNecessaryOmega UnitFrame (EmptyOmega (W := Unit)) (GroundingChain.C3 NoGround)) :=
  (c3_refutes_all).2.2.1

theorem c3_not_possible_necessary :
    Not (YieldsPossibleNecessaryOmega UnitFrame (EmptyOmega (W := Unit)) (GroundingChain.C3 NoGround)) :=
  (c3_refutes_all).2.2.2

theorem c4a_not_actual :
    Not (YieldsActualOmega (EmptyOmega (W := Unit)) (C4a AllGround (EmptyOmega (W := Unit)))) :=
  (c4a_refutes_all).1

theorem c4a_not_possible :
    Not (YieldsPossibleOmega UnitFrame (EmptyOmega (W := Unit))
      (C4a AllGround (EmptyOmega (W := Unit)))) :=
  (c4a_refutes_all).2.1

theorem c4a_not_necessary :
    Not (YieldsNecessaryOmega UnitFrame (EmptyOmega (W := Unit))
      (C4a AllGround (EmptyOmega (W := Unit)))) :=
  (c4a_refutes_all).2.2.1

theorem c4a_not_possible_necessary :
    Not (YieldsPossibleNecessaryOmega UnitFrame (EmptyOmega (W := Unit))
      (C4a AllGround (EmptyOmega (W := Unit)))) :=
  (c4a_refutes_all).2.2.2

theorem datum_not_actual :
    Not (YieldsActualOmega (EmptyOmega (W := Unit)) (UnitDatum ())) :=
  (datum_obtains_refutes_all).1

theorem datum_not_possible :
    Not (YieldsPossibleOmega UnitFrame (EmptyOmega (W := Unit)) (UnitDatum ())) :=
  (datum_obtains_refutes_all).2.1

theorem datum_not_necessary :
    Not (YieldsNecessaryOmega UnitFrame (EmptyOmega (W := Unit)) (UnitDatum ())) :=
  (datum_obtains_refutes_all).2.2.1

theorem datum_not_possible_necessary :
    Not (YieldsPossibleNecessaryOmega UnitFrame (EmptyOmega (W := Unit)) (UnitDatum ())) :=
  (datum_obtains_refutes_all).2.2.2

#print axioms c1_not_actual
#print axioms c1_not_possible
#print axioms c1_not_necessary
#print axioms c1_not_possible_necessary
#print axioms ground_obtains_not_actual
#print axioms ground_obtains_not_possible
#print axioms ground_obtains_not_necessary
#print axioms ground_obtains_not_possible_necessary
#print axioms c3_not_actual
#print axioms c3_not_possible
#print axioms c3_not_necessary
#print axioms c3_not_possible_necessary
#print axioms c4a_not_actual
#print axioms c4a_not_possible
#print axioms c4a_not_necessary
#print axioms c4a_not_possible_necessary
#print axioms datum_not_actual
#print axioms datum_not_possible
#print axioms datum_not_necessary
#print axioms datum_not_possible_necessary
#print axioms c1_refutes_all
#print axioms ground_obtains_refutes_all
#print axioms c3_refutes_all
#print axioms c4a_refutes_all
#print axioms datum_obtains_refutes_all

end AltRoute.GroundingChainAudit

