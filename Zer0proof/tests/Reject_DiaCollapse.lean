import AltRoute.Interface

namespace AltRoute.NegativeTests

/-- A witness at an accessible world need not establish truth at `w`. -/
theorem dia_collapse {W : Type} (F : Frame W) (phi : W -> Prop) (w : W) :
    F.Dia phi w <-> phi w := by
  constructor
  · rintro ⟨x, _, hPhi⟩
    exact hPhi
  · intro hPhi
    exact F.actual_possible phi w hPhi

end AltRoute.NegativeTests
