/-
  File: VacuousTruth.lean

  This file distinguishes:
  (A) Vacuous truth: ∀ x : Empty, P x is provable without assuming any inhabitant.
  (B) Explosion: if an inhabitant of Empty (or False) is assumed/axiomatized, then any proposition follows.

  Key idea:
  - Vacuous truth needs NO "me : Empty".
  - Explosion needs an impossible input, like "me : Empty" or "h : False".
-/

namespace VacuousTruth

/-- An empty domain: no inhabitants exist. -/
def VacuousWorld : Type := Empty

/-
  (A) Vacuous truth:
  A universal statement over an empty domain is provable by introducing x and closing by cases.
-/
theorem vacuous_forall {P : VacuousWorld → Prop} : (∀ x : VacuousWorld, P x) := by
  intro x
  cases x

/-
  Same idea, but with a constant proposition (does not depend on x).
  This mirrors "∀ x ∈ ∅, Q(x)" being true for any Q.
-/
theorem vacuous_forall_const (Q : Prop) : (∀ x : VacuousWorld, Q) := by
  intro x
  cases x

/-
  A concrete "vacuous truth" example:
  "All inhabitants of the empty world are equal to themselves."
-/
theorem vacuous_example : (∀ x : VacuousWorld, x = x) := by
  intro x
  cases x

/-
  (B) Explosion:
  If someone provides an inhabitant of Empty (as a hypothesis),
  then any proposition becomes provable.
-/
theorem explosion_from_empty {R : Prop} (imaginary_me : VacuousWorld) : R := by
  cases imaginary_me

/-
  Axiomatized inhabitant of Empty: this makes the logic unsafe,
  because it turns the empty world into a source of arbitrary proofs.
-/
axiom Fake_I_AM : VacuousWorld

theorem axiom_causes_explosion (R : Prop) : R := by
  cases Fake_I_AM

end VacuousTruth
