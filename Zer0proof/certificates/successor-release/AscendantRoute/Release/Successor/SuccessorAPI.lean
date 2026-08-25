/-
  Clean-room public contract for a guarded successor machine.
  This module deliberately has no imports beyond Lean's core prelude.
-/
set_option autoImplicit false

namespace AscendantRoute.Release.Successor

universe u

/-- A total successor machine with a natural-valued termination measure. -/
structure Machine where
  State : Type u
  S : State -> State
  meas : State -> Nat
  dec : (b : State) -> 0 < meas b -> meas (S b) < meas b
  terminal : (b : State) -> meas b = 0 -> S b = b
  zeroUnique : (x y : State) -> meas x = 0 -> meas y = 0 -> x = y

/-- Apply the total step function exactly `n` times. -/
def iterate (M : Machine) : Nat -> M.State -> M.State
  | 0, b => b
  | n + 1, b => M.S (iterate M n b)

@[simp] theorem iterate_zero (M : Machine) (b : M.State) :
    iterate M 0 b = b := rfl

@[simp] theorem iterate_succ (M : Machine) (n : Nat) (b : M.State) :
    iterate M (n + 1) b = M.S (iterate M n b) := rfl

/-- Move the first step from the iteration count to the initial state. -/
theorem iterate_succ_arg (M : Machine) (n : Nat) (b : M.State) :
    iterate M (n + 1) b = iterate M n (M.S b) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      exact congrArg M.S ih

private theorem terminatesUpTo (M : Machine) :
    (m : Nat) -> (b : M.State) -> M.meas b <= m ->
      Exists fun N => N <= m /\ M.meas (iterate M N b) = 0 := by
  intro m
  induction m with
  | zero =>
      intro b hb
      have h0 : M.meas b = 0 := Nat.eq_zero_of_le_zero hb
      exact Exists.intro 0 (And.intro (Nat.zero_le _) h0)
  | succ m ih =>
      intro b hb
      by_cases h0 : M.meas b = 0
      case pos =>
        exact Exists.intro 0 (And.intro (Nat.zero_le _) h0)
      case neg =>
        have hpos : 0 < M.meas b := Nat.pos_of_ne_zero h0
        have hdec : M.meas (M.S b) < M.meas b := M.dec b hpos
        have hnext : M.meas (M.S b) <= m :=
          Nat.le_of_lt_succ (Nat.lt_of_lt_of_le hdec hb)
        cases ih (M.S b) hnext with
        | intro N hN =>
          refine Exists.intro (N + 1)
            (And.intro (Nat.succ_le_succ hN.left) ?_)
          rw [iterate_succ_arg]
          exact hN.right

/-- Every chain reaches the terminal zone in finitely many steps. -/
theorem terminates (M : Machine) (b0 : M.State) :
    Exists fun N => M.meas (iterate M N b0) = 0 := by
  cases terminatesUpTo M (M.meas b0) b0 (Nat.le_refl _) with
  | intro N hN => exact Exists.intro N hN.right

/-- Every non-terminal state has the strictly descending successor promised by the contract. -/
theorem coverage (M : Machine) (b : M.State) (h : 0 < M.meas b) :
    M.meas (M.S b) < M.meas b :=
  M.dec b h

/-- The terminal predicate exposed by the release contract. -/
def Omega (M : Machine) (b : M.State) : Prop :=
  M.meas b = 0

/-- `Omega` is definitionally the zero-measure zone. -/
theorem omega_iff (M : Machine) (b : M.State) :
    M.meas b = 0 <-> Omega M b :=
  Iff.rfl

/-- Every Omega state is fixed by the total step function. -/
theorem omega_fixed (M : Machine) (b : M.State) (h : Omega M b) :
    M.S b = b :=
  M.terminal b h

/-- A chain reaches an Omega state, and every Omega state is that reached state. -/
theorem existsUniqueOmegaReached (M : Machine) (b0 : M.State) :
    Exists fun N =>
      Omega M (iterate M N b0) /\
        ((y : M.State) -> Omega M y -> y = iterate M N b0) := by
  cases terminates M b0 with
  | intro N hN =>
    refine Exists.intro N (And.intro hN ?_)
    intro y hy
    exact M.zeroUnique y (iterate M N b0) hy hN

/-- The Omega state exists and is unique; existence is witnessed by any terminating chain. -/
theorem existsUniqueOmega (M : Machine) (b0 : M.State) :
    Exists fun x =>
      Omega M x /\ ((y : M.State) -> Omega M y -> y = x) := by
  cases existsUniqueOmegaReached M b0 with
  | intro N hN =>
    exact Exists.intro (iterate M N b0)
      (And.intro hN.left hN.right)

end AscendantRoute.Release.Successor
