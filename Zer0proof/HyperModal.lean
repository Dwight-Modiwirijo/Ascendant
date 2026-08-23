import AscendantRoute.Interface

/-!
The HyperModal compatibility layer uses the public S5 Frame semantics and a
primitive grounding relation G. All substantive assumptions are explicit
fields of HyperModalSetting. There are no global axioms in this module.

Core-relative positivity uses the formally represented A1/A3 core only. A5
closure and ICO preservation are not formalized here; a full triad-relative
positivity theorem therefore remains future work.
-/

universe u

namespace HyperModal

open AscendantRoute

abbrev GroundRel (W : Type u) := (W -> Prop) -> (W -> Prop) -> Prop

variable {W : Type u}

/-! Modal vocabulary over the shared public S5 frame. -/

def reflexiveR (F : Frame W) : Prop := forall w : W, F.R w w

def symmetricR (F : Frame W) : Prop :=
  forall w v : W, F.R w v -> F.R v w

def transitiveR (F : Frame W) : Prop :=
  forall w v x : W, F.R w v -> F.R v x -> F.R w x

def equivalenceR (F : Frame W) : Prop :=
  reflexiveR F /\ symmetricR F /\ transitiveR F

def necessarily (F : Frame W) (w : W) (phi : W -> Prop) : Prop :=
  F.Box phi w

def possibly (F : Frame W) (w : W) (phi : W -> Prop) : Prop :=
  F.Dia phi w

def contingent (F : Frame W) (phi : W -> Prop) : Prop :=
  Exists fun w : W =>
    possibly F w phi /\ possibly F w (fun v => Not (phi v))

def Nec (F : Frame W) (p : W -> Prop) : Prop :=
  forall w : W, F.Box p w

/-!
Grounding is primitive. G q p reads: q grounds p. This is the same argument
order as AscendantRoute.GroundingChain and does not identify grounding with
material implication.
-/

def GroundIrreflexive (G : GroundRel W) : Prop :=
  forall p : W -> Prop, Not (G p p)

def AntiRegress (G : GroundRel W) : Prop :=
  Not (Exists fun f : Nat -> (W -> Prop) =>
    forall n : Nat, G (f (n + 1)) (f n))

def HyperMinimalPSR (F : Frame W) (G : GroundRel W)
    (Omega : W -> Prop) : Prop :=
  forall p : W -> Prop, contingent F p ->
    Exists fun w : W =>
      F.Dia (fun _ : W =>
        Exists fun q : W -> Prop =>
          G q p /\
            (Nec F q \/ F.Dia (fun _ : W => G Omega q) w)) w

def NoNecessaryGroundedInContingent (F : Frame W)
    (G : GroundRel W) : Prop :=
  forall p q : W -> Prop,
    Nec F p -> contingent F q -> Not (G q p)

/-!
T_core is world-constant because its A1/A3 components are frame-global.
Accordingly, boxing T_core adds no modal strength. A5 closure is deliberately
absent: calling this a full triad before A5 is formalized would overstate the
kernel result.
-/

def T_core (F : Frame W) (G : GroundRel W)
    (Omega : W -> Prop) : W -> Prop :=
  fun _ =>
    HyperMinimalPSR F G Omega /\
      GroundIrreflexive G /\ AntiRegress G

def AtOmega (Omega P : W -> Prop) : W -> Prop :=
  fun v => Omega v -> P v

/-- Preservation-relative positivity: denying phi defeats Pres. -/
def PosT (F : Frame W) (Pres phi : W -> Prop) (w0 : W) : Prop :=
  F.Box (fun v => Not (phi v) -> Not (Pres v)) w0

/-- Core-relative positivity for the A1/A3 core represented by T_core. -/
def Pos_T (F : Frame W) (G : GroundRel W)
    (Omega P : W -> Prop) (w0 : W) : Prop :=
  PosT F (T_core F G Omega) (AtOmega Omega P) w0

theorem posT_box (F : Frame W) (Pres phi : W -> Prop) (w0 : W)
    (hPres : F.Box Pres w0) (hPos : PosT F Pres phi w0) :
    F.Box phi w0 := by
  intro v hwv
  exact Classical.byContradiction (fun hPhi =>
    (hPos v hwv hPhi) (hPres v hwv))

theorem posT_iff_box (F : Frame W) (Pres phi : W -> Prop) (w0 : W)
    (hPres : F.Box Pres w0) :
    PosT F Pres phi w0 <-> F.Box phi w0 := by
  constructor
  · exact posT_box F Pres phi w0 hPres
  · intro hPhi v hwv hNotPhi _
    exact hNotPhi (hPhi v hwv)

/-- A4 follows from the fixed logical-semantic background alone. -/
theorem logic_necessity (F : Frame W) :
    forall (A : W -> Prop) (w : W),
      necessarily F w (fun v => (A v /\ Not (A v)) -> False) := by
  intro A w v _
  rintro ⟨hA, hNotA⟩
  exact hNotA hA

/--
Double-boxed non-contradiction. This is not a formalization of the paper's
philosophical A5 closure principle.
-/
theorem meta_logic (F : Frame W) :
    forall (A : W -> Prop) (w : W),
      necessarily F w (fun v =>
        necessarily F v (fun x => (A x /\ Not (A x)) -> False)) := by
  intro A w v _ x _
  rintro ⟨hA, hNotA⟩
  exact hNotA hA

structure HyperModalSetting (W : Type u) (F : Frame W)
    (G : GroundRel W) (Omega I_am Logic Material : W -> Prop)
    (w0 : W) : Prop where
  psr : HyperMinimalPSR F G Omega
  g_strict : GroundIrreflexive G
  anti_regress : AntiRegress G
  consciousness : G Omega I_am
  logic_nec : Nec F Logic
  material_cont : contingent F Material
  no_nec_in_cont : NoNecessaryGroundedInContingent F G
  datum_at_w0 : I_am w0

variable {F : Frame W} {G : GroundRel W}
variable {Omega I_am Logic Material : W -> Prop} {w0 : W}

theorem triad_holds
    (S : HyperModalSetting W F G Omega I_am Logic Material w0) :
    forall v : W, T_core F G Omega v := by
  intro _
  exact ⟨S.psr, S.g_strict, S.anti_regress⟩

theorem posT_box_core (F : Frame W) (G : GroundRel W)
    (Omega P : W -> Prop) (w0 : W)
    (hT : forall v : W, T_core F G Omega v)
    (hPos : Pos_T F G Omega P w0) :
    F.Box (AtOmega Omega P) w0 := by
  apply posT_box F (T_core F G Omega) (AtOmega Omega P) w0
  · intro v _
    exact hT v
  · exact hPos

theorem posT_box_core_of_setting
    (S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (P : W -> Prop) (hPos : Pos_T F G Omega P w0) :
    F.Box (AtOmega Omega P) w0 :=
  posT_box_core F G Omega P w0 (triad_holds S) hPos

theorem posT_not_both (F : Frame W) (G : GroundRel W)
    (Omega P : W -> Prop) (w0 : W)
    (hT : forall v : W, T_core F G Omega v)
    (hOmega : F.Dia Omega w0)
    (hPos : Pos_T F G Omega P w0)
    (hNegPos : Pos_T F G Omega (fun v => Not (P v)) w0) : False := by
  have hP := posT_box_core F G Omega P w0 hT hPos
  have hNotP :=
    posT_box_core F G Omega (fun v => Not (P v)) w0 hT hNegPos
  rcases hOmega with ⟨v, hwv, hOmegaV⟩
  exact (hNotP v hwv hOmegaV) (hP v hwv hOmegaV)

/-! Setting-relative consequences and regression lemmas. -/

theorem consciousness_grounded
    (S : HyperModalSetting W F G Omega I_am Logic Material w0) :
    forall w : W, F.Box (fun _ : W => G Omega I_am) w := by
  intro w v _
  exact S.consciousness

theorem anti_material_grounding
    (S : HyperModalSetting W F G Omega I_am Logic Material w0) :
    Not (G Material Logic) :=
  S.no_nec_in_cont Logic Material S.logic_nec S.material_cont

theorem reductio
    (S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (hNeg : Not (forall w : W,
      F.Box (fun _ : W => G Omega I_am) w)) : False :=
  hNeg (consciousness_grounded S)

theorem materialist_reductio
    (S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (hMaterialGroundsLogic : G Material Logic) : False :=
  anti_material_grounding S hMaterialGroundsLogic

theorem hyper_minimal_PSR_reductio
    (S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (p : W -> Prop) (hCont : contingent F p)
    (hNeg : Not (Exists fun w : W =>
      F.Dia (fun _ : W =>
        Exists fun q : W -> Prop =>
          G q p /\
            (Nec F q \/ F.Dia (fun _ : W => G Omega q) w)) w)) : False :=
  hNeg (S.psr p hCont)

theorem anti_regress_reductio
    (S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (hChain : Exists fun f : Nat -> (W -> Prop) =>
      forall n : Nat, G (f (n + 1)) (f n)) : False :=
  S.anti_regress hChain

theorem logic_necessity_reductio
    (_S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (A : W -> Prop) (w : W)
    (hNeg : Not (necessarily F w
      (fun v => (A v /\ Not (A v)) -> False))) : False :=
  hNeg (logic_necessity F A w)

theorem meta_logic_reductio
    (_S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (A : W -> Prop) (w : W)
    (hNeg : Not (necessarily F w (fun v =>
      necessarily F v (fun x => (A x /\ Not (A x)) -> False)))) : False :=
  hNeg (meta_logic F A w)

theorem consciousness_reductio
    (S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (hNeg : Not (G Omega I_am)) : False :=
  hNeg S.consciousness

theorem logic_is_necessary_reductio
    (S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (w : W) (hNeg : Not (F.Box Logic w)) : False :=
  hNeg (S.logic_nec w)

theorem material_is_contingent_reductio
    (S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (hNeg : Not (contingent F Material)) : False :=
  hNeg S.material_cont

theorem no_necessary_grounded_in_contingent_reductio
    (S : HyperModalSetting W F G Omega I_am Logic Material w0)
    (p q : W -> Prop) (hNec : Nec F p)
    (hCont : contingent F q) (hGround : G q p) : False :=
  S.no_nec_in_cont p q hNec hCont hGround

/-!
Historical refutation records. LegacyGround exists only to state the removed
extensional formulas as hypotheses; it is not the active grounding relation.
-/

namespace Historical

def LegacyGround (F : Frame W) (p q : W -> Prop) : Prop :=
  (forall w : W, q w -> p w) /\
    (forall w : W, q w ->
      F.Box (fun v => q v -> p v) w)

theorem legacy_ground_reflexive (F : Frame W) (p : W -> Prop) :
    LegacyGround F p p := by
  constructor
  · intro _ hp
    exact hp
  · intro _ _ _ _ hp
    exact hp

theorem perfect_positivity_refutation (F : Frame W)
    (Omega : W -> Prop)
    (hOld : Not (Exists fun q : W -> Prop =>
      forall w : W, F.Box (fun v => q v -> Not (Omega v)) w)) : False := by
  apply hOld
  refine ⟨fun v => Not (Omega v), ?_⟩
  intro w v _ hNotOmega
  exact hNotOmega

def unitFrame : Frame Unit where
  R := fun _ _ => True
  refl := by intro _; trivial
  trans := by intro _ _ _ _ _; trivial
  symm := by intro _ _ _; trivial

theorem consciousness_axiom_refutation
    (hOld : forall (F : Frame Unit) (Omega I_am : Unit -> Prop),
      LegacyGround F I_am Omega) : False := by
  have hHostile :=
    hOld unitFrame (fun _ => True) (fun _ => False)
  exact hHostile.1 () True.intro

theorem anti_regress_refutation (F : Frame W)
    (hOld : Not (Exists fun f : Nat -> (W -> Prop) =>
      forall n : Nat, LegacyGround F (f (n + 1)) (f n))) : False := by
  apply hOld
  exact ⟨fun _ => fun _ => True,
    fun _ => legacy_ground_reflexive F (fun _ => True)⟩

theorem necessary_legacy_grounds_anything (F : Frame W)
    (p q : W -> Prop) (hNec : Nec F p) :
    LegacyGround F p q := by
  constructor
  · intro w _
    exact hNec w w (F.refl w)
  · intro _ _ v _ _
    exact hNec v v (F.refl v)

theorem logic_material_trio_refutation (F : Frame W)
    (Logic Material : W -> Prop)
    (hLogic : Nec F Logic)
    (hMaterial : contingent F Material)
    (hNoNecInCont : forall p q : W -> Prop,
      Nec F p -> contingent F q ->
        Not (LegacyGround F p q)) : False :=
  hNoNecInCont Logic Material hLogic hMaterial
    (necessary_legacy_grounds_anything F Logic Material hLogic)

end Historical

/-! A concrete non-collapsed, jointly inhabited HyperModal setting. -/

namespace Model

abbrev World := Bool

def frame : Frame World where
  R := fun _ _ => True
  refl := by intro _; trivial
  trans := by intro _ _ _ _ _; trivial
  symm := by intro _ _ _; trivial

def omega : World -> Prop := fun _ => True
def datum : World -> Prop := fun w => w = true
def logic : World -> Prop := fun _ => True
def material : World -> Prop := datum

def rel : GroundRel World :=
  fun q p => Nec frame q /\ contingent frame p

theorem nec_not_contingent {p : World -> Prop}
    (hNec : Nec frame p) : Not (contingent frame p) := by
  rintro ⟨w, _, ⟨v, hwv, hNotP⟩⟩
  exact hNotP (hNec w v hwv)

theorem material_contingent : contingent frame material := by
  refine ⟨true, ?_, ?_⟩
  · exact ⟨true, True.intro, rfl⟩
  · refine ⟨false, True.intro, ?_⟩
    change Not (false = true)
    intro h
    cases h

theorem omega_necessary : Nec frame omega := by
  intro _ _ _
  trivial

theorem logic_necessary : Nec frame logic := by
  intro _ _ _
  trivial

theorem g_strict : GroundIrreflexive rel := by
  intro p hp
  exact nec_not_contingent hp.1 hp.2

theorem anti_regress : AntiRegress rel := by
  rintro ⟨f, hChain⟩
  have hNec : Nec frame (f 1) := by
    simpa using (hChain 0).1
  have hCont : contingent frame (f 1) := by
    simpa using (hChain 1).2
  exact nec_not_contingent hNec hCont

theorem psr : HyperMinimalPSR frame rel omega := by
  intro p hCont
  rcases hCont with ⟨w, hPossible, hPossibleNot⟩
  refine ⟨w, ⟨w, frame.refl w, ?_⟩⟩
  refine ⟨omega, ?_, Or.inl omega_necessary⟩
  exact ⟨omega_necessary, ⟨w, hPossible, hPossibleNot⟩⟩

theorem consciousness : rel omega datum :=
  ⟨omega_necessary, material_contingent⟩

theorem no_nec_in_cont :
    NoNecessaryGroundedInContingent frame rel := by
  intro p q _ hCont hGround
  exact nec_not_contingent hGround.1 hCont

theorem setting_inhabited :
    HyperModalSetting World frame rel omega datum logic material true where
  psr := psr
  g_strict := g_strict
  anti_regress := anti_regress
  consciousness := consciousness
  logic_nec := logic_necessary
  material_cont := material_contingent
  no_nec_in_cont := no_nec_in_cont
  datum_at_w0 := rfl

theorem omega_possible : frame.Dia omega true :=
  ⟨true, True.intro, True.intro⟩

theorem grounding_nonempty :
    Exists fun qp : (World -> Prop) × (World -> Prop) =>
      rel qp.1 qp.2 :=
  ⟨(omega, datum), consciousness⟩

theorem frame_not_collapsed :
    Not (forall (phi : World -> Prop) (w : World),
      frame.Box phi w <-> phi w) := by
  intro hCollapse
  have hBox : frame.Box material true :=
    (hCollapse material true).mpr rfl
  have hFalse : material false := hBox false True.intro
  change false = true at hFalse
  cases hFalse

theorem material_datum : material true := rfl

theorem material_not_necessary :
    Not (Nec frame material) := by
  intro hNec
  exact nec_not_contingent hNec material_contingent

theorem no_material_grounding_logic : Not (rel material logic) :=
  setting_inhabited.no_nec_in_cont logic material
    setting_inhabited.logic_nec setting_inhabited.material_cont

end Model

/-! Permanent public footprint audit. -/

#print axioms HyperModal.logic_necessity
#print axioms HyperModal.meta_logic
#print axioms HyperModal.posT_box
#print axioms HyperModal.posT_iff_box
#print axioms HyperModal.triad_holds
#print axioms HyperModal.posT_box_core
#print axioms HyperModal.posT_box_core_of_setting
#print axioms HyperModal.posT_not_both
#print axioms HyperModal.consciousness_grounded
#print axioms HyperModal.anti_material_grounding
#print axioms HyperModal.Historical.perfect_positivity_refutation
#print axioms HyperModal.Historical.consciousness_axiom_refutation
#print axioms HyperModal.Historical.anti_regress_refutation
#print axioms HyperModal.Historical.logic_material_trio_refutation
#print axioms HyperModal.Model.setting_inhabited
#print axioms HyperModal.Model.omega_possible
#print axioms HyperModal.Model.grounding_nonempty
#print axioms HyperModal.Model.frame_not_collapsed
#print axioms HyperModal.Model.material_contingent
#print axioms HyperModal.Model.logic_necessary
#print axioms HyperModal.Model.no_material_grounding_logic

end HyperModal
