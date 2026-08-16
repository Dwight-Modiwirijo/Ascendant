import AltRoute.Interface

namespace AltRoute.NegativeTests

/-- Contingent witnesses can occur at different accessible worlds. -/
theorem no_contingency_anywhere {W : Type} (F : Frame W)
    (phi : W -> Prop) (w : W) :
    Not (F.Dia phi w /\ F.Dia (fun world => Not (phi world)) w) := by
  rintro ⟨⟨x, _, hPhi⟩, ⟨y, _, hNotPhi⟩⟩
  exact hNotPhi hPhi

end AltRoute.NegativeTests
