import AscendantRoute.Release.TI.TIModel

set_option autoImplicit false

namespace AscendantRoute.Release.TI

#check Contract
#check Contract.State
#check Contract.advance
#check Contract.rank
#check Contract.IsTop
#check Contract.descends
#check Contract.top_iff_zero
#check Contract.top_unique
#check Contract.top_fixed
#check iterate
#check iterate_zero
#check iterate_succ
#check iterate_succ_arg
#check converges
#check top_characterization
#check isTop_fixed
#check existsUniqueTop

#print axioms Contract
#print axioms Contract.State
#print axioms Contract.advance
#print axioms Contract.rank
#print axioms Contract.IsTop
#print axioms Contract.descends
#print axioms Contract.top_iff_zero
#print axioms Contract.top_unique
#print axioms Contract.top_fixed
#print axioms iterate
#print axioms iterate_zero
#print axioms iterate_succ
#print axioms iterate_succ_arg
#print axioms converges
#print axioms top_characterization
#print axioms isTop_fixed
#print axioms existsUniqueTop

#check NatContract
#check natOrigin
#check natContract_converges
#check natContract_top_characterization
#check natContract_top_fixed
#check natContract_existsUniqueTop

#print axioms NatContract
#print axioms natOrigin
#print axioms natContract_converges
#print axioms natContract_top_characterization
#print axioms natContract_top_fixed
#print axioms natContract_existsUniqueTop

end AscendantRoute.Release.TI
