import AltRoute.Interface

namespace AltRoute.NegativeTests

/-- A witness at an accessible world need not establish truth at `w`. -/
theorem dia_collapse {W : Type} (F : Frame W) (phi : W -> Prop) (w : W) :
    F.Dia phi w <-> phi w := by
  constructor
  · rintro ⟨_, _, hPhi⟩
    fail_if_success exact hPhi
    fail "Reject_DiaCollapse.dia_collapse: phi x is not phi w"
  · intro hPhi
    exact F.actual_possible phi w hPhi

end AltRoute.NegativeTests
