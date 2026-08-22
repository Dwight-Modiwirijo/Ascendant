import AscendantRoute.Interface

namespace AscendantRoute.NegativeTests

/--
A reflexive and transitive preorder on Bool that is not symmetric. Omitting the
`symm` field must therefore be rejected by the public S5 frame constructor.
-/
def hostileFrame : Frame Bool :=
{ R := fun w x => w = false \/ x = true,
  refl := by
    intro w
    cases w <;> simp,
  trans := by
    intro w x y hwx hxy
    cases w <;> cases x <;> cases y <;> simp_all }

end AscendantRoute.NegativeTests
