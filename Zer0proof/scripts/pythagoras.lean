/-
       C
      /|
     / |
    /  |
   /   |  ↑
  /    |  | Vector (C - A)
 /     |  | "leg 2"
/______|
B      A
  <---->
 Vector (B - A)
 "leg 1"
-/
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Geometry.Euclidean.Basic
import Mathlib.Tactic

noncomputable section

open RealInnerProductSpace
open InnerProductSpace
open EuclideanGeometry

-- THE TRICK: Instead of using concrete coordinates like ℝ × ℝ, we define
-- an abstract space `V` equipped with an inner product.
-- This avoids conflicts with the default "max norm" on ℝ × ℝ and generalizes the proof.
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/--
  The Pythagorean Theorem.
  This proof is valid for any Euclidean space `V` (including the standard 2D plane).
-/
theorem pythagoras {A B C : V}
    -- Hypothesis: The leg vectors are orthogonal (their inner product is zero).
    (h_ortho : ⟪B - A, C - A⟫ = 0) :
    dist B C ^ 2 = dist A B ^ 2 + dist A C ^ 2 := by

  -- 1. Translate Geometry to Algebra
  -- Convert geometrical 'distance' into the algebraic 'norm' (length) to facilitate calculation.
  rw [dist_eq_norm, dist_eq_norm, dist_eq_norm]

  -- 2. Vector Arithmetic
  -- Observe that the hypotenuse vector (B - C) can be expressed as the difference
  -- of the two leg vectors: (B - A) - (C - A).
  have h_vec : B - C = (B - A) - (C - A) := by
    abel

  -- 3. Expansion of the Squared Norm
  -- Substitute the vector decomposition and apply the fundamental identity:
  -- ‖u - v‖² = ‖u‖² + ‖v‖² - 2⟪u, v⟫
  rw [h_vec]
  rw [norm_sub_sq_real]

  -- 4. Apply Orthogonality
  -- Since the vectors are orthogonal, their inner product is zero.
  -- This eliminates the cross-term `-2 * 0`.
  rw [h_ortho]

  -- 5. Final Simplification
  -- Simplify the expression (removing the zero term) and use `norm_sub_rev`
  -- to handle the symmetry of the norm (‖A - B‖ = ‖B - A‖).
  simp [norm_sub_rev]
