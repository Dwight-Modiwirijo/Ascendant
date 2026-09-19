import AscendantRoute.Release.TI.TIAPI

set_option autoImplicit false

namespace AscendantRoute.Release.TI

/-- Every state of rank at most `n` reaches a terminus within `n` steps. -/
def InductionProperty (T : Contract) (n : Nat) : Prop :=
  (s : T.State) -> T.rank s <= n ->
    Exists fun steps => steps <= n /\ T.IsTerminus (iterate T steps s)

/-- A rank-zero state is already terminal; zero steps suffice. -/
theorem baseCase (T : Contract) : InductionProperty T 0 := by
  intro s hs
  have hzero : T.rank s = 0 := Nat.eq_zero_of_le_zero hs
  exact Exists.intro 0
    (And.intro (Nat.le_refl 0) ((T.terminus_iff_zero s).2 hzero))

/-- Strict descent turns the induction hypothesis at `n` into the case `n + 1`. -/
theorem inductionStep (T : Contract) (n : Nat)
    (ih : InductionProperty T n) : InductionProperty T (n + 1) := by
  intro s hs
  by_cases hle : T.rank s <= n
  case pos =>
    cases ih s hle with
    | intro steps hsteps =>
      exact Exists.intro steps
        (And.intro (Nat.le_trans hsteps.left (Nat.le_succ n)) hsteps.right)
  case neg =>
    have hrank : T.rank s = n + 1 :=
      Nat.le_antisymm hs (Nat.succ_le_of_lt (Nat.lt_of_not_ge hle))
    have hpositive : 0 < T.rank s := by
      rw [hrank]
      exact Nat.zero_lt_succ n
    have hdecrease : T.rank (T.advance s) < n + 1 := by
      rw [<- hrank]
      exact T.descends s hpositive
    have hnext : T.rank (T.advance s) <= n := Nat.le_of_lt_succ hdecrease
    cases ih (T.advance s) hnext with
    | intro k hk =>
      refine Exists.intro (k + 1) (And.intro (Nat.succ_le_succ hk.left) ?_)
      rw [iterate_succ_arg]
      exact hk.right

/-- Ordinary mathematical induction establishes the bounded property for every rank. -/
theorem fullInduction (T : Contract) :
    (n : Nat) -> InductionProperty T n := by
  intro n
  induction n with
  | zero => exact baseCase T
  | succ n ih => exact inductionStep T n ih

/-- Every state reaches a terminus within its own initial rank. -/
theorem convergesWithinRank (T : Contract) (s : T.State) :
    Exists fun steps =>
      steps <= T.rank s /\ T.IsTerminus (iterate T steps s) :=
  fullInduction T (T.rank s) s (Nat.le_refl _)

/-- Additional iterations preserve a terminal state. -/
theorem iterateTerminus (T : Contract) (t : T.State)
    (ht : T.IsTerminus t) (k : Nat) : iterate T k t = t := by
  induction k with
  | zero => rfl
  | succ k ih =>
    rw [iterate_succ, ih]
    exact T.terminus_fixed t ht

/-- Once a trajectory reaches a terminus, every later state is that terminus. -/
theorem staysAtTerminus (T : Contract) (s : T.State) (steps : Nat)
    (hsteps : T.IsTerminus (iterate T steps s)) (k : Nat) :
    iterate T (steps + k) s = iterate T steps s := by
  induction k with
  | zero => rfl
  | succ k ih =>
    rw [Nat.add_succ, iterate_succ, ih]
    exact T.terminus_fixed (iterate T steps s) hsteps

/-- One initial state witnesses the unique fixed terminus reached from every state. -/
theorem uniqueFixedTerminus (T : Contract) (initial : T.State) :
    Exists fun t =>
      T.IsTerminus t /\
      ((y : T.State) -> T.IsTerminus y -> y = t) /\
      T.advance t = t /\
      ((s : T.State) -> Exists fun steps =>
        steps <= T.rank s /\ iterate T steps s = t /\
          ((k : Nat) -> iterate T (steps + k) s = t)) := by
  cases convergesWithinRank T initial with
  | intro steps hsteps =>
    let t := iterate T steps initial
    have ht : T.IsTerminus t := hsteps.right
    refine Exists.intro t (And.intro ht (And.intro ?_ (And.intro ?_ ?_)))
    · intro y hy
      exact T.terminus_unique y t hy ht
    · exact T.terminus_fixed t ht
    · intro s
      cases convergesWithinRank T s with
      | intro n hn =>
        have heq : iterate T n s = t :=
          T.terminus_unique (iterate T n s) t hn.right ht
        refine Exists.intro n (And.intro hn.left (And.intro heq ?_))
        intro k
        exact (staysAtTerminus T s n hn.right k).trans heq

end AscendantRoute.Release.TI
