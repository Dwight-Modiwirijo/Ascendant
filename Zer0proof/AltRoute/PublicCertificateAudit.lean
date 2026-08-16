/-
  Public-surface correspondence check for the world-indexed certificate API.
  All modal claims below quantify over arbitrary frames and selected worlds.
-/

import AltRoute.PublicTests

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

end AltRoute.PublicCertificateAudit
