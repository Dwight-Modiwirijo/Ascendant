namespace AltRoute
universe u
open Classical

/-- Minimal S5-style modal interface (route-agnostic). -/
structure Modal where
  Box : Prop → Prop
  Dia : Prop → Prop
  ax_T : ∀ p, Box p → p
  ax_4 : ∀ p, Box p → Box (Box p)
  ax_5 : ∀ p, Dia p → Box (Dia p)
  K    : ∀ {p q}, Box (p → q) → (Box p → Box q)
  duality : ∀ p, Dia p ↔ ¬ Box (¬ p)

/-- Marker used by clients that work under constant-domain semantics. -/
def ConstantDomain : Prop := True

/-- Truth at the actual world is possible under T and Box/Dia duality. -/
theorem Modal.actual_possible (M : Modal) (p : Prop) (hp : p) : M.Dia p :=
  (M.duality p).mpr (fun hb => (M.ax_T _ hb) hp)

/-- Proper monotone positivity structure: the empty predicate is not positive. -/
class Positive (ι : Type u) where
  Pos  : (ι → Prop) → Prop
  mono : ∀ {P Q}, (∀ x, P x → Q x) → Pos P → Pos Q
  proper : ¬ Pos (fun _ => False)

/-- The constantly false predicate cannot be positive. -/
theorem false_not_positive {ι : Type u} [Positive ι] :
    ¬ Positive.Pos (fun _ : ι => False) :=
  Positive.proper

/-- Any predicate with empty extension cannot be positive. -/
theorem empty_extension_not_positive {ι : Type u} [Positive ι]
    (P : ι → Prop) (hEmpty : ∀ x, ¬ P x) : ¬ Positive.Pos P := by
  intro hPos
  apply false_not_positive (ι := ι)
  exact Positive.mono (fun x hx => (hEmpty x hx).elim) hPos

/-- Proper positivity has a nonempty extension in classical logic. -/
theorem exists_of_positive {alpha : Type u} [Positive alpha]
    {P : alpha -> Prop} (hPos : Positive.Pos P) : Exists fun x => P x :=
  Classical.byContradiction (fun hEmpty =>
    empty_extension_not_positive P
      (fun x hx => hEmpty (Exists.intro x hx)) hPos)


/-- Positivity implies possibility of instantiation in a reflexive modal interface. -/
theorem PosPossibility {iota : Type u} (M : Modal) [Positive iota]
    (P : iota -> Prop) (hPos : Positive.Pos P) :
    M.Dia (Exists fun x => P x) :=
  M.actual_possible _ (exists_of_positive hPos)

/-- Public, weak statement: from positivity we get necessary possibility. -/
theorem necPossible_of_Pos {ι : Type u} (M : Modal) [Positive ι]
  {P : ι → Prop} (hP : Positive.Pos P) : M.Box (M.Dia (∃ x, P x)) :=
by
  have hDia : M.Dia (∃ x, P x) := PosPossibility (iota := ι) M P hP
  exact M.ax_5 _ hDia

/-- Existential packaging of the previous statement (route-agnostic). -/
def SomePosNecPossible {ι : Type u} (M : Modal) [Positive ι] : Prop :=
  ∃ P : ι → Prop, Positive.Pos P ∧ M.Box (M.Dia (∃ x, P x))

theorem somePosNecPossible_of_exists {ι : Type u} (M : Modal) [Positive ι]
  (h : ∃ P : ι → Prop, Positive.Pos P) : SomePosNecPossible (ι:=ι) M :=
by
  rcases h with ⟨P, hP⟩
  exact ⟨P, hP, necPossible_of_Pos (ι:=ι) M hP⟩

end AltRoute
