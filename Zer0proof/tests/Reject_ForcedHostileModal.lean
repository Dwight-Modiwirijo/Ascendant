import AltRoute.Interface

namespace AltRoute.NegativeTests

/--
Forcing the missing `symm` field exposes the concrete impossible direction:
`true` accesses `true`, but the chosen preorder does not let `true` access
`false` merely because `false` accesses `true`.
-/
def forcedHostileFrame : Frame Bool :=
{ R := fun w x => w = false \/ x = true,
  refl := by
    intro w
    cases w <;> simp,
  trans := by
    intro w x y hwx hxy
    cases w <;> cases x <;> cases y <;> simp_all,
  symm := by
    intro w x hwx
    cases w <;> cases x <;> simp_all }

end AltRoute.NegativeTests
