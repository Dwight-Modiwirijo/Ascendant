import AltRoute.Interface

namespace AltRoute.NegativeTests

/-- Contingent witnesses can occur at different accessible worlds. -/
theorem no_contingency_anywhere {W : Type} (F : Frame W)
    (phi : W -> Prop) (w : W) :
    Not (F.Dia phi w /\ F.Dia (fun world => Not (phi world)) w) := by
  rintro ⟨⟨_, _, hPhi⟩, ⟨_, _, hNotPhi⟩⟩
  fail_if_success exact hNotPhi hPhi
  fail "Reject_NoContingency.no_contingency_anywhere: witnesses have different world indices"

end AltRoute.NegativeTests
