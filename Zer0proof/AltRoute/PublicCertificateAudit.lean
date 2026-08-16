/-
  Public-surface correspondence check.

  The purpose is a mechanical reflection of the paper's scoped certificate:
  - the exported compatibility layer uses □◇-shaped statements
  - guard artifacts remain available (explosion canary, model witness)
  - axiom footprints remain inspectable for exported constants
-/

import AltRoute.PublicTests

namespace AltRoute.PublicCertificateAudit

open AltRoute

/-
  Exported public claims.
  The signatures match the intended □◇ admissibility layer.
-/
#check AltRoute.SomePosNecPossible
#check AltRoute.necPossible_of_Pos
#check AltRoute.somePosNecPossible_of_exists
#check AltRoute.false_not_positive
#check AltRoute.empty_extension_not_positive
#check AltRoute.exists_of_positive
#check AltRoute.PosPossibility
#check AltRoute.Modal.actual_possible

/-
  Guard artifacts.
  The presence of these declarations matches the public safety-certificate narrative.
-/
#check AltRoute.PublicTests.TrivialModel
#check AltRoute.PublicTests.exFalsoQuodlibet
#check AltRoute.PublicTests.UnitPositive
#check AltRoute.PublicTests.unit_positive_possible
#check AltRoute.PublicTests.no_positive_on_empty
#check AltRoute.PublicTests.dia_not_constantly_false
#check AltRoute.PublicTests.no_inflated_dia

/-
  Axiom-footprint inspection for exported constants.
  The output provides the dependency boundary for the public layer.
-/
#print axioms AltRoute.necPossible_of_Pos
#print axioms AltRoute.somePosNecPossible_of_exists
#print axioms AltRoute.PublicTests.TrivialModel

#print AltRoute.PosPossibility
#print AltRoute.necPossible_of_Pos
#print axioms AltRoute.Modal.actual_possible
#print axioms AltRoute.false_not_positive
#print axioms AltRoute.empty_extension_not_positive
#print axioms AltRoute.exists_of_positive
#print axioms AltRoute.PosPossibility
#print axioms AltRoute.PublicTests.UnitPositive
#print axioms AltRoute.PublicTests.unit_positive_possible
#print axioms AltRoute.PublicTests.no_positive_on_empty
#print axioms AltRoute.PublicTests.dia_not_constantly_false
#print axioms AltRoute.PublicTests.no_inflated_dia

end AltRoute.PublicCertificateAudit
