import SemanticGroundingModel
import Lean

namespace SemanticGrounding.Audit
open Model

/-- Reversing the positive model's relation produces the infinite-regress model. -/
theorem orientation_guard : WellFounded chain.SemanticallyGrounds ∧
    ¬WellFounded (fun y x => chain.SemanticallyGrounds x y) :=
  ⟨chain_semantic.wellFounded, regress_not_wf⟩

theorem no_self_grounding (S : Setting C U) (P : SemanticPremises S) (x : C) :
    ¬S.SemanticallyGrounds x x := by
  have h : ∀ z, ¬S.SemanticallyGrounds z z := by
    intro z
    induction z using P.wellFounded.induction with
    | h z ih => exact fun hz => ih z hz hz
  exact h x

theorem no_two_cycle (S : Setting C U) (P : SemanticPremises S) (x y : C) :
    ¬(S.SemanticallyGrounds x y ∧ S.SemanticallyGrounds y x) := by
  have h : ∀ z, ∀ w, S.SemanticallyGrounds w z → ¬S.SemanticallyGrounds z w := by
    intro z
    induction z using P.wellFounded.induction with
    | h z ih => exact fun w hw hz => ih w hw z hz hw
  exact fun ⟨hxy, hyx⟩ => h y x hxy hyx

/-- The positive conclusion uses the actual composition theorem. -/
theorem chain_composition : ∃ y s, chain.Intrinsic y ∧
    SemanticGroundingClosure chain.SemanticallyGrounds y 3 ∧
    chain.Realizes s y ∧ chain.Conscious s :=
  semantic_reaches_conscious_realizer chain chain_semantic chain_realization 3 trivial

/-- Realizer existence is independent of the universal consciousness condition. -/
def unrealized : Setting Unit Unit :=
  { dataOnly with
    Semantic := fun _ => True
    Intrinsic := fun _ => True }

def unrealized_semantic : SemanticPremises unrealized :=
  ⟨fun _ _ => Or.inl trivial, empty_wf⟩

theorem unrealized_guard :
    (∀ s y, unrealized.Intrinsic y → unrealized.Realizes s y → unrealized.Conscious s) ∧
    ¬(∀ y, unrealized.Intrinsic y → ∃ s, unrealized.Realizes s y) :=
  ⟨fun _ _ _ h => h.elim, fun h => let ⟨_, hr⟩ := h () trivial; hr⟩

end SemanticGrounding.Audit

#print axioms SemanticGrounding.semantic_reaches_intrinsic
#print axioms SemanticGrounding.semantic_reaches_conscious_realizer

/- The public proofs and model witnesses are checked through kernel terms.
Lean-generated constructor injectivity equalities are audited separately. -/
run_cmd do
  let env ← Lean.getEnv
  for (name, _) in env.constants.toList do
    if (`SemanticGrounding).isPrefixOf name then
      let axioms ← Lean.collectAxioms name
      unless axioms.isEmpty || (name == `SemanticGrounding.Setting.mk.injEq && axioms == #[`propext]) do
        throwError "Unexpected axiom dependencies for {name}: {axioms}"
