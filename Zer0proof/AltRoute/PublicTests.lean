import AltRoute.Interface

namespace AltRoute.PublicTests
open AltRoute
universe u

section
variable {ι : Type u} (M : Modal) [Positive ι]

/-- Sanity check: `necPossible_of_Pos` is applicable without witnesses. -/
example (P : ι → Prop) (h : Positive.Pos P) :
  M.Box (M.Dia (∃ x, P x)) :=
  necPossible_of_Pos (ι:=ι) M h

/-- The packaged existential statement is usable under the same hypotheses. -/
example (h : ∃ P : ι → Prop, Positive.Pos P) :
  SomePosNecPossible (ι:=ι) M :=
  somePosNecPossible_of_exists (ι:=ι) M h

end
end AltRoute.PublicTests

-- Visibility checks (top-level commands)
#check AltRoute.SomePosNecPossible
#check AltRoute.necPossible_of_Pos
#check AltRoute.somePosNecPossible_of_exists
