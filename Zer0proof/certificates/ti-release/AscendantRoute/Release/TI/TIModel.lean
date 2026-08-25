import AscendantRoute.Release.TI.TIAPI

set_option autoImplicit false

namespace AscendantRoute.Release.TI

/-- Countdown on Nat is an inhabited model of the public TI contract. -/
def NatContract : Contract where
  State := Nat
  advance := fun n => n - 1
  rank := fun n => n
  IsTop := fun n => n = 0
  descends := fun _ h => Nat.sub_lt h Nat.one_pos
  top_iff_zero := fun _ => Iff.rfl
  top_unique := fun _ _ hx hy => hx.trans hy.symm
  top_fixed := fun _ h => by
    cases h
    rfl

/-- A named non-top start state makes inhabitation and progress explicit. -/
def natOrigin : NatContract.State := (42 : Nat)

theorem natContract_converges (start : NatContract.State) :
    Exists fun n => NatContract.IsTop (iterate NatContract n start) :=
  converges NatContract start

theorem natContract_top_characterization (x : NatContract.State) :
    NatContract.IsTop x <-> NatContract.rank x = 0 :=
  top_characterization NatContract x

theorem natContract_top_fixed (x : NatContract.State)
    (h : NatContract.IsTop x) : NatContract.advance x = x :=
  isTop_fixed NatContract x h

theorem natContract_existsUniqueTop (start : NatContract.State) :
    Exists fun x =>
      NatContract.IsTop x /\
        ((y : NatContract.State) -> NatContract.IsTop y -> y = x) :=
  existsUniqueTop NatContract start

end AscendantRoute.Release.TI
