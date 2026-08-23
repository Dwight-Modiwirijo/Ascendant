import AscendantRoute.PublicCertificateAudit
import HyperModal

#eval IO.println "FORMAL_STATUS_TYPE_BEGIN AscendantRoute.GroundingChain.C5_NE"
#check AscendantRoute.GroundingChain.C5_NE
#eval IO.println "FORMAL_STATUS_TYPE_END AscendantRoute.GroundingChain.C5_NE"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChain.C5_NE"
#print axioms AscendantRoute.GroundingChain.C5_NE
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChain.C5_NE"

#eval IO.println "FORMAL_STATUS_TYPE_BEGIN AscendantRoute.GroundingChain.C5_BoxUnique"
#check AscendantRoute.GroundingChain.C5_BoxUnique
#eval IO.println "FORMAL_STATUS_TYPE_END AscendantRoute.GroundingChain.C5_BoxUnique"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChain.C5_BoxUnique"
#print axioms AscendantRoute.GroundingChain.C5_BoxUnique
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChain.C5_BoxUnique"

#eval IO.println "FORMAL_STATUS_TYPE_BEGIN AscendantRoute.GroundingChain.C5_RigidWitness"
#check AscendantRoute.GroundingChain.C5_RigidWitness
#eval IO.println "FORMAL_STATUS_TYPE_END AscendantRoute.GroundingChain.C5_RigidWitness"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChain.C5_RigidWitness"
#print axioms AscendantRoute.GroundingChain.C5_RigidWitness
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChain.C5_RigidWitness"

#eval IO.println "FORMAL_STATUS_TYPE_BEGIN AscendantRoute.GroundingModel.m_conclusion"
#check AscendantRoute.GroundingModel.m_conclusion
#eval IO.println "FORMAL_STATUS_TYPE_END AscendantRoute.GroundingModel.m_conclusion"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingModel.m_conclusion"
#print axioms AscendantRoute.GroundingModel.m_conclusion
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingModel.m_conclusion"

#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingModel.m_not_collapsed"
#print axioms AscendantRoute.GroundingModel.m_not_collapsed
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingModel.m_not_collapsed"

#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c1_refutes_all"
#print axioms AscendantRoute.GroundingChainAudit.c1_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c1_refutes_all"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.ground_obtains_refutes_all"
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.ground_obtains_refutes_all"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c3_refutes_all"
#print axioms AscendantRoute.GroundingChainAudit.c3_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c3_refutes_all"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c4a_refutes_all"
#print axioms AscendantRoute.GroundingChainAudit.c4a_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c4a_refutes_all"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.datum_obtains_refutes_all"
#print axioms AscendantRoute.GroundingChainAudit.datum_obtains_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.datum_obtains_refutes_all"

#eval IO.println "FORMAL_STATUS_W12_LIST_BEGIN"
#eval do
  for p in AscendantRoute.GroundingChainAudit.W12_PremiseNames do
    IO.println ("W12_PREMISE=" ++ p)
#eval do
  for t in AscendantRoute.GroundingChainAudit.W12_TargetNames do
    IO.println ("W12_TARGET=" ++ t)
#eval do
  for (premise, thm) in AscendantRoute.GroundingChainAudit.W12_PremiseAuditManifest do
    IO.println ("W12_MANIFEST=" ++ premise ++ "::" ++ thm)
#eval IO.println "FORMAL_STATUS_W12_LIST_END"

#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c1_not_actual"
#print axioms AscendantRoute.GroundingChainAudit.c1_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c1_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c1_not_possible"
#print axioms AscendantRoute.GroundingChainAudit.c1_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c1_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c1_not_necessary"
#print axioms AscendantRoute.GroundingChainAudit.c1_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c1_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c1_not_possible_necessary"
#print axioms AscendantRoute.GroundingChainAudit.c1_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c1_not_possible_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.ground_obtains_not_actual"
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.ground_obtains_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.ground_obtains_not_possible"
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.ground_obtains_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.ground_obtains_not_necessary"
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.ground_obtains_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.ground_obtains_not_possible_necessary"
#print axioms AscendantRoute.GroundingChainAudit.ground_obtains_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.ground_obtains_not_possible_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c3_not_actual"
#print axioms AscendantRoute.GroundingChainAudit.c3_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c3_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c3_not_possible"
#print axioms AscendantRoute.GroundingChainAudit.c3_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c3_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c3_not_necessary"
#print axioms AscendantRoute.GroundingChainAudit.c3_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c3_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c3_not_possible_necessary"
#print axioms AscendantRoute.GroundingChainAudit.c3_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c3_not_possible_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c4a_not_actual"
#print axioms AscendantRoute.GroundingChainAudit.c4a_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c4a_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c4a_not_possible"
#print axioms AscendantRoute.GroundingChainAudit.c4a_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c4a_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c4a_not_necessary"
#print axioms AscendantRoute.GroundingChainAudit.c4a_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c4a_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.c4a_not_possible_necessary"
#print axioms AscendantRoute.GroundingChainAudit.c4a_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.c4a_not_possible_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.datum_not_actual"
#print axioms AscendantRoute.GroundingChainAudit.datum_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.datum_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.datum_not_possible"
#print axioms AscendantRoute.GroundingChainAudit.datum_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.datum_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.datum_not_necessary"
#print axioms AscendantRoute.GroundingChainAudit.datum_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.datum_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AscendantRoute.GroundingChainAudit.datum_not_possible_necessary"
#print axioms AscendantRoute.GroundingChainAudit.datum_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AscendantRoute.GroundingChainAudit.datum_not_possible_necessary"

#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.logic_necessity"
#print axioms HyperModal.logic_necessity
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.logic_necessity"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.meta_logic"
#print axioms HyperModal.meta_logic
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.meta_logic"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.posT_box"
#print axioms HyperModal.posT_box
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.posT_box"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.posT_iff_box"
#print axioms HyperModal.posT_iff_box
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.posT_iff_box"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.triad_holds"
#print axioms HyperModal.triad_holds
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.triad_holds"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.posT_box_core"
#print axioms HyperModal.posT_box_core
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.posT_box_core"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.posT_not_both"
#print axioms HyperModal.posT_not_both
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.posT_not_both"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.Historical.perfect_positivity_refutation"
#print axioms HyperModal.Historical.perfect_positivity_refutation
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.Historical.perfect_positivity_refutation"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.Historical.consciousness_axiom_refutation"
#print axioms HyperModal.Historical.consciousness_axiom_refutation
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.Historical.consciousness_axiom_refutation"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.Historical.anti_regress_refutation"
#print axioms HyperModal.Historical.anti_regress_refutation
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.Historical.anti_regress_refutation"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.Historical.logic_material_trio_refutation"
#print axioms HyperModal.Historical.logic_material_trio_refutation
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.Historical.logic_material_trio_refutation"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.Model.setting_inhabited"
#print axioms HyperModal.Model.setting_inhabited
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.Model.setting_inhabited"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.Model.omega_possible"
#print axioms HyperModal.Model.omega_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.Model.omega_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.Model.grounding_nonempty"
#print axioms HyperModal.Model.grounding_nonempty
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.Model.grounding_nonempty"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN HyperModal.Model.frame_not_collapsed"
#print axioms HyperModal.Model.frame_not_collapsed
#eval IO.println "FORMAL_STATUS_AXIOMS_END HyperModal.Model.frame_not_collapsed"
