/- import must be the first command (comments allowed above). -/
import Mathlib.Data.Nat.Basic
import AltRoute.Private.Successor.Types

set_option autoImplicit false

namespace AltRoute.Private.Successor

open Nat

universe u
variable {ι : Type u}

/-- Using strong induction on an upper bound `m` for the measure,
    we show that the chain hits measure `0` within at most `m` steps. -/
private theorem terminates_up_to
    (Succ : Successor ι) :
    ∀ (m : Nat) (b : Succ.Bundle), Succ.meas b ≤ m →
        ∃ N ≤ m, Succ.meas (iterate Succ N b) = 0
:= by
  intro m
  induction m with
  | zero =>
      intro b hb
      -- `hb : Succ.meas b ≤ 0` ⇒ gelijkheid
      have h0 : Succ.meas b = 0 := Nat.le_antisymm hb (Nat.zero_le _)
      refine ⟨0, Nat.zero_le _, ?_⟩
      simp [iterate_zero, h0]
  | succ m ih =>
      intro b hb
      by_cases h : Succ.meas b = 0
      · -- al 0 → 0 stappen nodig
        refine ⟨0, Nat.zero_le _, ?_⟩
        simp [iterate_zero, h]
      · -- niet 0 → één stap vooruit en gebruik IH
        have hdec : Succ.meas (Succ.S b) < Succ.meas b := Succ.dec b
        -- uit `hb` en `hdec` volgt `Succ.meas (Succ.S b) ≤ m`
        have hb' : Succ.meas (Succ.S b) ≤ m :=
          Nat.le_of_lt_succ (Nat.lt_of_lt_of_le hdec hb)
        obtain ⟨N, hNle, hN⟩ := ih (Succ.S b) hb'
        refine ⟨N + 1, Nat.succ_le_succ hNle, ?_⟩
        -- rewrite `hN` zodat we een term met `iterate Succ (N+1) b` krijgen
        have hN' := hN
        -- `iterate_succ_arg` : iterate Succ (N+1) b = iterate Succ N (Succ.S b)
        -- we rewrite the left‑hand side of `hN'` using the *symmetry* of that lemma
        rw [← iterate_succ_arg (Succ:=Succ) N b] at hN'
        -- nu is `hN' : Succ.meas (iterate Succ (N+1) b) = 0`
        -- en `iterate (N+1)` kan nog eens met `iterate_succ` worden geëxpand.
        simpa [iterate_succ] using hN'

/-- Public, small‑footprint lemma: existence of a step reaching measure 0. -/
theorem chain_terminates (Succ : Successor ι) (b0 : Succ.Bundle) :
    ∃ N, Succ.meas (iterate Succ N b0) = 0 :=
by
  -- we may use `m = Succ.meas b0` as an upper bound
  obtain ⟨N, _hNle, hN⟩ :=
    terminates_up_to (Succ := Succ) (m := Succ.meas b0) b0 (Nat.le_refl _)
  exact ⟨N, hN⟩

end AltRoute.Private.Successor
