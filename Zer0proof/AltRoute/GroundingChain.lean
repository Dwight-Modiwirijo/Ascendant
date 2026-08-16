import AltRoute.Interface

namespace AltRoute.GroundingChain
open AltRoute
universe u v
variable {W : Type u} {D : Type v}

def Cont (F : Frame W) (p : W -> Prop) : Prop :=
  Exists fun w => F.Dia p w /\ F.Dia (fun v => Not (p v)) w

variable (F : Frame W) (G : (W -> Prop) -> (W -> Prop) -> Prop)

/-- A terminus: nothing grounds it further. -/
def Terminus (q : W -> Prop) : Prop := Not (Exists fun r => G r q)

/-- Reflexive transitive closure of grounding. -/
inductive Grounds : (W -> Prop) -> (W -> Prop) -> Prop where
  | refl (p) : Grounds p p
  | step {r q p} : G r q -> Grounds q p -> Grounds r p

/-- Unique instantiation at a world. -/
def UniqueAt (Omega : D -> W -> Prop) (v : W) : Prop :=
  Exists fun x : D => Omega x v /\ forall y : D, Omega y v -> y = x

/-- C1 / A1 (HM-PSR), as Paper 3.2 states it. -/
def C1 : Prop :=
  forall p, Cont F p -> Exists fun q => (forall w, F.Box q w) /\ G q p

/-- The first conjunct of the paper's grounding relation: a ground obtains
    wherever what it grounds obtains. -/
def GroundObtains : Prop := forall q p, G q p -> forall w, p w -> q w

/-- C3 / A3: no infinite descending grounding chain. -/
def C3 : Prop :=
  Not (Exists fun f : Nat -> (W -> Prop) => forall n, G (f (n+1)) (f n))

/-- C4a: Omega IS the terminus -- identity, not naming. -/
structure C4a (Omega : D -> W -> Prop) : Prop where
  identity : forall w, (Exists fun x : D => Omega x w) <->
               Exists fun q => Terminus G q /\ q w
  unique   : forall w (x y : D), Omega x w -> Omega y w -> x = y
  rigid    : forall (x : D) (v v' : W), Omega x v -> Omega x v'

/-- Grounding transmits obtaining along the whole chain. -/
theorem grounds_obtains (hGO : GroundObtains G) {q p : W -> Prop}
    (h : Grounds G q p) (w : W) (hp : p w) : q w := by
  induction h with
  | refl _ => exact hp
  | step hG _ ih => exact hGO _ _ hG w (ih hp)

/-- C3 yields a terminus that grounds the given proposition. -/
theorem terminus_above (hC3 : C3 G) (p : W -> Prop) :
    Exists fun q => Terminus G q /\ Grounds G q p := by
  apply Classical.byContradiction
  intro hno
  have step : forall q, Grounds G q p -> Exists fun r => G r q := fun q hq =>
    Classical.byContradiction (fun hqt => hno ⟨q, hqt, hq⟩)
  let f : Nat -> { q : W -> Prop // Grounds G q p } := fun n =>
    Nat.rec (motive := fun _ => { q : W -> Prop // Grounds G q p })
      ⟨p, Grounds.refl p⟩
      (fun _ ih => ⟨Classical.choose (step ih.1 ih.2),
                    Grounds.step (Classical.choose_spec (step ih.1 ih.2)) ih.2⟩) n
  exact hC3 ⟨fun n => (f n).1, fun n => Classical.choose_spec (step (f n).1 (f n).2)⟩

/-- C3a IS A LEMMA. Paper section 3: a terminus that grounds an obtaining
    fact and fails necessity is thereby contingent, so C1 supplies it a
    ground -- and then it was no terminus. -/
theorem terminus_necessary
    (hC1 : C1 F G)
    {q : W -> Prop} (hq : Terminus G q) (w0 : W) (hqw0 : q w0) :
    F.Box q w0 := by
  apply Classical.byContradiction
  intro hnot
  have hfail : Exists fun v => F.R w0 v /\ Not (q v) :=
    Classical.byContradiction (fun hno =>
      hnot (fun v hwv => Classical.byContradiction (fun hqv => hno ⟨v, hwv, hqv⟩)))
  rcases hfail with ⟨v, hwv, hqv⟩
  have hCont : Cont F q := ⟨w0, ⟨w0, F.refl w0, hqw0⟩, ⟨v, hwv, hqv⟩⟩
  rcases hC1 q hCont with ⟨r, _, hGr⟩
  exact hq ⟨r, hGr⟩

/-- The Omega-terminus, necessary at the world where the datum obtains. -/
theorem omega_terminus
    (hC1 : C1 F G) (hGO : GroundObtains G) (hC3 : C3 G)
    (I : W -> Prop) (w0 : W) (hI : I w0) :
    Exists fun t => Terminus G t /\ t w0 /\ F.Box t w0 := by
  rcases terminus_above G hC3 I with ⟨t, ht, hgr⟩
  have htw0 : t w0 := grounds_obtains G hGO hgr w0 hI
  exact ⟨t, ht, htw0, terminus_necessary F G hC1 ht w0 htw0⟩

/-- C5, existence: Box (exists x, Omega x) at the datum world. -/
theorem C5_NE (Omega : D -> W -> Prop)
    (hC1 : C1 F G) (hGO : GroundObtains G) (hC3 : C3 G) (hC4a : C4a G Omega)
    (I : W -> Prop) (w0 : W) (hI : I w0) :
    F.Box (fun v => Exists fun x : D => Omega x v) w0 := by
  rcases omega_terminus F G hC1 hGO hC3 I w0 hI with ⟨t, ht, _, hBox⟩
  intro v hwv
  exact (hC4a.identity v).mpr ⟨t, ht, hBox v hwv⟩

/-- C5, uniqueness: Box (exists! x, Omega x). -/
theorem C5_BoxUnique (Omega : D -> W -> Prop)
    (hC1 : C1 F G) (hGO : GroundObtains G) (hC3 : C3 G) (hC4a : C4a G Omega)
    (I : W -> Prop) (w0 : W) (hI : I w0) :
    F.Box (fun v => UniqueAt Omega v) w0 := by
  rcases omega_terminus F G hC1 hGO hC3 I w0 hI with ⟨t, ht, _, hBox⟩
  intro v hwv
  rcases (hC4a.identity v).mpr ⟨t, ht, hBox v hwv⟩ with ⟨x, hx⟩
  exact ⟨x, hx, fun y hy => hC4a.unique v y x hy hx⟩

/-- C5, rigid designation. -/
theorem C5_RigidWitness (Omega : D -> W -> Prop)
    (hC1 : C1 F G) (hGO : GroundObtains G) (hC3 : C3 G) (hC4a : C4a G Omega)
    (I : W -> Prop) (w0 : W) (hI : I w0) :
    Exists fun x : D => F.Box (fun v => forall y : D, Omega y v <-> y = x) w0 := by
  rcases omega_terminus F G hC1 hGO hC3 I w0 hI with ⟨t, ht, htw0, hBox⟩
  rcases (hC4a.identity w0).mpr ⟨t, ht, htw0⟩ with ⟨x, hx⟩
  refine ⟨x, ?_⟩
  intro v _ y
  have hxv : Omega x v := hC4a.rigid x w0 v hx
  exact ⟨fun hy => hC4a.unique v y x hy hxv, fun hyx => hyx ▸ hxv⟩

#print axioms terminus_necessary
#print axioms C5_NE
#print axioms C5_BoxUnique
#print axioms C5_RigidWitness
end AltRoute.GroundingChain
