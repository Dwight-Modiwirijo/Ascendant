namespace AscendantRoute

universe u v

/-- An S5 Kripke frame. Accessibility is an equivalence relation. -/
structure Frame (W : Type u) where
  R : W -> W -> Prop
  refl : forall w, R w w
  trans : forall w x y, R w x -> R x y -> R w y
  symm : forall w x, R w x -> R x w

namespace Frame

variable {W : Type u} (F : Frame W)

/-- Necessity at a world: truth at every accessible world. -/
def Box (phi : W -> Prop) : W -> Prop :=
  fun w => forall x, F.R w x -> phi x

/-- Possibility at a world: truth at some accessible world. -/
def Dia (phi : W -> Prop) : W -> Prop :=
  fun w => Exists fun x => F.R w x /\ phi x

/-- T follows from reflexivity. -/
theorem ax_T (phi : W -> Prop) (w : W) : F.Box phi w -> phi w := by
  intro h
  exact h w (F.refl w)

/-- K follows directly from universal quantification over accessible worlds. -/
theorem K {phi psi : W -> Prop} (w : W) :
    F.Box (fun x => phi x -> psi x) w -> F.Box phi w -> F.Box psi w := by
  intro hImp hPhi x hwx
  exact hImp x hwx (hPhi x hwx)

/-- 4 follows from transitivity. -/
theorem ax_4 (phi : W -> Prop) (w : W) :
    F.Box phi w -> F.Box (F.Box phi) w := by
  intro hPhi x hwx y hxy
  exact hPhi y (F.trans w x y hwx hxy)

/-- 5 follows from symmetry and transitivity. -/
theorem ax_5 (phi : W -> Prop) (w : W) :
    F.Dia phi w -> F.Box (F.Dia phi) w := by
  intro hDia
  rcases hDia with ⟨x, hwx, hPhi⟩
  intro y hwy
  exact ⟨x, F.trans y w x (F.symm w y hwy) hwx, hPhi⟩

/-- Box/Dia duality is derived from the Kripke definitions. -/
theorem duality (phi : W -> Prop) (w : W) :
    F.Dia phi w <-> Not (F.Box (fun x => Not (phi x)) w) := by
  constructor
  · rintro ⟨x, hwx, hPhi⟩ hBox
    exact hBox x hwx hPhi
  · intro hNotBox
    classical
    exact Classical.byContradiction (fun hNoDia =>
      hNotBox (fun x hwx hPhi => hNoDia ⟨x, hwx, hPhi⟩))

/-- Actual truth is possible because every world accesses itself. -/
theorem actual_possible (phi : W -> Prop) (w : W) (hPhi : phi w) :
    F.Dia phi w :=
  ⟨w, F.refl w, hPhi⟩

end Frame

/--
Proper monotone positivity for ordinary predicates. For a world-indexed
property `P : iota -> W -> Prop`, the public API applies positivity to its
extension `fun x => P x w` at the selected world `w`. The fixed type `iota`
enforces constant-domain semantics across worlds.
-/
class Positive (iota : Type v) where
  Pos : (iota -> Prop) -> Prop
  mono : forall {P Q}, (forall x, P x -> Q x) -> Pos P -> Pos Q
  proper : Not (Pos (fun _ => False))

/-- The constantly false predicate cannot be positive. -/
theorem false_not_positive {iota : Type v} [Positive iota] :
    Not (Positive.Pos (fun _ : iota => False)) :=
  Positive.proper

/-- Any predicate with empty extension cannot be positive. -/
theorem empty_extension_not_positive {iota : Type v} [Positive iota]
    (P : iota -> Prop) (hEmpty : forall x, Not (P x)) :
    Not (Positive.Pos P) := by
  intro hPos
  apply false_not_positive (iota := iota)
  exact Positive.mono (fun x hx => (hEmpty x hx).elim) hPos

/-- Proper positivity has a nonempty extension in classical logic. -/
theorem exists_of_positive {iota : Type v} [Positive iota]
    {P : iota -> Prop} (hPos : Positive.Pos P) : Exists fun x => P x :=
  Classical.byContradiction (fun hEmpty =>
    empty_extension_not_positive P
      (fun x hx => hEmpty (Exists.intro x hx)) hPos)

/--
World-relative lift of positivity to possibility. Positivity is evaluated on
the actual-world extension of `P`; reflexivity then supplies the modal step.
-/
theorem PosPossibility {W : Type u} {iota : Type v} (F : Frame W)
    [Positive iota] (P : iota -> W -> Prop) (w : W)
    (hPos : Positive.Pos (fun x => P x w)) :
    F.Dia (fun world => Exists fun x => P x world) w :=
  F.actual_possible _ w (exists_of_positive (iota := iota) hPos)

/-- Positivity at any world implies necessary possibility at that world. -/
theorem necPossible_of_Pos {W : Type u} {iota : Type v} (F : Frame W)
    [Positive iota] {P : iota -> W -> Prop} (w : W)
    (hPos : Positive.Pos (fun x => P x w)) :
    F.Box (F.Dia (fun world => Exists fun x => P x world)) w :=
  F.ax_5 _ w (PosPossibility F P w hPos)

/-- Existential packaging of the world-indexed public statement. -/
def SomePosNecPossible {W : Type u} {iota : Type v} (F : Frame W)
    [Positive iota] (w : W) : Prop :=
  Exists fun P : iota -> W -> Prop =>
    Positive.Pos (fun x => P x w) /\
      F.Box (F.Dia (fun world => Exists fun x => P x world)) w

theorem somePosNecPossible_of_exists {W : Type u} {iota : Type v}
    (F : Frame W) [Positive iota] (w : W)
    (h : Exists fun P : iota -> W -> Prop =>
      Positive.Pos (fun x => P x w)) :
    SomePosNecPossible (iota := iota) F w := by
  rcases h with ⟨P, hPos⟩
  exact ⟨P, hPos, necPossible_of_Pos (iota := iota) F w hPos⟩

end AscendantRoute
