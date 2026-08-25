/-
  Clean-room public contract for finite transcendental induction.
  This module deliberately has no imports beyond Lean's core prelude.
-/
set_option autoImplicit false

namespace AscendantRoute.Release.TI

universe u

/--
An abstract finite convergence system. Uniqueness is an explicit requirement;
the contract does not expose how a private implementation establishes it.
-/
structure Contract where
  State : Type u
  advance : State -> State
  rank : State -> Nat
  IsTop : State -> Prop
  descends : (x : State) -> 0 < rank x -> rank (advance x) < rank x
  top_iff_zero : (x : State) -> IsTop x <-> rank x = 0
  top_unique : (x y : State) -> IsTop x -> IsTop y -> x = y
  top_fixed : (x : State) -> IsTop x -> advance x = x

/-- Apply the public advance operation exactly `n` times. -/
def iterate (T : Contract) : Nat -> T.State -> T.State
  | 0, x => x
  | n + 1, x => T.advance (iterate T n x)

@[simp] theorem iterate_zero (T : Contract) (x : T.State) :
    iterate T 0 x = x := rfl

@[simp] theorem iterate_succ (T : Contract) (n : Nat) (x : T.State) :
    iterate T (n + 1) x = T.advance (iterate T n x) := rfl

theorem iterate_succ_arg (T : Contract) (n : Nat) (x : T.State) :
    iterate T (n + 1) x = iterate T n (T.advance x) := by
  induction n with
  | zero => rfl
  | succ n ih => exact congrArg T.advance ih

private theorem convergesUpTo (T : Contract) :
    (m : Nat) -> (x : T.State) -> T.rank x <= m ->
      Exists fun n => n <= m /\ T.IsTop (iterate T n x) := by
  intro m
  induction m with
  | zero =>
      intro x hx
      have hzero : T.rank x = 0 := Nat.eq_zero_of_le_zero hx
      exact Exists.intro 0
        (And.intro (Nat.zero_le _) ((T.top_iff_zero x).2 hzero))
  | succ m ih =>
      intro x hx
      by_cases hzero : T.rank x = 0
      case pos =>
        exact Exists.intro 0
          (And.intro (Nat.zero_le _) ((T.top_iff_zero x).2 hzero))
      case neg =>
        have hpos : 0 < T.rank x := Nat.pos_of_ne_zero hzero
        have hdec : T.rank (T.advance x) < T.rank x := T.descends x hpos
        have hnext : T.rank (T.advance x) <= m :=
          Nat.le_of_lt_succ (Nat.lt_of_lt_of_le hdec hx)
        cases ih (T.advance x) hnext with
        | intro n hn =>
          refine Exists.intro (n + 1)
            (And.intro (Nat.succ_le_succ hn.left) ?_)
          rw [iterate_succ_arg]
          exact hn.right

/-- Every state reaches the top in finitely many public advance steps. -/
theorem converges (T : Contract) (start : T.State) :
    Exists fun n => T.IsTop (iterate T n start) := by
  cases convergesUpTo T (T.rank start) start (Nat.le_refl _) with
  | intro n hn => exact Exists.intro n hn.right

/-- The top states are exactly the rank-zero states. -/
theorem top_characterization (T : Contract) (x : T.State) :
    T.IsTop x <-> T.rank x = 0 :=
  T.top_iff_zero x

/-- A top state is stable under the public advance operation. -/
theorem isTop_fixed (T : Contract) (x : T.State) (h : T.IsTop x) :
    T.advance x = x :=
  T.top_fixed x h

/-- Finite convergence supplies a top, and the explicit contract field makes it unique. -/
theorem existsUniqueTop (T : Contract) (start : T.State) :
    Exists fun x => T.IsTop x /\ ((y : T.State) -> T.IsTop y -> y = x) := by
  cases converges T start with
  | intro n htop =>
    refine Exists.intro (iterate T n start) (And.intro htop ?_)
    intro y hy
    exact T.top_unique y (iterate T n start) hy htop

end AscendantRoute.Release.TI
