import AltRoute.Interface

namespace AltRoute.NegativeTests

-- This historical modal instance must fail: `Dia := False` cannot satisfy
-- the required Box/Dia duality.
def hostileModal : Modal :=
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
    exact hp.elim }

end AltRoute.NegativeTests
