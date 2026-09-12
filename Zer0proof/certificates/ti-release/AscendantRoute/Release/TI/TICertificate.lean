import AscendantRoute.Release.TI.TIModel

set_option autoImplicit false

namespace AscendantRoute.Release.TI

#check Contract
#check Contract.State
#check Contract.advance
#check Contract.rank
#check Contract.IsTerminus
#check Contract.descends
#check Contract.terminus_iff_zero
#check Contract.terminus_unique
#check Contract.terminus_fixed
#check iterate
#check iterate_zero
#check iterate_succ
#check iterate_succ_arg
#check converges
#check terminus_characterization
#check isTerminus_fixed
#check existsUniqueTerminus

#print axioms Contract
#print axioms Contract.State
#print axioms Contract.advance
#print axioms Contract.rank
#print axioms Contract.IsTerminus
#print axioms Contract.descends
#print axioms Contract.terminus_iff_zero
#print axioms Contract.terminus_unique
#print axioms Contract.terminus_fixed
#print axioms iterate
#print axioms iterate_zero
#print axioms iterate_succ
#print axioms iterate_succ_arg
#print axioms converges
#print axioms terminus_characterization
#print axioms isTerminus_fixed
#print axioms existsUniqueTerminus

#check NatContract
#check natOrigin
#check natContract_converges
#check natContract_terminus_characterization
#check natContract_terminus_fixed
#check natContract_existsUniqueTerminus

#print axioms NatContract
#print axioms natOrigin
#print axioms natContract_converges
#print axioms natContract_terminus_characterization
#print axioms natContract_terminus_fixed
#print axioms natContract_existsUniqueTerminus

end AscendantRoute.Release.TI
