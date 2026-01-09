/-
  File: VacuousIAm.lean

  This file models a "vacuous world" (an empty world) and shows three ways an
  "Imaginary I AM" can appear in Lean:

  1) As a local hypothesis (variable) living only inside a theorem scope.
  2) As an axiom that forces existence in an empty type (dogmatic injection).
  3) As ex falso / False.elim: from an impossible inhabitant, any proposition follows.

  Philosophical reading:
  - If the "world" is Empty, then any assumed inhabitant is a phantom:
    it can only exist as a hypothesis, never as a constructed term.
-/

namespace Vacuous

/-- The "vacuous world": there are no inhabitants. -/
def VacuousWorld : Type := Empty

/-
  1) Local variable (hypothetical "I"):
  The inhabitant exists only as an assumption inside the theorem binder.
  Once leaving the theorem, there is no way to produce such a term.
-/
theorem simulation_fantasy (imaginary_me : VacuousWorld) : (1 + 1 = 3) := by
  -- From an inhabitant of Empty, anything follows because there are no cases.
  cases imaginary_me

/-
  A more explicit version of "explosion from Empty":
  This is the constructive elimination principle for Empty.
-/
theorem explode_from_empty {P : Prop} (imaginary_me : VacuousWorld) : P := by
  -- Eliminating an impossible inhabitant yields any target proposition.
  cases imaginary_me

/-
  2) Axiom (forced "I AM" in an empty universe):
  This declares an inhabitant of Empty by fiat.
  In a constructive setting, this is an intentional breach of constructibility.
-/
def GodlessUniverse : Type := Empty

axiom Fake_I_AM : GodlessUniverse

/-- Once an axiom provides an inhabitant of Empty, every proposition becomes provable. -/
theorem axiom_makes_everything_true (P : Prop) : P := by
  -- The axiom supplies the impossible input; elimination yields P.
  cases Fake_I_AM

/-
  3) False.elim (ex falso quodlibet):
  If "I exist in Empty" were given, it is effectively a proof of False.
-/

/-- Any term of Empty can be recursed into False. -/
def Imaginary_I_AM (me : Empty) : False := by
  -- Empty has no constructors; recursion closes the goal.
  cases me

/-- From False, any proposition follows (classical ex falso). -/
theorem generate_hallucination (me : Empty) : ("Reality is what we create to be." = "Waar") := by
  -- The target is arbitrary; it becomes derivable once False is available.
  exact False.elim (Imaginary_I_AM me)

end Vacuous
