import AscendantRoute.PublicCertificateAudit

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


