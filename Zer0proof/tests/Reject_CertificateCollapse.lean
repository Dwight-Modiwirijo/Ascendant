import AltRoute.Interface

namespace AltRoute.NegativeTests

/-- Necessary possibility does not imply truth at the selected world. -/
theorem certificate_equals_existence {W : Type} (F : Frame W)
    (phi : W -> Prop) (w : W) :
    F.Box (F.Dia phi) w <-> phi w := by
  constructor
  · intro hCertificate
    rcases F.ax_T (F.Dia phi) w hCertificate with ⟨x, _, hPhi⟩
    exact hPhi
  · intro hPhi
    exact F.ax_5 phi w (F.actual_possible phi w hPhi)

end AltRoute.NegativeTests
