import SemanticGrounding

namespace SemanticGrounding.Model

theorem empty_wf : WellFounded (fun (_ _ : α) => False) :=
  ⟨fun x => Acc.intro x (fun _ h => h.elim)⟩

def dataOnly : Setting Unit Unit :=
  ⟨fun _ => True, fun _ => False, fun _ => False,
   fun _ _ => False, fun _ _ => False, fun _ => False⟩

theorem dataOnly_guard : dataOnly.Data () ∧ ¬dataOnly.Semantic () ∧
    ¬dataOnly.Conscious () := ⟨trivial, id, id⟩

def dataOnly_semantic : SemanticPremises dataOnly :=
  ⟨fun _ h => h.elim, empty_wf⟩
def dataOnly_realization : RealizationPremises dataOnly :=
  ⟨fun _ h => h.elim, fun _ _ h => h.elim⟩

/-- Natural-number content represents arbitrarily long finite derived chains. -/
def chain : Setting Nat Unit :=
  ⟨fun _ => True, fun _ => True, fun n => n = 0,
   fun y x => x = y + 1, fun _ n => n = 0, fun _ => True⟩

def chain_semantic : SemanticPremises chain where
  semantic_decomposition x _ := by
    cases x with
    | zero => exact Or.inl rfl
    | succ n => exact Or.inr ⟨n, trivial, rfl⟩
  wellFounded := by
    constructor
    intro x
    induction x with
    | zero => exact Acc.intro 0 (fun y h => (Nat.noConfusion h))
    | succ n ih =>
      apply Acc.intro
      intro y h
      have e : n = y := Nat.succ.inj h
      cases e
      exact ih

def chain_realization : RealizationPremises chain :=
  ⟨fun _ h => ⟨(), h⟩, fun _ _ _ _ => trivial⟩

theorem chain_guard : chain.Semantic 3 ∧ ¬chain.Intrinsic 3 ∧
    SemanticGroundingClosure chain.SemanticallyGrounds 0 3 ∧
    chain.Realizes () 0 ∧ chain.Conscious () :=
  ⟨trivial, Nat.noConfusion,
   .tail (.tail (.tail (.refl 0) rfl) rfl) rfl, rfl, trivial⟩

def unreadLetter := chain
/-- Reception is local to this model and absent from the core architecture. -/
def Receives (_ : Unit) (_ : Nat) : Prop := False

theorem unreadLetter_guard : unreadLetter.Semantic 3 ∧ ¬unreadLetter.Intrinsic 3 ∧
    (¬∃ s, Receives s 3) ∧
    SemanticGroundingClosure unreadLetter.SemanticallyGrounds 0 3 :=
  ⟨trivial, Nat.noConfusion, fun ⟨_, h⟩ => h, chain_guard.2.2.1⟩

/-- Each content has a further upstream ground, with no intrinsic source. -/
def regress : Setting Nat Unit :=
  { chain with
    Intrinsic := fun _ => False
    SemanticallyGrounds := fun y x => y = x + 1 }

theorem regress_decomposition : ∀ x, regress.Semantic x →
    regress.Intrinsic x ∨ ∃ y, regress.Semantic y ∧ regress.SemanticallyGrounds y x :=
  fun x _ => Or.inr ⟨x + 1, trivial, rfl⟩

theorem regress_not_wf : ¬WellFounded regress.SemanticallyGrounds := by
  intro wf
  have impossible : ∀ x, False := fun x => wf.induction (C := fun _ => False) x (fun n ih => ih (n+1) rfl)
  exact impossible 0

def regress_realization : RealizationPremises regress :=
  ⟨fun _ h => h.elim, fun _ _ h => h.elim⟩

/-- A teleosemantic interpretation can accept semantic status without accepting
intrinsic status or the proposed decomposition. Function is not a core premise. -/
def naturalist : Setting Unit Unit :=
  { dataOnly with Semantic := fun _ => True }

def TeleologicalFunction (_ : Unit) : Prop := True

theorem naturalist_guard : naturalist.Semantic () ∧ TeleologicalFunction () ∧
    WellFounded naturalist.SemanticallyGrounds ∧
    ¬(∀ x, naturalist.Semantic x → naturalist.Intrinsic x ∨
       ∃ y, naturalist.Semantic y ∧ naturalist.SemanticallyGrounds y x) := by
  refine ⟨trivial, trivial, empty_wf, ?_⟩
  intro h
  rcases h () trivial with hi | ⟨_, _, hg⟩
  · exact hi
  · exact hg

def naturalist_realization : RealizationPremises naturalist :=
  ⟨fun _ h => h.elim, fun _ _ h => h.elim⟩

def zombie : Setting Nat Unit := { chain with Conscious := fun _ => False }
def zombie_semantic : SemanticPremises zombie :=
  ⟨chain_semantic.semantic_decomposition, chain_semantic.wellFounded⟩

theorem zombie_has_realizer : ∀ y, zombie.Intrinsic y → ∃ s, zombie.Realizes s y :=
  chain_realization.intrinsic_has_realizer

theorem zombie_guard : zombie.Intrinsic 0 ∧ zombie.Realizes () 0 ∧
    ¬zombie.Conscious () ∧ ¬RealizationPremises zombie :=
  ⟨rfl, rfl, id, fun h => h.intrinsic_realizer_is_conscious () 0 rfl rfl⟩

/-- Two realizers share one intrinsic content, but only one is conscious. -/
def coRealizer : Setting Unit Bool :=
  ⟨fun _ => True, fun _ => True, fun _ => True,
   fun _ _ => False, fun _ _ => True, fun s => s = true⟩
def coRealizer_semantic : SemanticPremises coRealizer :=
  ⟨fun _ _ => Or.inl trivial, empty_wf⟩

theorem coRealizer_guard :
    (∀ y, coRealizer.Intrinsic y → ∃ s, coRealizer.Conscious s ∧ coRealizer.Realizes s y) ∧
    ¬RealizationPremises coRealizer := by
  refine ⟨fun _ _ => ⟨true, rfl, trivial⟩, ?_⟩
  intro h
  exact Bool.noConfusion (h.intrinsic_realizer_is_conscious false () trivial trivial)

/-- Independent sources have no grounding edges between them. -/
def twoSources : Setting Bool Unit :=
  ⟨fun _ => True, fun _ => True, fun _ => True,
   fun _ _ => False, fun _ _ => True, fun _ => True⟩
def twoSources_semantic : SemanticPremises twoSources :=
  ⟨fun _ _ => Or.inl trivial, empty_wf⟩
def twoSources_realization : RealizationPremises twoSources :=
  ⟨fun _ _ => ⟨(), trivial⟩, fun _ _ _ _ => trivial⟩

theorem twoSources_guard : twoSources.Intrinsic false ∧ twoSources.Intrinsic true ∧
    ¬(∀ a b, twoSources.Intrinsic a → twoSources.Intrinsic b → a = b) :=
  ⟨trivial, trivial, fun h => Bool.noConfusion (h false true trivial trivial)⟩

end SemanticGrounding.Model
