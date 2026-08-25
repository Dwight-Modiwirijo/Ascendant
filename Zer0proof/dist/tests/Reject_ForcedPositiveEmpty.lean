import AscendantRoute.Interface

namespace AscendantRoute.NegativeTests

-- Supplying every field exposes the genuinely impossible obligation.
instance forcedPositiveEmpty : Positive Empty where
  Pos := fun _ => True
  mono := by
    intro P Q h hP
    trivial
  proper := by
    show ¬ True
    assumption

end AscendantRoute.NegativeTests
