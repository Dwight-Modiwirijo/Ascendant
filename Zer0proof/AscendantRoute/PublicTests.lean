import AscendantRoute.Interface

/-!
`PublicTests` is the readable public audit surface for the world-indexed
AscendantRoute interface. The public claims quantify over every S5 frame and every
selected world. The concrete Bool frame below proves that this interface is
not restricted to collapsed one-world semantics.
-/

namespace AscendantRoute.PublicTests

open AscendantRoute

universe u v

-- The modal laws are derived declarations, not user-supplied structure fields.
#check AscendantRoute.Frame.ax_T
#check AscendantRoute.Frame.ax_4
#check AscendantRoute.Frame.ax_5
#check AscendantRoute.Frame.K
#check AscendantRoute.Frame.duality
#check AscendantRoute.Frame.actual_possible

#check AscendantRoute.exists_of_positive
#check AscendantRoute.PosPossibility
#check AscendantRoute.necPossible_of_Pos
#check AscendantRoute.SomePosNecPossible
#check AscendantRoute.somePosNecPossible_of_exists

section PublicApi

variable {W : Type u} {iota : Type v} (F : Frame W) (w : W) [Positive iota]

/-- The public theorem is usable for every frame and selected world. -/
example (P : iota -> W -> Prop)
    (hPos : Positive.Pos (fun x => P x w)) :
    F.Box (F.Dia (fun world => Exists fun x => P x world)) w :=
  necPossible_of_Pos (iota := iota) F w hPos

/-- The existentially packaged public statement has the same generality. -/
example
    (h : Exists fun P : iota -> W -> Prop =>
      Positive.Pos (fun x => P x w)) :
    SomePosNecPossible (iota := iota) F w :=
  somePosNecPossible_of_exists (iota := iota) F w h

/-- Gate 0: the constantly false predicate is not positive. -/
example : Not (Positive.Pos (fun _ : iota => False)) :=
  false_not_positive

/-- Gate 0: every extensionally empty predicate is not positive. -/
example (P : iota -> Prop) (hEmpty : forall x, Not (P x)) :
    Not (Positive.Pos P) :=
  empty_extension_not_positive P hEmpty

end PublicApi

/-! ## A non-degenerate public S5 frame -/

/-- The universal accessibility relation on two worlds. -/
def UniversalBoolFrame : Frame Bool where
  R := fun _ _ => True
  refl := by
    intro _
    trivial
  trans := by
    intro _ _ _ _ _
    trivial
  symm := by
    intro _ _ _
    trivial

/-- A proposition true at exactly the `true` world. -/
def BoolWitness (world : Bool) : Prop := world = true

/--
Counterexample to the old Prop-indexed collapse: truth at the actual world does
not imply truth at every accessible world.
-/
theorem box_not_identity :
    Exists fun W : Type =>
      Exists fun F : Frame W =>
        Exists fun phi : W -> Prop =>
          Exists fun w : W => Not (F.Box phi w <-> phi w) := by
  refine ⟨Bool, UniversalBoolFrame, BoolWitness, true, ?_⟩
  intro hIdentity
  have hBox : UniversalBoolFrame.Box BoolWitness true :=
    hIdentity.mpr rfl
  have hAtFalse : BoolWitness false := hBox false trivial
  simp [BoolWitness] at hAtFalse

/-- Gate 6: the two-world frame exhibits genuine modal contingency. -/
theorem contingency_witness :
    Exists fun W : Type =>
      Exists fun F : Frame W =>
        Exists fun phi : W -> Prop =>
          Exists fun w : W =>
            F.Dia phi w /\ F.Dia (fun world => Not (phi world)) w := by
  refine ⟨Bool, UniversalBoolFrame, BoolWitness, true, ?_, ?_⟩
  · exact ⟨true, trivial, rfl⟩
  · exact ⟨false, trivial, by simp [BoolWitness]⟩

/--
The world-indexed `Box (Dia phi)` certificate is not equivalent to `phi` at
an arbitrary actual world.
-/
theorem certificate_not_trivial :
    Not (forall (W : Type) (F : Frame W) (phi : W -> Prop) (w : W),
      F.Box (F.Dia phi) w <-> phi w) := by
  intro hCollapse
  have hBoxDia :
      UniversalBoolFrame.Box (UniversalBoolFrame.Dia BoolWitness) false := by
    intro world _
    exact ⟨true, trivial, rfl⟩
  have hAtFalse :=
    (hCollapse Bool UniversalBoolFrame BoolWitness false).mp hBoxDia
  simp [BoolWitness] at hAtFalse

/-! ## Explicitly degenerate one-world example -/

/--
The one-world universal frame. Box and Dia collapse here, deliberately. The
public claims are not restricted to this model; `UniversalBoolFrame` above is
the permanent non-collapse witness.
-/
def TrivialModel : Frame Unit where
  R := fun _ _ => True
  refl := by
    intro _
    trivial
  trans := by
    intro _ _ _ _ _
    trivial
  symm := by
    intro _ _ _
    trivial

/-- Box reduces to truth at the sole world in the degenerate model. -/
theorem trivialModel_box_collapses (phi : Unit -> Prop) (w : Unit) :
    TrivialModel.Box phi w <-> phi w := by
  cases w
  constructor
  · intro h
    exact h () trivial
  · intro h world _
    cases world
    exact h

/-- Dia reduces to truth at the sole world in the degenerate model. -/
theorem trivialModel_dia_collapses (phi : Unit -> Prop) (w : Unit) :
    TrivialModel.Dia phi w <-> phi w := by
  cases w
  constructor
  · rintro ⟨world, _, h⟩
    cases world
    exact h
  · intro h
    exact ⟨(), trivial, h⟩

/-- A concrete proper positivity structure on the fixed domain `Unit`. -/
def UnitPositive : Positive Unit where
  Pos := fun P => P ()
  mono := by
    intro P Q hPQ hP
    exact hPQ () hP
  proper := by
    intro h
    exact h

/-- The proper positivity and world-indexed frame interfaces are jointly inhabited. -/
theorem unit_positive_possible :
    TrivialModel.Dia (fun _ : Unit => Exists fun _ : Unit => True) () := by
  letI : Positive Unit := UnitPositive
  exact PosPossibility (iota := Unit) TrivialModel
    (fun _ _ => True) () (by trivial)

/-! ## General negative guards -/

/-- No predicate on the empty type can be positive. -/
theorem no_positive_on_empty [Positive Empty] (P : Empty -> Prop) :
    Not (Positive.Pos P) := by
  intro hPos
  exact Positive.proper (Positive.mono (fun x _ => x.elim) hPos)

/-- Reflexivity prevents possibility from being constantly false. -/
theorem dia_not_constantly_false {W : Type u} (F : Frame W) (w : W) :
    Not (forall phi : W -> Prop, Not (F.Dia phi w)) := by
  intro h
  exact h (fun _ => True) (F.actual_possible _ w trivial)

/-- No frame can make the constantly false proposition possible. -/
theorem dia_not_constantly_true {W : Type u} (F : Frame W) (w : W) :
    Not (forall phi : W -> Prop, F.Dia phi w) := by
  intro h
  rcases h (fun _ => False) with ⟨_, _, hFalse⟩
  exact hFalse

/-! ## Retained non-modal public canaries -/

/-- Standard ex falso, retained as a named canary; no proof of `False` is exported. -/
theorem exFalsoQuodlibet {P : Prop} (h : False) : P :=
  False.elim h

/-- Toy grounding relation used only to demonstrate `Nat.lt` well-foundedness. -/
def GroundingRelation (a b : Nat) : Prop := a < b

example : WellFounded GroundingRelation :=
  Nat.lt_wfRel.wf

/-- A terminating toy countdown; it does not certify the private Ω-chain. -/
def traverse_to_omega (n : Nat) : Nat :=
  if h : n = 0 then
    0
  else
    traverse_to_omega (n - 1)
termination_by n

structure Entity where
  uid : Nat
  label : String
deriving DecidableEq, Repr

def Bank_Financial : Entity := { uid := 1001, label := "Bank" }
def Bank_Furniture : Entity := { uid := 2042, label := "Bank" }

example : Bank_Financial.label = Bank_Furniture.label := by
  rfl

example : Not (Bank_Financial = Bank_Furniture) := by
  intro h
  have hUid : Bank_Financial.uid = Bank_Furniture.uid := by rw [h]
  contradiction

inductive InferenceResult
  | ProvenTrue
  | ProvenFalse
  | Undecidable
deriving DecidableEq, Repr

def evaluate_statement (input : String) : InferenceResult :=
  if input == "1+1=2" then InferenceResult.ProvenTrue
  else if input == "1+1=3" then InferenceResult.ProvenFalse
  else InferenceResult.Undecidable

def forceful_evaluator (input : String) : InferenceResult :=
  if input == "1=1" then InferenceResult.ProvenTrue
  else evaluate_statement input

example : evaluate_statement "Goldbach Conjecture" = InferenceResult.Undecidable := by
  rfl

example : Not (forceful_evaluator "1=1" = InferenceResult.Undecidable) := by
  simp [forceful_evaluator]
/-! ## Axiom-footprint output for the public audit -/

#print axioms exFalsoQuodlibet
#print axioms GroundingRelation
#print axioms traverse_to_omega
#print axioms evaluate_statement
#print axioms forceful_evaluator
#print axioms AscendantRoute.Frame.ax_T
#print axioms AscendantRoute.Frame.ax_4
#print axioms AscendantRoute.Frame.ax_5
#print axioms AscendantRoute.Frame.K
#print axioms AscendantRoute.Frame.duality
#print axioms AscendantRoute.Frame.actual_possible
#print axioms AscendantRoute.false_not_positive
#print axioms AscendantRoute.empty_extension_not_positive
#print axioms AscendantRoute.exists_of_positive
#print axioms AscendantRoute.PosPossibility
#print axioms AscendantRoute.necPossible_of_Pos
#print axioms AscendantRoute.SomePosNecPossible
#print axioms AscendantRoute.somePosNecPossible_of_exists
#print axioms box_not_identity
#print axioms contingency_witness
#print axioms certificate_not_trivial
#print axioms TrivialModel
#print axioms trivialModel_box_collapses
#print axioms trivialModel_dia_collapses
#print axioms UnitPositive
#print axioms unit_positive_possible
#print axioms no_positive_on_empty
#print axioms dia_not_constantly_false
#print axioms dia_not_constantly_true

end AscendantRoute.PublicTests
