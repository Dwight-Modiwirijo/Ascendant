/-
  Public-surface correspondence check for the world-indexed certificate API.
  All modal claims below quantify over arbitrary frames and selected worlds.
-/

import AscendantRoute.PublicTests
import AscendantRoute.GroundingAudit
import AscendantRoute.GroundingChainAudit
import AscendantRoute.GroundingModel

namespace AscendantRoute.PublicCertificateAudit

open AscendantRoute

/-! Derived S5 surface: laws are theorems, not fields. -/
#check AscendantRoute.Frame
#check AscendantRoute.Frame.Box
#check AscendantRoute.Frame.Dia
#check AscendantRoute.Frame.ax_T
#check AscendantRoute.Frame.ax_4
#check AscendantRoute.Frame.ax_5
#check AscendantRoute.Frame.K
#check AscendantRoute.Frame.duality
#check AscendantRoute.Frame.actual_possible

/-! Exported positivity and public certificate claims. -/
#check AscendantRoute.Positive
#check AscendantRoute.SomePosNecPossible
#check AscendantRoute.necPossible_of_Pos
#check AscendantRoute.somePosNecPossible_of_exists
#check AscendantRoute.false_not_positive
#check AscendantRoute.empty_extension_not_positive
#check AscendantRoute.exists_of_positive
#check AscendantRoute.PosPossibility

/-! Permanent non-collapse, contingency, and degenerate-model witnesses. -/
#check AscendantRoute.PublicTests.UniversalBoolFrame
#check AscendantRoute.PublicTests.box_not_identity
#check AscendantRoute.PublicTests.contingency_witness
#check AscendantRoute.PublicTests.certificate_not_trivial
#check AscendantRoute.PublicTests.TrivialModel
#check AscendantRoute.PublicTests.exFalsoQuodlibet
#check AscendantRoute.PublicTests.GroundingRelation
#check AscendantRoute.PublicTests.traverse_to_omega
#check AscendantRoute.PublicTests.InferenceResult
#check AscendantRoute.PublicTests.trivialModel_box_collapses
#check AscendantRoute.PublicTests.trivialModel_dia_collapses
#check AscendantRoute.PublicTests.UnitPositive
#check AscendantRoute.PublicTests.unit_positive_possible
#check AscendantRoute.PublicTests.no_positive_on_empty
#check AscendantRoute.PublicTests.dia_not_constantly_false
#check AscendantRoute.PublicTests.dia_not_constantly_true

/-! Axiom-footprint inspection for every public logical declaration. -/
#print AscendantRoute.PosPossibility
#print AscendantRoute.necPossible_of_Pos
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
#print axioms AscendantRoute.PublicTests.box_not_identity
#print axioms AscendantRoute.PublicTests.contingency_witness
#print axioms AscendantRoute.PublicTests.certificate_not_trivial
#print axioms AscendantRoute.PublicTests.TrivialModel
#print axioms AscendantRoute.PublicTests.exFalsoQuodlibet
#print axioms AscendantRoute.PublicTests.GroundingRelation
#print axioms AscendantRoute.PublicTests.traverse_to_omega
#print axioms AscendantRoute.PublicTests.evaluate_statement
#print axioms AscendantRoute.PublicTests.forceful_evaluator
#print axioms AscendantRoute.PublicTests.trivialModel_box_collapses
#print axioms AscendantRoute.PublicTests.trivialModel_dia_collapses
#print axioms AscendantRoute.PublicTests.UnitPositive
#print axioms AscendantRoute.PublicTests.unit_positive_possible
#print axioms AscendantRoute.PublicTests.no_positive_on_empty
#print axioms AscendantRoute.PublicTests.dia_not_constantly_false
#print axioms AscendantRoute.PublicTests.dia_not_constantly_true


/-! W11 grounding acceptance surface and the mechanically detected gap. -/
#check AscendantRoute.Target.NE_Target
#check AscendantRoute.Target.BoxUnique_Target
#check AscendantRoute.Target.RigidWitness_Target
#check AscendantRoute.Target.GroundingPremises
#check AscendantRoute.GroundingAudit.premises_false
#check AscendantRoute.GroundingAudit.obligation_NE_from_inconsistent_bundle
#check AscendantRoute.GroundingAudit.obligation_BoxUnique_from_inconsistent_bundle
#check AscendantRoute.GroundingAudit.obligation_BoxUnique_Reductio_from_inconsistent_bundle
#check AscendantRoute.GroundingAudit.obligation_RigidWitness_from_inconsistent_bundle
#check AscendantRoute.GroundingAudit.c1c2_yields_actual
#check AscendantRoute.GroundingAudit.c1c2_yields_possible
#check AscendantRoute.GroundingAudit.c1c2_yields_necessary
#check AscendantRoute.GroundingAudit.c1c2_yields_possible_necessary
#check AscendantRoute.GroundingAudit.datum_field_refutes_all
#check AscendantRoute.GroundingAudit.hm_psr_field_refutes_all
#check AscendantRoute.GroundingAudit.anti_regress_field_refutes_all
#check AscendantRoute.GroundingAudit.coalescence_field_refutes_all
#check AscendantRoute.GroundingAudit.terminus_is_Omega_field_refutes_all

#print axioms AscendantRoute.GroundingAudit.premises_false
#print axioms AscendantRoute.GroundingAudit.obligation_NE_from_inconsistent_bundle
#print axioms AscendantRoute.GroundingAudit.obligation_BoxUnique_from_inconsistent_bundle
#print axioms AscendantRoute.GroundingAudit.obligation_BoxUnique_Reductio_from_inconsistent_bundle
#print axioms AscendantRoute.GroundingAudit.obligation_RigidWitness_from_inconsistent_bundle
#print axioms AscendantRoute.GroundingAudit.c1c2_yields_actual
#print axioms AscendantRoute.GroundingAudit.c1c2_yields_possible
#print axioms AscendantRoute.GroundingAudit.c1c2_yields_necessary
#print axioms AscendantRoute.GroundingAudit.c1c2_yields_possible_necessary

/-! Current public strong route: exact declarations, terms, and footprints. -/
#check AscendantRoute.GroundingChain.C5_NE
#check AscendantRoute.GroundingChain.C5_BoxUnique
#check AscendantRoute.GroundingChain.C5_RigidWitness

#print AscendantRoute.GroundingChain.C5_NE
#print AscendantRoute.GroundingChain.C5_BoxUnique
#print AscendantRoute.GroundingChain.C5_RigidWitness

#print axioms AscendantRoute.GroundingChain.C5_NE
#print axioms AscendantRoute.GroundingChain.C5_BoxUnique
#print axioms AscendantRoute.GroundingChain.C5_RigidWitness

/-! Individual-premise and joint-model audits for the current C5 route. -/
#check AscendantRoute.GroundingChainAudit.c1_refutes_all
#check AscendantRoute.GroundingChainAudit.ground_obtains_refutes_all
#check AscendantRoute.GroundingChainAudit.c3_refutes_all
#check AscendantRoute.GroundingChainAudit.c4a_refutes_all
#check AscendantRoute.GroundingChainAudit.datum_obtains_refutes_all
#check AscendantRoute.GroundingModel.m_C2
#check AscendantRoute.GroundingModel.m_not_collapsed
#check AscendantRoute.GroundingModel.m_conclusion

#print axioms AscendantRoute.GroundingChainAudit.c1_refutes_all
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_refutes_all
#print axioms AscendantRoute.GroundingChainAudit.c3_refutes_all
#print axioms AscendantRoute.GroundingChainAudit.c4a_refutes_all
#print axioms AscendantRoute.GroundingChainAudit.datum_obtains_refutes_all
#print axioms AscendantRoute.GroundingModel.m_C2
#print axioms AscendantRoute.GroundingModel.m_not_collapsed
#print axioms AscendantRoute.GroundingModel.m_conclusion
/-! W12 premise-level question-begging audit for the current C5 public route. -/
#check AscendantRoute.GroundingChainAudit.W12_PremiseNames
#check AscendantRoute.GroundingChainAudit.W12_TargetNames
#check AscendantRoute.GroundingChainAudit.W12_PremiseAuditManifest
#check AscendantRoute.GroundingChainAudit.c1_not_actual
#check AscendantRoute.GroundingChainAudit.c1_not_possible
#check AscendantRoute.GroundingChainAudit.c1_not_necessary
#check AscendantRoute.GroundingChainAudit.c1_not_possible_necessary
#check AscendantRoute.GroundingChainAudit.ground_obtains_not_actual
#check AscendantRoute.GroundingChainAudit.ground_obtains_not_possible
#check AscendantRoute.GroundingChainAudit.ground_obtains_not_necessary
#check AscendantRoute.GroundingChainAudit.ground_obtains_not_possible_necessary
#check AscendantRoute.GroundingChainAudit.c3_not_actual
#check AscendantRoute.GroundingChainAudit.c3_not_possible
#check AscendantRoute.GroundingChainAudit.c3_not_necessary
#check AscendantRoute.GroundingChainAudit.c3_not_possible_necessary
#check AscendantRoute.GroundingChainAudit.c4a_not_actual
#check AscendantRoute.GroundingChainAudit.c4a_not_possible
#check AscendantRoute.GroundingChainAudit.c4a_not_necessary
#check AscendantRoute.GroundingChainAudit.c4a_not_possible_necessary
#check AscendantRoute.GroundingChainAudit.datum_not_actual
#check AscendantRoute.GroundingChainAudit.datum_not_possible
#check AscendantRoute.GroundingChainAudit.datum_not_necessary
#check AscendantRoute.GroundingChainAudit.datum_not_possible_necessary

#print axioms AscendantRoute.GroundingChainAudit.c1_not_actual
#print axioms AscendantRoute.GroundingChainAudit.c1_not_possible
#print axioms AscendantRoute.GroundingChainAudit.c1_not_necessary
#print axioms AscendantRoute.GroundingChainAudit.c1_not_possible_necessary
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_not_actual
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_not_possible
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_not_necessary
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_not_possible_necessary
#print axioms AscendantRoute.GroundingChainAudit.c3_not_actual
#print axioms AscendantRoute.GroundingChainAudit.c3_not_possible
#print axioms AscendantRoute.GroundingChainAudit.c3_not_necessary
#print axioms AscendantRoute.GroundingChainAudit.c3_not_possible_necessary
#print axioms AscendantRoute.GroundingChainAudit.c4a_not_actual
#print axioms AscendantRoute.GroundingChainAudit.c4a_not_possible
#print axioms AscendantRoute.GroundingChainAudit.c4a_not_necessary
#print axioms AscendantRoute.GroundingChainAudit.c4a_not_possible_necessary
#print axioms AscendantRoute.GroundingChainAudit.datum_not_actual
#print axioms AscendantRoute.GroundingChainAudit.datum_not_possible
#print axioms AscendantRoute.GroundingChainAudit.datum_not_necessary
#print axioms AscendantRoute.GroundingChainAudit.datum_not_possible_necessary
end AscendantRoute.PublicCertificateAudit

