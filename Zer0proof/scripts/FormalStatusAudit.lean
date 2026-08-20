import AltRoute.PublicCertificateAudit

#eval IO.println "FORMAL_STATUS_TYPE_BEGIN AltRoute.GroundingChain.C5_NE"
#check AltRoute.GroundingChain.C5_NE
#eval IO.println "FORMAL_STATUS_TYPE_END AltRoute.GroundingChain.C5_NE"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChain.C5_NE"
#print axioms AltRoute.GroundingChain.C5_NE
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChain.C5_NE"

#eval IO.println "FORMAL_STATUS_TYPE_BEGIN AltRoute.GroundingChain.C5_BoxUnique"
#check AltRoute.GroundingChain.C5_BoxUnique
#eval IO.println "FORMAL_STATUS_TYPE_END AltRoute.GroundingChain.C5_BoxUnique"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChain.C5_BoxUnique"
#print axioms AltRoute.GroundingChain.C5_BoxUnique
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChain.C5_BoxUnique"

#eval IO.println "FORMAL_STATUS_TYPE_BEGIN AltRoute.GroundingChain.C5_RigidWitness"
#check AltRoute.GroundingChain.C5_RigidWitness
#eval IO.println "FORMAL_STATUS_TYPE_END AltRoute.GroundingChain.C5_RigidWitness"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChain.C5_RigidWitness"
#print axioms AltRoute.GroundingChain.C5_RigidWitness
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChain.C5_RigidWitness"

#eval IO.println "FORMAL_STATUS_TYPE_BEGIN AltRoute.GroundingModel.m_conclusion"
#check AltRoute.GroundingModel.m_conclusion
#eval IO.println "FORMAL_STATUS_TYPE_END AltRoute.GroundingModel.m_conclusion"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingModel.m_conclusion"
#print axioms AltRoute.GroundingModel.m_conclusion
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingModel.m_conclusion"

#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingModel.m_not_collapsed"
#print axioms AltRoute.GroundingModel.m_not_collapsed
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingModel.m_not_collapsed"

#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c1_refutes_all"
#print axioms AltRoute.GroundingChainAudit.c1_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c1_refutes_all"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.ground_obtains_refutes_all"
#print axioms AltRoute.GroundingChainAudit.ground_obtains_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.ground_obtains_refutes_all"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c3_refutes_all"
#print axioms AltRoute.GroundingChainAudit.c3_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c3_refutes_all"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c4a_refutes_all"
#print axioms AltRoute.GroundingChainAudit.c4a_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c4a_refutes_all"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.datum_obtains_refutes_all"
#print axioms AltRoute.GroundingChainAudit.datum_obtains_refutes_all
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.datum_obtains_refutes_all"

#eval IO.println "FORMAL_STATUS_W12_LIST_BEGIN"
#eval do
  for p in AltRoute.GroundingChainAudit.W12_PremiseNames do
    IO.println ("W12_PREMISE=" ++ p)
#eval do
  for t in AltRoute.GroundingChainAudit.W12_TargetNames do
    IO.println ("W12_TARGET=" ++ t)
#eval do
  for (premise, thm) in AltRoute.GroundingChainAudit.W12_PremiseAuditManifest do
    IO.println ("W12_MANIFEST=" ++ premise ++ "::" ++ thm)
#eval IO.println "FORMAL_STATUS_W12_LIST_END"

#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c1_not_actual"
#print axioms AltRoute.GroundingChainAudit.c1_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c1_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c1_not_possible"
#print axioms AltRoute.GroundingChainAudit.c1_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c1_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c1_not_necessary"
#print axioms AltRoute.GroundingChainAudit.c1_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c1_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c1_not_possible_necessary"
#print axioms AltRoute.GroundingChainAudit.c1_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c1_not_possible_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.ground_obtains_not_actual"
#print axioms AltRoute.GroundingChainAudit.ground_obtains_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.ground_obtains_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.ground_obtains_not_possible"
#print axioms AltRoute.GroundingChainAudit.ground_obtains_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.ground_obtains_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.ground_obtains_not_necessary"
#print axioms AltRoute.GroundingChainAudit.ground_obtains_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.ground_obtains_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.ground_obtains_not_possible_necessary"
#print axioms AltRoute.GroundingChainAudit.ground_obtains_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.ground_obtains_not_possible_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c3_not_actual"
#print axioms AltRoute.GroundingChainAudit.c3_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c3_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c3_not_possible"
#print axioms AltRoute.GroundingChainAudit.c3_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c3_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c3_not_necessary"
#print axioms AltRoute.GroundingChainAudit.c3_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c3_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c3_not_possible_necessary"
#print axioms AltRoute.GroundingChainAudit.c3_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c3_not_possible_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c4a_not_actual"
#print axioms AltRoute.GroundingChainAudit.c4a_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c4a_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c4a_not_possible"
#print axioms AltRoute.GroundingChainAudit.c4a_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c4a_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c4a_not_necessary"
#print axioms AltRoute.GroundingChainAudit.c4a_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c4a_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.c4a_not_possible_necessary"
#print axioms AltRoute.GroundingChainAudit.c4a_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.c4a_not_possible_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.datum_not_actual"
#print axioms AltRoute.GroundingChainAudit.datum_not_actual
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.datum_not_actual"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.datum_not_possible"
#print axioms AltRoute.GroundingChainAudit.datum_not_possible
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.datum_not_possible"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.datum_not_necessary"
#print axioms AltRoute.GroundingChainAudit.datum_not_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.datum_not_necessary"
#eval IO.println "FORMAL_STATUS_AXIOMS_BEGIN AltRoute.GroundingChainAudit.datum_not_possible_necessary"
#print axioms AltRoute.GroundingChainAudit.datum_not_possible_necessary
#eval IO.println "FORMAL_STATUS_AXIOMS_END AltRoute.GroundingChainAudit.datum_not_possible_necessary"


