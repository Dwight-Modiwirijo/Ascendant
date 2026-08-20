/-
  Public-surface correspondence check for the world-indexed certificate API.
  All modal claims below quantify over arbitrary frames and selected worlds.
-/

import AltRoute.PublicTests
import AltRoute.GroundingAudit
import AltRoute.GroundingChainAudit
import AltRoute.GroundingModel

namespace AltRoute.PublicCertificateAudit

open AltRoute

/-! Derived S5 surface: laws are theorems, not fields. -/
#check AltRoute.Frame
#check AltRoute.Frame.Box
#check AltRoute.Frame.Dia
#check AltRoute.Frame.ax_T
#check AltRoute.Frame.ax_4
#check AltRoute.Frame.ax_5
#check AltRoute.Frame.K
#check AltRoute.Frame.duality
#check AltRoute.Frame.actual_possible

/-! Exported positivity and public certificate claims. -/
#check AltRoute.Positive
#check AltRoute.SomePosNecPossible
#check AltRoute.necPossible_of_Pos
#check AltRoute.somePosNecPossible_of_exists
#check AltRoute.false_not_positive
#check AltRoute.empty_extension_not_positive
#check AltRoute.exists_of_positive
#check AltRoute.PosPossibility

/-! Permanent non-collapse, contingency, and degenerate-model witnesses. -/
#check AltRoute.PublicTests.UniversalBoolFrame
#check AltRoute.PublicTests.box_not_identity
#check AltRoute.PublicTests.contingency_witness
#check AltRoute.PublicTests.certificate_not_trivial
#check AltRoute.PublicTests.TrivialModel
#check AltRoute.PublicTests.exFalsoQuodlibet
#check AltRoute.PublicTests.GroundingRelation
#check AltRoute.PublicTests.traverse_to_omega
#check AltRoute.PublicTests.InferenceResult
#check AltRoute.PublicTests.trivialModel_box_collapses
#check AltRoute.PublicTests.trivialModel_dia_collapses
#check AltRoute.PublicTests.UnitPositive
#check AltRoute.PublicTests.unit_positive_possible
#check AltRoute.PublicTests.no_positive_on_empty
#check AltRoute.PublicTests.dia_not_constantly_false
#check AltRoute.PublicTests.dia_not_constantly_true

/-! Axiom-footprint inspection for every public logical declaration. -/
#print AltRoute.PosPossibility
#print AltRoute.necPossible_of_Pos
#print axioms AltRoute.Frame.ax_T
#print axioms AltRoute.Frame.ax_4
#print axioms AltRoute.Frame.ax_5
#print axioms AltRoute.Frame.K
#print axioms AltRoute.Frame.duality
#print axioms AltRoute.Frame.actual_possible
#print axioms AltRoute.false_not_positive
#print axioms AltRoute.empty_extension_not_positive
#print axioms AltRoute.exists_of_positive
#print axioms AltRoute.PosPossibility
#print axioms AltRoute.necPossible_of_Pos
#print axioms AltRoute.SomePosNecPossible
#print axioms AltRoute.somePosNecPossible_of_exists
#print axioms AltRoute.PublicTests.box_not_identity
#print axioms AltRoute.PublicTests.contingency_witness
#print axioms AltRoute.PublicTests.certificate_not_trivial
#print axioms AltRoute.PublicTests.TrivialModel
#print axioms AltRoute.PublicTests.exFalsoQuodlibet
#print axioms AltRoute.PublicTests.GroundingRelation
#print axioms AltRoute.PublicTests.traverse_to_omega
#print axioms AltRoute.PublicTests.evaluate_statement
#print axioms AltRoute.PublicTests.forceful_evaluator
#print axioms AltRoute.PublicTests.trivialModel_box_collapses
#print axioms AltRoute.PublicTests.trivialModel_dia_collapses
#print axioms AltRoute.PublicTests.UnitPositive
#print axioms AltRoute.PublicTests.unit_positive_possible
#print axioms AltRoute.PublicTests.no_positive_on_empty
#print axioms AltRoute.PublicTests.dia_not_constantly_false
#print axioms AltRoute.PublicTests.dia_not_constantly_true


/-! W11 grounding acceptance surface and the mechanically detected gap. -/
#check AltRoute.Target.NE_Target
#check AltRoute.Target.BoxUnique_Target
#check AltRoute.Target.RigidWitness_Target
#check AltRoute.Target.GroundingPremises
#check AltRoute.GroundingAudit.premises_false
#check AltRoute.GroundingAudit.obligation_NE_from_inconsistent_bundle
#check AltRoute.GroundingAudit.obligation_BoxUnique_from_inconsistent_bundle
#check AltRoute.GroundingAudit.obligation_BoxUnique_Reductio_from_inconsistent_bundle
#check AltRoute.GroundingAudit.obligation_RigidWitness_from_inconsistent_bundle
#check AltRoute.GroundingAudit.c1c2_yields_actual
#check AltRoute.GroundingAudit.c1c2_yields_possible
#check AltRoute.GroundingAudit.c1c2_yields_necessary
#check AltRoute.GroundingAudit.c1c2_yields_possible_necessary
#check AltRoute.GroundingAudit.datum_field_refutes_all
#check AltRoute.GroundingAudit.hm_psr_field_refutes_all
#check AltRoute.GroundingAudit.anti_regress_field_refutes_all
#check AltRoute.GroundingAudit.coalescence_field_refutes_all
#check AltRoute.GroundingAudit.terminus_is_Omega_field_refutes_all

#print axioms AltRoute.GroundingAudit.premises_false
#print axioms AltRoute.GroundingAudit.obligation_NE_from_inconsistent_bundle
#print axioms AltRoute.GroundingAudit.obligation_BoxUnique_from_inconsistent_bundle
#print axioms AltRoute.GroundingAudit.obligation_BoxUnique_Reductio_from_inconsistent_bundle
#print axioms AltRoute.GroundingAudit.obligation_RigidWitness_from_inconsistent_bundle
#print axioms AltRoute.GroundingAudit.c1c2_yields_actual
#print axioms AltRoute.GroundingAudit.c1c2_yields_possible
#print axioms AltRoute.GroundingAudit.c1c2_yields_necessary
#print axioms AltRoute.GroundingAudit.c1c2_yields_possible_necessary

/-! Current public strong route: exact declarations, terms, and footprints. -/
#check AltRoute.GroundingChain.C5_NE
#check AltRoute.GroundingChain.C5_BoxUnique
#check AltRoute.GroundingChain.C5_RigidWitness

#print AltRoute.GroundingChain.C5_NE
#print AltRoute.GroundingChain.C5_BoxUnique
#print AltRoute.GroundingChain.C5_RigidWitness

#print axioms AltRoute.GroundingChain.C5_NE
#print axioms AltRoute.GroundingChain.C5_BoxUnique
#print axioms AltRoute.GroundingChain.C5_RigidWitness

/-! Individual-premise and joint-model audits for the current C5 route. -/
#check AltRoute.GroundingChainAudit.c1_refutes_all
#check AltRoute.GroundingChainAudit.ground_obtains_refutes_all
#check AltRoute.GroundingChainAudit.c3_refutes_all
#check AltRoute.GroundingChainAudit.c4a_refutes_all
#check AltRoute.GroundingChainAudit.datum_obtains_refutes_all
#check AltRoute.GroundingModel.m_C2
#check AltRoute.GroundingModel.m_not_collapsed
#check AltRoute.GroundingModel.m_conclusion

#print axioms AltRoute.GroundingChainAudit.c1_refutes_all
#print axioms AltRoute.GroundingChainAudit.ground_obtains_refutes_all
#print axioms AltRoute.GroundingChainAudit.c3_refutes_all
#print axioms AltRoute.GroundingChainAudit.c4a_refutes_all
#print axioms AltRoute.GroundingChainAudit.datum_obtains_refutes_all
#print axioms AltRoute.GroundingModel.m_C2
#print axioms AltRoute.GroundingModel.m_not_collapsed
#print axioms AltRoute.GroundingModel.m_conclusion
/-! W12 premise-level question-begging audit for the current C5 public route. -/
#check AltRoute.GroundingChainAudit.W12_PremiseNames
#check AltRoute.GroundingChainAudit.W12_TargetNames
#check AltRoute.GroundingChainAudit.W12_PremiseAuditManifest
#check AltRoute.GroundingChainAudit.c1_not_actual
#check AltRoute.GroundingChainAudit.c1_not_possible
#check AltRoute.GroundingChainAudit.c1_not_necessary
#check AltRoute.GroundingChainAudit.c1_not_possible_necessary
#check AltRoute.GroundingChainAudit.ground_obtains_not_actual
#check AltRoute.GroundingChainAudit.ground_obtains_not_possible
#check AltRoute.GroundingChainAudit.ground_obtains_not_necessary
#check AltRoute.GroundingChainAudit.ground_obtains_not_possible_necessary
#check AltRoute.GroundingChainAudit.c3_not_actual
#check AltRoute.GroundingChainAudit.c3_not_possible
#check AltRoute.GroundingChainAudit.c3_not_necessary
#check AltRoute.GroundingChainAudit.c3_not_possible_necessary
#check AltRoute.GroundingChainAudit.c4a_not_actual
#check AltRoute.GroundingChainAudit.c4a_not_possible
#check AltRoute.GroundingChainAudit.c4a_not_necessary
#check AltRoute.GroundingChainAudit.c4a_not_possible_necessary
#check AltRoute.GroundingChainAudit.datum_not_actual
#check AltRoute.GroundingChainAudit.datum_not_possible
#check AltRoute.GroundingChainAudit.datum_not_necessary
#check AltRoute.GroundingChainAudit.datum_not_possible_necessary

#print axioms AltRoute.GroundingChainAudit.c1_not_actual
#print axioms AltRoute.GroundingChainAudit.c1_not_possible
#print axioms AltRoute.GroundingChainAudit.c1_not_necessary
#print axioms AltRoute.GroundingChainAudit.c1_not_possible_necessary
#print axioms AltRoute.GroundingChainAudit.ground_obtains_not_actual
#print axioms AltRoute.GroundingChainAudit.ground_obtains_not_possible
#print axioms AltRoute.GroundingChainAudit.ground_obtains_not_necessary
#print axioms AltRoute.GroundingChainAudit.ground_obtains_not_possible_necessary
#print axioms AltRoute.GroundingChainAudit.c3_not_actual
#print axioms AltRoute.GroundingChainAudit.c3_not_possible
#print axioms AltRoute.GroundingChainAudit.c3_not_necessary
#print axioms AltRoute.GroundingChainAudit.c3_not_possible_necessary
#print axioms AltRoute.GroundingChainAudit.c4a_not_actual
#print axioms AltRoute.GroundingChainAudit.c4a_not_possible
#print axioms AltRoute.GroundingChainAudit.c4a_not_necessary
#print axioms AltRoute.GroundingChainAudit.c4a_not_possible_necessary
#print axioms AltRoute.GroundingChainAudit.datum_not_actual
#print axioms AltRoute.GroundingChainAudit.datum_not_possible
#print axioms AltRoute.GroundingChainAudit.datum_not_necessary
#print axioms AltRoute.GroundingChainAudit.datum_not_possible_necessary
end AltRoute.PublicCertificateAudit

