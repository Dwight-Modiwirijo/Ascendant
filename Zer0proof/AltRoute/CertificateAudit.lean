/-
  Strong certificate audit.

  AltRoute.StrongCertificates is intentionally supplied as an `.olean`
  assembly. Its private `.lean` implementation is outside the public source
  boundary. This file is the public theorem-certificate surface.
-/

import AltRoute.PublicCertificateAudit
import AltRoute.StrongCertificates

namespace AltRoute.CertificateAudit

#check Final_NE_Proof
#check Final_BoxUnique_Proof
#check Final_RigidWitness_Proof

#print Final_NE_Proof
#print Final_BoxUnique_Proof
#print Final_RigidWitness_Proof

#print axioms Final_NE_Proof
#print axioms Final_BoxUnique_Proof
#print axioms Final_RigidWitness_Proof

end AltRoute.CertificateAudit
