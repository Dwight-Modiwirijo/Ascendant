/-! Semantic grounding is independent of modal and machine contracts. -/
namespace SemanticGrounding

structure Setting (Content : Type u) (Subject : Type v) where
  Data : Content → Prop
  Semantic : Content → Prop
  Intrinsic : Content → Prop
  SemanticallyGrounds : Content → Content → Prop
  Realizes : Subject → Content → Prop
  Conscious : Subject → Prop

/-- Reflexivity permits an intrinsic input to be its own reachable source.
An edge runs from the upstream ground to the grounded content. -/
inductive SemanticGroundingClosure (r : α → α → Prop) : α → α → Prop
  | refl (x) : SemanticGroundingClosure r x x
  | tail : SemanticGroundingClosure r y z → r z x → SemanticGroundingClosure r y x

structure SemanticPremises (S : Setting C U) : Prop where
  semantic_decomposition : ∀ x, S.Semantic x →
    S.Intrinsic x ∨ ∃ y, S.Semantic y ∧ S.SemanticallyGrounds y x
  wellFounded : WellFounded S.SemanticallyGrounds

structure RealizationPremises (S : Setting C U) : Prop where
  intrinsic_has_realizer : ∀ y, S.Intrinsic y → ∃ s, S.Realizes s y
  intrinsic_realizer_is_conscious : ∀ s y,
    S.Intrinsic y → S.Realizes s y → S.Conscious s

/-- Decomposition supplies semantic content for the chosen predecessor.
Preservation on every edge is stronger and is not needed by this proof. -/
theorem semantic_reaches_intrinsic (S : Setting C U) (P : SemanticPremises S)
    (x : C) (hx : S.Semantic x) :
    ∃ y, S.Intrinsic y ∧ SemanticGroundingClosure S.SemanticallyGrounds y x := by
  induction x using P.wellFounded.induction with
  | h x ih =>
    rcases P.semantic_decomposition x hx with hi | ⟨y, hy, hyx⟩
    · exact ⟨x, hi, .refl x⟩
    · obtain ⟨z, hz, hzy⟩ := ih y hyx hy
      exact ⟨z, hz, .tail hzy hyx⟩

theorem semantic_reaches_conscious_realizer (S : Setting C U)
    (P : SemanticPremises S) (R : RealizationPremises S)
    (x : C) (hx : S.Semantic x) :
    ∃ y s, S.Intrinsic y ∧ SemanticGroundingClosure S.SemanticallyGrounds y x ∧
      S.Realizes s y ∧ S.Conscious s := by
  obtain ⟨y, hi, hg⟩ := semantic_reaches_intrinsic S P x hx
  obtain ⟨s, hr⟩ := R.intrinsic_has_realizer y hi
  exact ⟨y, s, hi, hg, hr, R.intrinsic_realizer_is_conscious s y hi hr⟩

end SemanticGrounding
