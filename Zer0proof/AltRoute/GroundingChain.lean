import AltRoute.Interface
namespace AltRoute.GroundingChain
open AltRoute
universe u v
variable {W : Type u} {D : Type v}

def Nec (F : Frame W) (q : W -> Prop) : Prop := forall w, F.Box q w
def Cont (F : Frame W) (p : W -> Prop) : Prop :=
  Exists fun w => F.Dia p w /\ F.Dia (fun v => Not (p v)) w

variable (F : Frame W) (G : (W -> Prop) -> (W -> Prop) -> Prop)

/-- A terminus: nothing grounds it further. -/
def Terminus (q : W -> Prop) : Prop := Not (Exists fun r => G r q)

/-- Unique instantiation at a world. -/
def UniqueAt (Omega : D -> W -> Prop) (v : W) : Prop :=
  Exists fun x : D => Omega x v /\ forall y : D, Omega y v -> y = x

/-- C1 / A1. -/
def C1 : Prop := forall p, Cont F p -> Exists fun q => Nec F q /\ G q p
/-- C3 / A3, formal content only: every chain terminates. -/
def C3 : Prop := Not (Exists fun f : Nat -> (W -> Prop) => forall n, G (f (n+1)) (f n))
/-- C3a: a contingent terminus would fall under C1 and relocate the demand. -/
def C3a : Prop := forall q, Terminus G q -> Nec F q
/-- C4: minimality / coalescence. -/
def C4 : Prop := forall q1 q2, Terminus G q1 -> Terminus G q2 -> forall w, q1 w <-> q2 w
/-- C4a: Omega IS the terminus -- identity, not naming. Stated in the object
    language; no semantic ascent. Asserts no existence: C3 supplies that. -/
structure C4a (Omega : D -> W -> Prop) : Prop where
  identity : forall w, (Exists fun x : D => Omega x w) <->
              Exists fun q => Terminus G q /\ q w
  unique  : forall w (x y : D), Omega x w -> Omega y w -> x = y
  rigid   : forall (x : D) (v v' : W), Omega x v -> Omega x v'

/-- C3 alone yields a terminus. -/
theorem some_terminus (hC3 : C3 G) : Exists fun q : W -> Prop => Terminus G q := by
  apply Classical.byContradiction
  intro hno
  have step : forall q : W -> Prop, Exists fun r => G r q := fun q =>
    Classical.byContradiction (fun hq => hno ⟨q, hq⟩)
  let f : Nat -> (W -> Prop) := fun n =>
    Nat.rec (motive := fun _ => W -> Prop) (fun _ => True)
      (fun _ ih => Classical.choose (step ih)) n
  exact hC3 ⟨f, fun n => Classical.choose_spec (step (f n))⟩

/-- C5, existence part: □∃x Ω(x). -/
theorem C5_NE (Omega : D -> W -> Prop)
    (hC3 : C3 G) (hC3a : C3a F G) (hC4a : C4a G Omega) (w : W) :
    F.Box (fun v => Exists fun x : D => Omega x v) w := by
  rcases some_terminus G hC3 with ⟨t, ht⟩
  intro v _
  exact (hC4a.identity v).mpr ⟨t, ht, F.ax_T t v (hC3a t ht v)⟩

/-- C5, full: □∃!x Ω(x). -/
theorem C5_BoxUnique (Omega : D -> W -> Prop)
    (hC3 : C3 G) (hC3a : C3a F G) (hC4a : C4a G Omega) (w : W) :
    F.Box (fun v => UniqueAt Omega v) w := by
  rcases some_terminus G hC3 with ⟨t, ht⟩
  intro v _
  have hex : Exists fun x : D => Omega x v :=
    (hC4a.identity v).mpr ⟨t, ht, F.ax_T t v (hC3a t ht v)⟩
  rcases hex with ⟨x, hx⟩
  exact ⟨x, hx, fun y hy => hC4a.unique v y x hy hx⟩

/-- Rigid witness: exists x, Box (forall y, Omega y <-> y = x). -/
theorem C5_RigidWitness (Omega : D -> W -> Prop)
    (hC3 : C3 G) (hC3a : C3a F G) (hC4a : C4a G Omega) (w : W) :
    Exists fun x : D => F.Box (fun v => forall y : D, Omega y v <-> y = x) w := by
  rcases some_terminus G hC3 with ⟨t, ht⟩
  have hNec : forall v, t v := fun v => F.ax_T t v (hC3a t ht v)
  rcases (hC4a.identity w).mpr ⟨t, ht, hNec w⟩ with ⟨x, hx⟩
  refine ⟨x, ?_⟩
  intro v _ y
  have hxv : Omega x v := hC4a.rigid x w v hx
  exact ⟨fun hy => hC4a.unique v y x hy hxv, fun hyx => hyx ▸ hxv⟩

#print axioms C5_NE
#print axioms C5_BoxUnique
#print axioms C5_RigidWitness
end AltRoute.GroundingChain
