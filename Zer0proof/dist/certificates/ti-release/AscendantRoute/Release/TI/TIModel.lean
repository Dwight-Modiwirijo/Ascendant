import AscendantRoute.Release.TI.TIAPI

set_option autoImplicit false

namespace AscendantRoute.Release.TI

/-- Countdown on Nat is an inhabited model of the public TI contract. -/
def NatContract : Contract where
  State := Nat
  advance := fun n => n - 1
  rank := fun n => n
  IsTerminus := fun n => n = 0
  descends := fun _ h => Nat.sub_lt h Nat.one_pos
  terminus_iff_zero := fun _ => Iff.rfl
  terminus_unique := fun _ _ hx hy => hx.trans hy.symm
  terminus_fixed := fun _ h => by
    cases h
    rfl

/-- A named nonterminal start state makes inhabitation and progress explicit. -/
def natOrigin : NatContract.State := (42 : Nat)

theorem natContract_converges (start : NatContract.State) :
    Exists fun n => NatContract.IsTerminus (iterate NatContract n start) :=
  converges NatContract start

theorem natContract_terminus_characterization (x : NatContract.State) :
    NatContract.IsTerminus x <-> NatContract.rank x = 0 :=
  terminus_characterization NatContract x

theorem natContract_terminus_fixed (x : NatContract.State)
    (h : NatContract.IsTerminus x) : NatContract.advance x = x :=
  isTerminus_fixed NatContract x h

theorem natContract_existsUniqueTerminus (start : NatContract.State) :
    Exists fun x =>
      NatContract.IsTerminus x /\
        ((y : NatContract.State) -> NatContract.IsTerminus y -> y = x) :=
  existsUniqueTerminus NatContract start

end AscendantRoute.Release.TI
