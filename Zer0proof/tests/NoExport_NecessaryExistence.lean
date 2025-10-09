-- NoExport_NecessaryExistence.lean
import AltRoute.Interface

-- This file MUST NOT compile: the symbol must not exist publicly.
#check AltRoute.NecessaryExistence

-- This must NOT compile from the public surface:
-- (There is no public re-export of AltRoute.Private.)
#check AltRoute.Private.necessaryExistence_Omega

#print axioms AltRoute.Core.necPossible_of_Pos
#print axioms AltRoute.Core.somePosNecPossible_of_exists
