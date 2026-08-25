import AscendantRoute.Release.Successor.SuccessorAPI

set_option autoImplicit false

namespace AscendantRoute.Release.Successor

/-- Countdown on Nat is an inhabited model of the public successor contract. -/
def NatMachine : Machine where
  State := Nat
  S := fun n => n - 1
  meas := fun n => n
  dec := fun _ h => Nat.sub_lt h Nat.one_pos
  terminal := fun _ h => by
    cases h
    rfl
  zeroUnique := fun _ _ hx hy => hx.trans hy.symm

/-- A named non-terminal start state makes inhabitation explicit to the audit. -/
def natStart : NatMachine.State := (42 : Nat)

theorem natMachine_terminates (b0 : NatMachine.State) :
    Exists fun N => NatMachine.meas (iterate NatMachine N b0) = 0 :=
  terminates NatMachine b0

theorem natMachine_coverage (b : NatMachine.State)
    (h : 0 < NatMachine.meas b) :
    NatMachine.meas (NatMachine.S b) < NatMachine.meas b :=
  coverage NatMachine b h

theorem natMachine_omega_iff (b : NatMachine.State) :
    NatMachine.meas b = 0 <-> Omega NatMachine b :=
  omega_iff NatMachine b

theorem natMachine_omega_fixed (b : NatMachine.State)
    (h : Omega NatMachine b) : NatMachine.S b = b :=
  omega_fixed NatMachine b h

theorem natMachine_existsUniqueOmegaReached (b0 : NatMachine.State) :
    Exists fun N =>
      Omega NatMachine (iterate NatMachine N b0) /\
        ((y : NatMachine.State) ->
          Omega NatMachine y -> y = iterate NatMachine N b0) :=
  existsUniqueOmegaReached NatMachine b0

theorem natMachine_existsUniqueOmega (b0 : NatMachine.State) :
    Exists fun x =>
      Omega NatMachine x /\
        ((y : NatMachine.State) -> Omega NatMachine y -> y = x) :=
  existsUniqueOmega NatMachine b0

end AscendantRoute.Release.Successor
