import AltRoute.Interface

namespace AltRoute.NegativeTests

-- Supplying every field for `Dia := False` exposes the impossible duality direction.
def forcedInflatedDia : Modal :=
{ Box := id,
  Dia := fun _ => False,
  K := by
    intro p q hpq hp
    exact hpq hp,
  ax_T := by
    intro p hp
    exact hp,
  ax_4 := by
    intro p hp
    exact hp,
  ax_5 := by
    intro p hp
    exact hp.elim,
  duality := by
    intro p
    constructor
    · intro hp
      exact hp.elim
    · intro h
      show False
      assumption }

end AltRoute.NegativeTests
