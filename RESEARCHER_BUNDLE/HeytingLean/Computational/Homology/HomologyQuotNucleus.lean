import Mathlib.Order.Nucleus

import HeytingLean.Computational.Homology.HomologyRepr

namespace HeytingLean
namespace Computational
namespace Homology

open Std
open HeytingLean.Computational.Homology.F2Matrix

namespace ChainComplexF2

/-- Fixed-length `F₂` vectors. -/
abbrev VecN (n : Nat) := { v : F2Vec // v.size = n }

namespace VecN

def zero (n : Nat) : VecN n :=
  ⟨F2Vec.zero n, by simp [F2Vec.zero]⟩

end VecN

/-- Total representative function on fixed-length vectors: defaults to the input vector on error.

For well-formed inputs (correct `k` and `n = C.dims[k]!`), this agrees with `reprModBoundaries`. -/
def reprTotalVecN (C : ChainComplexF2) (k : Nat) {n : Nat} (v : VecN n) : VecN n :=
  let r : F2Vec := (reprModBoundaries C k v.1).getD v.1
  if hsz : r.size = n then
    ⟨r, hsz⟩
  else
    -- Defensive fallback: maintain the `VecN n` invariant even if an unexpected size change occurs.
    v

/-- The setoid induced by the computed representative: two vectors are equivalent iff they map to the
same representative. -/
def reprSetoidVecN (C : ChainComplexF2) (k : Nat) (n : Nat) : Setoid (VecN n) where
  r a b := C.reprTotalVecN k a = C.reprTotalVecN k b
  iseqv :=
    { refl := by intro a; rfl
      symm := by intro a b h; simpa using h.symm
      trans := by intro a b c hab hbc; exact hab.trans hbc
    }

/-- The “computed homology quotient” as a type: quotient by the kernel of `reprTotalVecN`.

This is a *strong* Mathlib-checked quotient object (via `Quot`) aligned with the executable
normal-form selection, without importing Mathlib’s homological algebra stack. -/
abbrev CkModBkQuot (C : ChainComplexF2) (k n : Nat) : Type :=
  Quot (C.reprSetoidVecN k n)

namespace CkModBkQuot

variable {C : ChainComplexF2} {k n : Nat}

private def bot (C : ChainComplexF2) (k n : Nat) : CkModBkQuot C k n :=
  Quot.mk _ (C.reprTotalVecN k (VecN.zero n))

private def le (C : ChainComplexF2) (k n : Nat) (a b : CkModBkQuot C k n) : Prop :=
  a = bot C k n ∨ a = b

private def inf (C : ChainComplexF2) (k n : Nat) (a b : CkModBkQuot C k n) : CkModBkQuot C k n :=
  if h : a = b then a else bot C k n

private theorem le_refl (C : ChainComplexF2) (k n : Nat) (a : CkModBkQuot C k n) : le C k n a a :=
  Or.inr rfl

private theorem le_trans (C : ChainComplexF2) (k n : Nat) {a b c : CkModBkQuot C k n} :
    le C k n a b → le C k n b c → le C k n a c := by
  intro hab hbc
  rcases hab with hab | rfl
  · exact Or.inl hab
  · rcases hbc with hbc | rfl
    · exact Or.inl hbc
    · exact Or.inr rfl

private theorem le_antisymm (C : ChainComplexF2) (k n : Nat) {a b : CkModBkQuot C k n} :
    le C k n a b → le C k n b a → a = b := by
  intro hab hba
  rcases hab with hab | hab
  · -- `a = bot`
    rcases hba with hba | hba
    · exact hab.symm.trans hba
    · exact hab.symm.trans hba
  · -- `a = b`
    exact hab

private theorem inf_le_left (C : ChainComplexF2) (k n : Nat) (a b : CkModBkQuot C k n) :
    le C k n (inf C k n a b) a := by
  unfold inf le
  by_cases h : a = b
  · simp [h]
  · simp [h]

private theorem inf_le_right (C : ChainComplexF2) (k n : Nat) (a b : CkModBkQuot C k n) :
    le C k n (inf C k n a b) b := by
  unfold inf le
  by_cases h : a = b
  · simp [h]
  · simp [h]

private theorem le_inf (C : ChainComplexF2) (k n : Nat) {a b c : CkModBkQuot C k n} :
    le C k n a b → le C k n a c → le C k n a (inf C k n b c) := by
  intro hab hac
  unfold inf le
  by_cases h : b = c
  · simp [h, hab]
  · -- `inf b c = bot`, so `a ≤ bot` holds iff `a = bot` (or trivially if `a = bot` already).
    rcases hab with hb | rfl
    · exact Or.inl hb
    · simp [h]

instance : SemilatticeInf (CkModBkQuot C k n) where
  le a b := le C k n a b
  le_refl := le_refl C k n
  le_trans := by intro a b c; exact le_trans C k n
  le_antisymm := by intro a b; exact le_antisymm C k n
  inf a b := inf C k n a b
  le_inf := by
    intro a b c hab hac
    exact le_inf C k n hab hac
  inf_le_left := by
    intro a b
    exact inf_le_left C k n a b
  inf_le_right := by
    intro a b
    exact inf_le_right C k n a b
  inf_assoc := by
    intro a b c
    unfold inf bot
    by_cases hab : a = b <;> by_cases hbc : b = c <;> by_cases hac : a = c <;> simp [hab, hbc, hac]
  inf_comm := by
    intro a b
    unfold inf bot
    by_cases h : a = b <;> simp [h, Eq.comm]
  inf_idem := by
    intro a
    unfold inf bot
    simp

/-- A genuine Mathlib `Nucleus` whose `Ω` is (trivially) the computed quotient itself. -/
def idNucleus : Nucleus (CkModBkQuot C k n) where
  toFun x := x
  map_inf' x y := by simp
  idempotent' x := by simp
  le_apply' x := by simp

end CkModBkQuot

end ChainComplexF2

end Homology
end Computational
end HeytingLean
