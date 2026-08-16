import AltRoute.Interface

namespace AltRoute.NegativeTests

/-- The old reverse direction cannot lift truth at one world to every world. -/
theorem box_collapse {W : Type} (F : Frame W) (phi : W -> Prop) (w : W) :
    F.Box phi w <-> phi w :=
  ⟨F.ax_T phi w, fun hPhi => by
    rw [eq_true hPhi]
    intro _ _
    trivial⟩

end AltRoute.NegativeTests
