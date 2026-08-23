import HyperModal

namespace HyperModal.NegativeTests

open AscendantRoute

universe u

theorem nec_grounded_in_anything {W : Type u} (F : Frame W)
    (G : GroundRel W) (p q : W -> Prop) (_hNec : Nec F p) : G q p := by
  constructor

end HyperModal.NegativeTests
