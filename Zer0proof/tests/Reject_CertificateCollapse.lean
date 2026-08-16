import AltRoute.Interface

namespace AltRoute.NegativeTests

/-- Necessary possibility does not imply truth at the selected world. -/
theorem certificate_equals_existence {W : Type} (F : Frame W)
    (phi : W -> Prop) (w : W) :
    F.Box (F.Dia phi) w <-> phi w := by
  constructor
  · intro hCertificate
    rcases F.ax_T (F.Dia phi) w hCertificate with ⟨_, _, hPhi⟩
    fail_if_success exact hPhi
    fail "Reject_CertificateCollapse.certificate_equals_existence: phi x is not phi w"
  · intro hPhi
    exact F.ax_5 phi w (F.actual_possible phi w hPhi)

end AltRoute.NegativeTests
