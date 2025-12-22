/-
  Public-surface correspondence check.

  The purpose is a mechanical reflection of the paper's scoped certificate:
  - the exported compatibility layer uses □◇-shaped statements
  - guard artifacts remain available (explosion canary, model witness)
  - axiom footprints remain inspectable for exported constants
-/

import AltRoute.PublicTests

namespace AltRoute.CertificateAudit

open AltRoute

/-
  Exported public claims.
  The signatures match the intended □◇ admissibility layer.
-/
#check AltRoute.SomePosNecPossible
#check AltRoute.necPossible_of_Pos
#check AltRoute.somePosNecPossible_of_exists

/-
  Guard artifacts.
  The presence of these declarations matches the public safety-certificate narrative.
-/
#check AltRoute.PublicTests.TrivialModel
#check AltRoute.PublicTests.AltRoute.exFalsoQuodlibet

/-
  Axiom-footprint inspection for exported constants.
  The output provides the dependency boundary for the public layer.
-/
#print axioms AltRoute.necPossible_of_Pos
#print axioms AltRoute.somePosNecPossible_of_exists
#print axioms AltRoute.PublicTests.TrivialModel

end AltRoute.CertificateAudit
