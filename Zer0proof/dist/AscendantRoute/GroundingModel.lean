import AscendantRoute.GroundingChain

namespace AscendantRoute.GroundingModel
open AscendantRoute AscendantRoute.GroundingChain

/-- Two worlds, universal accessibility. -/
def F : Frame Bool :=
{ R := fun _ _ => True, refl := fun _ => trivial,
  trans := fun _ _ _ _ _ => trivial, symm := fun _ _ _ => trivial }

/-- Primitive grounding: a necessary proposition grounds a non-necessary one. -/
def G (q p : Bool -> Prop) : Prop := (forall w, q w) /\ Not (forall w, p w)

/-- The datum: "I am", contingent, obtaining at `true`. -/
def I : Bool -> Prop := fun b => b = true

def Omega : Unit -> Bool -> Prop := fun _ _ => True

theorem m_datum_obtains : I true := rfl

theorem m_C2 : Cont F I :=
  ⟨true, ⟨true, trivial, rfl⟩, ⟨false, trivial, by intro h; exact Bool.noConfusion h⟩⟩

theorem m_C1 : C1 F G := by
  rintro p ⟨w, _, ⟨v, _, hnp⟩⟩
  exact ⟨fun _ => True, fun _ _ _ => trivial, ⟨fun _ => trivial, fun h => hnp (h v)⟩⟩

theorem m_GroundObtains : GroundObtains G := fun _ _ hG w _ => hG.1 w

theorem m_C3 : C3 G := by rintro ⟨f, hf⟩; exact (hf 1).2 (hf 0).1

theorem m_terminus_iff (q : Bool -> Prop) : Terminus G q <-> forall w, q w := by
  constructor
  · intro h
    exact Classical.byContradiction (fun hn => h ⟨fun _ => True, ⟨fun _ => trivial, hn⟩⟩)
  · rintro hall ⟨r, _, hnot⟩; exact hnot hall

theorem m_C4a : C4a G Omega where
  identity := fun w =>
    ⟨fun _ => ⟨fun _ => True, (m_terminus_iff _).mpr (fun _ => trivial), trivial⟩,
     fun _ => ⟨(), trivial⟩⟩
  unique := by intro _ x y _ _; cases x; cases y; rfl
  rigid := fun _ _ _ _ => trivial

/-- The frame is not collapsed: the premise set is not vacuously satisfied. -/
theorem m_not_collapsed : Not (forall q : Bool -> Prop, forall w, F.Box q w <-> q w) := by
  intro h
  exact absurd (((h (fun b => b = true) true).mpr rfl) false trivial)
    (by intro k; exact Bool.noConfusion k)

/-- The whole chain runs in this model. -/
theorem m_conclusion :
    F.Box (fun v => UniqueAt Omega v) true :=
  C5_BoxUnique F G Omega m_C1 m_GroundObtains m_C3 m_C4a I true m_datum_obtains

#print axioms m_C1
#print axioms m_GroundObtains
#print axioms m_C3
#print axioms m_C4a
#print axioms m_not_collapsed
#print axioms m_conclusion
end AscendantRoute.GroundingModel
