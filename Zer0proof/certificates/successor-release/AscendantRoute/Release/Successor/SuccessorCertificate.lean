import AscendantRoute.Release.Successor.SuccessorModel

set_option autoImplicit false

namespace AscendantRoute.Release.Successor

#check Machine
#check Machine.State
#check Machine.S
#check Machine.meas
#check Machine.dec
#check Machine.terminal
#check Machine.zeroUnique
#check iterate
#check terminates
#check coverage
#check Omega
#check omega_iff
#check omega_fixed
#check existsUniqueOmegaReached
#check existsUniqueOmega

#print axioms Machine
#print axioms Machine.State
#print axioms Machine.S
#print axioms Machine.meas
#print axioms Machine.dec
#print axioms Machine.terminal
#print axioms Machine.zeroUnique
#print axioms iterate
#print axioms terminates
#print axioms coverage
#print axioms Omega
#print axioms omega_iff
#print axioms omega_fixed
#print axioms existsUniqueOmegaReached
#print axioms existsUniqueOmega

#check NatMachine
#check NatMachine.S
#check NatMachine.meas
#check NatMachine.dec
#check NatMachine.terminal
#check NatMachine.zeroUnique
#check natStart
#check natMachine_terminates
#check natMachine_coverage
#check natMachine_omega_iff
#check natMachine_omega_fixed
#check natMachine_existsUniqueOmegaReached
#check natMachine_existsUniqueOmega

#print axioms NatMachine
#print axioms natStart
#print axioms natMachine_terminates
#print axioms natMachine_coverage
#print axioms natMachine_omega_iff
#print axioms natMachine_omega_fixed
#print axioms natMachine_existsUniqueOmegaReached
#print axioms natMachine_existsUniqueOmega

end AscendantRoute.Release.Successor
