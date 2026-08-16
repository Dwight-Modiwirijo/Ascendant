/-
  Strong certificate audit.

  `AltRoute.StrongCertificates` is intentionally supplied as an `.olean`
  assembly. Its private `.lean` implementation is outside the public source
  boundary. The assembly must be rebuilt against the world-indexed `Frame`
  interface before this audit can run; no replacement declarations are
  fabricated here.
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
