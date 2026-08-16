import AltRoute.Interface

namespace AltRoute.NegativeTests

-- This historical hostile instance must fail: it cannot provide `Positive.proper`.
instance hostilePositiveEmpty : Positive Empty where
  Pos := fun _ => True
  mono := by
    intro P Q h hP
    trivial

theorem empty_positive : Positive.Pos (fun _ : Empty => False) := by
  show True
  trivial

end AltRoute.NegativeTests
