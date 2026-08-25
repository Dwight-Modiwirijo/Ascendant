import AscendantRoute.Interface

namespace AscendantRoute.NegativeTests

/-- The old reverse direction cannot lift truth at one world to every world. -/
theorem box_collapse {W : Type} (F : Frame W) (phi : W -> Prop) (w : W) :
    F.Box phi w <-> phi w := by
  constructor
  · exact F.ax_T phi w
  · intro hPhi
    fail_if_success rw [eq_true hPhi]
    fail "Reject_BoxCollapse.box_collapse: phi w cannot rewrite world-indexed phi"

end AscendantRoute.NegativeTests
