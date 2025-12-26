import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Normed.Module.Basic
import Mathlib.Analysis.Normed.Group.Basic

-- Silence the three linter warnings that were triggered earlier
set_option linter.unnecessarySimpa false
set_option linter.unusedTactic false
set_option linter.unreachableTactic false

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℝ V] [CompleteSpace V]

/-- A trajectory of a particle – a map `ℝ → V`. -/
def Position (V : Type*) [NormedAddCommGroup V] [NormedSpace ℝ V] := ℝ → V

/-- Velocity is the derivative of the position. -/
def Velocity (r : Position V) (t : ℝ) : V := deriv r t

/-- Acceleration is the derivative of the velocity. -/
def Acceleration (r : Position V) (t : ℝ) : V := deriv (Velocity r) t

/-- A particle consists of a path together with the facts that the
    path and its velocity are differentiable. -/
structure Particle (V : Type*) [NormedAddCommGroup V] [NormedSpace ℝ V] where
  path     : Position V
  diff_pos : Differentiable ℝ path
  diff_vel : Differentiable ℝ (Velocity path)

--------------------------------------------------------------------
--  Newton’s first law – rigorous formulation
--------------------------------------------------------------------
theorem newton_first_law_rigorous {V : Type*}
    [NormedAddCommGroup V] [NormedSpace ℝ V] [CompleteSpace V] (p : Particle V) :
    (∀ t, Acceleration p.path t = 0) →
    ∀ t₁ t₂, Velocity p.path t₁ = Velocity p.path t₂ := by
  intro h_accel t₁ t₂
  ------------------------------------------------------------
  -- 1️⃣  Zero acceleration ⇒ the derivative of the velocity is the zero map.
  ------------------------------------------------------------
  have h_deriv_zero :
      ∀ x ∈ (Set.univ : Set ℝ), deriv (Velocity p.path) x = (0 : V) := by
    intro x hx
    have := h_accel x
    simpa [Acceleration, Velocity] using this
  ------------------------------------------------------------
  -- 2️⃣  Turn that equality into a bound on the norm of the derivative.
  ------------------------------------------------------------
  have h_norm_deriv :
      ∀ x ∈ (Set.univ : Set ℝ), ‖deriv (Velocity p.path) x‖ ≤ (0 : ℝ) := by
    intro x hx
    have hx0 := h_deriv_zero x hx
    simpa [hx0] using (show ‖(0 : V)‖ ≤ (0 : ℝ) from by simp)
  ------------------------------------------------------------
  -- 3️⃣  Pointwise differentiability of the velocity (needed by the
  --     mean‑value inequality).
  ------------------------------------------------------------
  have h_diff_at :
      ∀ x ∈ (Set.univ : Set ℝ), DifferentiableAt ℝ (Velocity p.path) x := by
    intro x hx
    simpa using p.diff_vel.differentiableAt
  ------------------------------------------------------------
  -- 4️⃣  Apply the mean‑value inequality on the convex set `univ`.
  ------------------------------------------------------------
  have h_bound :
      ‖Velocity p.path t₁ - Velocity p.path t₂‖ ≤ (0 : ℝ) * ‖t₁ - t₂‖ :=
    (convex_univ.norm_image_sub_le_of_norm_deriv_le
        h_diff_at
        h_norm_deriv
        (by trivial) (by trivial))
  ------------------------------------------------------------
  -- 5️⃣  Simplify the right‑hand side and turn the inequality into an equality.
  ------------------------------------------------------------
  have h_norm_zero : ‖Velocity p.path t₁ - Velocity p.path t₂‖ = (0 : ℝ) := by
    have : ‖Velocity p.path t₁ - Velocity p.path t₂‖ ≤ (0 : ℝ) := by
      simpa [zero_mul] using h_bound
    exact le_antisymm this (norm_nonneg _)
  have h_sub :
      Velocity p.path t₁ - Velocity p.path t₂ = (0 : V) :=
    (norm_eq_zero.mp h_norm_zero)
  exact sub_eq_zero.mp h_sub
