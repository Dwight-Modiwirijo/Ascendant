/-
  AltRoute/Private/Successor/Bridge.lean
  --------------------------------------
  Minimal, self-contained NE bridge (axiomatic).
  Namespace matches the import used by AltRoutePrivate.lean.
-/
set_option autoImplicit false

namespace AltRoute.Private.Successor

universe u

/-- Minimal modal interface. -/
structure Modal where
  Box : Prop → Prop
  Dia : Prop → Prop

/-- Positivity typeclass (project specific). -/
class Positive (ι : Type u) where
  Pos : (ι → Prop) → Prop

/-- Existence predicate. -/
abbrev E {ι : Type u} (Ω : ι → Prop) : Prop := ∃ x, Ω x

/-- Axiomatic bridge: ◇□(∃x, Ω x). -/
axiom posNecPoss_Omega (M : Modal) {ι : Type u} [Positive ι] (Ω : ι → Prop) :
  M.Dia (M.Box (E Ω))

/-- Brouwer (S5 collapse): ◇□p → □p. -/
axiom brouwer (M : Modal) {p : Prop} :
  M.Dia (M.Box p) → M.Box p

/-- NE for Ω under the two labeled axioms. -/
theorem necessaryExistence_Omega
  (M : Modal) {ι : Type u} [Positive ι] (Ω : ι → Prop) :
  M.Box (E Ω) :=
  brouwer (M := M) (posNecPoss_Omega (M := M) Ω)

/-- Abbreviation for the bridge shape. -/
abbrev Bridge_Omega (M : Modal) {ι : Type u} (Ω : ι → Prop) : Prop :=
  M.Dia (M.Box (E Ω))

/-- From the bridge, get NE (uses Brouwer). -/
theorem necessaryExistence_if_Bridge
  (M : Modal) {ι : Type u} (Ω : ι → Prop) :
  Bridge_Omega (M := M) Ω → M.Box (E Ω) :=
  fun h => brouwer (M := M) h

end AltRoute.Private.Successor
