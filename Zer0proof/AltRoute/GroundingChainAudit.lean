import AltRoute.GroundingAudit
import AltRoute.GroundingChain

/-!
Mechanical non-question-begging audit for the premise surface consumed by
`GroundingChain.C5_NE`, `C5_BoxUnique`, and `C5_RigidWitness`.

Each theorem below gives a model in which one individual premise is true while
the individual domain is empty. Consequently that premise alone entails none
of the four forbidden Omega-existence shapes from `TargetTypes`.
-/

namespace AltRoute.GroundingChainAudit

open AltRoute
open AltRoute.Target
open AltRoute.GroundingAudit
open AltRoute.GroundingChain

def NoGround (_ _ : Unit -> Prop) : Prop := False

def AllGround (_ _ : Unit -> Prop) : Prop := True

theorem unit_no_contingency (p : Unit -> Prop) :
    Not (GroundingChain.Cont UnitFrame p) := by
  rintro ⟨_, ⟨x, _, hp⟩, ⟨y, _, hnp⟩⟩
  cases x
  cases y
  exact hnp hp

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
    · rintro ⟨q, hTerminus, _⟩
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

#print axioms c1_refutes_all
#print axioms ground_obtains_refutes_all
#print axioms c3_refutes_all
#print axioms c4a_refutes_all
#print axioms datum_obtains_refutes_all

end AltRoute.GroundingChainAudit