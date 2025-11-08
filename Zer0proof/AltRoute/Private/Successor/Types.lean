/-
  AltRoute/Private/Successor/Types.lean
  -------------------------------------
  Minimal successor machinery used by Chain.lean.
  Defines a strictly decreasing natural‑valued measure under `S`,
  its iteration, and simple rewrite lemmas. ASCII only, tactic‑light.
-/
set_option autoImplicit false

namespace AltRoute.Private.Successor

universe u

/-- A successor system with a strictly decreasing natural measure. -/
structure Successor (ι : Type u) where
  Bundle : Type u
  S      : Bundle → Bundle
  meas   : Bundle → Nat
  dec    : ∀ b, meas (S b) < meas b

/-- Iterate `S` exactly `n` times. -/
def iterate {ι : Type u} (Succ : Successor ι) : Nat → Succ.Bundle → Succ.Bundle
| 0,     b => b
| n+1,   b => Succ.S (iterate Succ n b)

@[simp] theorem iterate_zero {ι : Type u} (Succ : Successor ι) (b : Succ.Bundle) :
  iterate Succ 0 b = b := rfl

@[simp] theorem iterate_succ {ι : Type u} (Succ : Successor ι) (n : Nat) (b : Succ.Bundle) :
  iterate Succ (n + 1) b = Succ.S (iterate Succ n b) := rfl

/-- Shift one step from the argument to the counter:
    `iterate (n+1) b = iterate n (S b)`. -/
theorem iterate_succ_arg {ι : Type u} (Succ : Successor ι)
  (n : Nat) (b : Succ.Bundle) :
  iterate Succ (n + 1) b = iterate Succ n (Succ.S b) :=
by
  induction n with
  | zero => simp [iterate]
  | succ n ih =>
      -- `congrArg Succ.S ih` gives  `S (iterate (n+1) b) = S (iterate n (S b))`
      -- and `simp [iterate]` turns the left side into `S [S (iterate n b)]`.
      simpa [iterate] using congrArg Succ.S ih

end AltRoute.Private.Successor
