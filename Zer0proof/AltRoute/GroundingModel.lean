import AltRoute.Interface
namespace AltRoute.GroundingModel
open AltRoute

def F : Frame Bool :=
{ R := fun _ _ => True, refl := fun _ => trivial,
  trans := fun _ _ _ _ _ => trivial, symm := fun _ _ _ => trivial }

def Nec (q : Bool -> Prop) : Prop := forall w, F.Box q w
def Cont (p : Bool -> Prop) : Prop :=
  Exists fun w => F.Dia p w /\ F.Dia (fun v => Not (p v)) w
def G (q p : Bool -> Prop) : Prop := (forall w, q w) /\ Not (forall w, p w)
def Terminus (q : Bool -> Prop) : Prop := Not (Exists fun r => G r q)
def Omega : Unit -> Bool -> Prop := fun _ _ => True

theorem terminus_iff (q : Bool -> Prop) : Terminus q <-> forall w, q w := by
  constructor
  · intro h
    exact Classical.byContradiction (fun hn => h ⟨fun _ => True, ⟨fun _ => trivial, hn⟩⟩)
  · rintro hall ⟨r, _, hnot⟩; exact hnot hall

theorem m_C1 : forall p, Cont p -> Exists fun q => Nec q /\ G q p := by
  rintro p ⟨w, _, ⟨v, _, hnp⟩⟩
  exact ⟨fun _ => True, fun _ _ _ => trivial, ⟨fun _ => trivial, fun h => hnp (h v)⟩⟩

theorem m_C2 : Cont (fun b => b = true) :=
  ⟨true, ⟨true, trivial, rfl⟩, ⟨false, trivial, by intro h; exact Bool.noConfusion h⟩⟩

theorem m_C3 : Not (Exists fun f : Nat -> (Bool -> Prop) => forall n, G (f (n+1)) (f n)) := by
  rintro ⟨f, hf⟩; exact (hf 1).2 (hf 0).1

theorem m_C3a : forall q, Terminus q -> Nec q := by
  intro q h w v _; exact (terminus_iff q).mp h v

theorem m_C4 : forall q1 q2, Terminus q1 -> Terminus q2 -> forall w, q1 w <-> q2 w := by
  intro q1 q2 h1 h2 w
  exact ⟨fun _ => (terminus_iff q2).mp h2 w, fun _ => (terminus_iff q1).mp h1 w⟩

theorem m_C4a_identity : forall w, (Exists fun x : Unit => Omega x w) <->
    Exists fun q => Terminus q /\ q w :=
  fun w => ⟨fun _ => ⟨fun _ => True, (terminus_iff _).mpr (fun _ => trivial), trivial⟩,
            fun _ => ⟨(), trivial⟩⟩

theorem m_C4a_unique : forall w (x y : Unit), Omega x w -> Omega y w -> x = y := by
  intro _ x y _ _; cases x; cases y; rfl

theorem m_C4a_rigid : forall (x : Unit) (v v' : Bool), Omega x v -> Omega x v' :=
  fun _ _ _ _ => trivial

/-- Contingency present and the frame not collapsed: the bundle is non-vacuous. -/
theorem m_not_collapsed : Not (forall q : Bool -> Prop, forall w, F.Box q w <-> q w) := by
  intro h
  exact absurd (((h (fun b => b = true) true).mpr rfl) false trivial)
    (by intro k; exact Bool.noConfusion k)

#print axioms m_C1
#print axioms m_C2
#print axioms m_C3
#print axioms m_C3a
#print axioms m_C4
#print axioms m_C4a_identity
#print axioms m_C4a_unique
#print axioms m_C4a_rigid
#print axioms m_not_collapsed
end AltRoute.GroundingModel
