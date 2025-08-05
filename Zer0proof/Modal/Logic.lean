namespace Modal.Logic

inductive Formula where
  | Var     : String → Formula
  | Not     : Formula → Formula
  | Box     : Formula → Formula
  | Diamond : Formula → Formula
  | And     : Formula → Formula → Formula
  | Or      : Formula → Formula → Formula
  | Implies : Formula → Formula → Formula
  | Iff     : Formula → Formula → Formula
deriving Repr, BEq

open Formula

def ModalValid (R : α → α → Prop) (Val : α → String → Prop) (w : α) : Formula → Prop
  | Formula.Var p         => Val w p
  | Formula.Not f         => ¬ ModalValid R Val w f
  | Formula.Box f         => ∀v, R w v → ModalValid R Val v f
  | Formula.Diamond f     => ∃v, R w v ∧ ModalValid R Val v f
  | Formula.And f1 f2     => ModalValid R Val w f1 ∧ ModalValid R Val w f2
  | Formula.Or f1 f2      => ModalValid R Val w f1 ∨ ModalValid R Val w f2
  | Formula.Implies f1 f2 => ModalValid R Val w f1 → ModalValid R Val w f2
  | Formula.Iff f1 f2     => ModalValid R Val w f1 ↔ ModalValid R Val w f2

end Modal.Logic
