import Mathlib.LinearAlgebra.Quotient.Basic

namespace HeytingLean
namespace Computational
namespace Homology
namespace MathlibBridge

open Submodule

section SubmoduleRepr

variable {R M : Type*} [Ring R] [AddCommGroup M] [Module R M]
variable (p : Submodule R M)

/-- A (noncomputable) representative selector for the quotient `M ⧸ p`, defined by `Quotient.out`. -/
noncomputable def repr (x : M) : M :=
  Quotient.out (Submodule.Quotient.mk x : M ⧸ p)

theorem mk_repr (x : M) : (Submodule.Quotient.mk (repr p x) : M ⧸ p) = Submodule.Quotient.mk x := by
  unfold repr
  simpa using (Submodule.Quotient.mk_out (p := p) (m := (Submodule.Quotient.mk x : M ⧸ p)))

theorem repr_eq_repr_iff_mk_eq (x y : M) :
    repr p x = repr p y ↔ (Submodule.Quotient.mk x : M ⧸ p) = Submodule.Quotient.mk y := by
  constructor
  · intro h
    -- Apply `mk` to both sides and use `mk_repr`.
    have : (Submodule.Quotient.mk (repr p x) : M ⧸ p) = Submodule.Quotient.mk (repr p y) := by
      simpa [h]
    simpa [mk_repr (p := p)] using this
  · intro h
    -- `repr` is `Quotient.out` applied to `mk x`; if the quotients are equal, the reps are equal.
    unfold repr
    simpa [h]

theorem repr_eq_repr_iff_sub (x y : M) :
    repr p x = repr p y ↔ x - y ∈ p := by
  -- Reduce to the standard quotient equality criterion.
  simpa [repr_eq_repr_iff_mk_eq (p := p)] using
    (Submodule.Quotient.eq (p := p) (x := x) (y := y))

end SubmoduleRepr

section Homology

variable {R Ckp1 Ck Ckm1 : Type*} [Ring R] [AddCommGroup Ckp1] [AddCommGroup Ck] [AddCommGroup Ckm1]
variable [Module R Ckp1] [Module R Ck] [Module R Ckm1]

variable (d_k : Ck →ₗ[R] Ckm1) (d_kp1 : Ckp1 →ₗ[R] Ck)

/-- Cycles `Zₖ = ker(dₖ)`. -/
abbrev Zk : Submodule R Ck := LinearMap.ker d_k

/-- Boundaries `Bₖ = range(dₖ₊₁)`. -/
abbrev Bk : Submodule R Ck := LinearMap.range d_kp1

variable (hD2 : d_k.comp d_kp1 = 0)

theorem Bk_le_Zk : Bk (d_kp1 := d_kp1) ≤ Zk (d_k := d_k) := by
  intro x hx
  rcases hx with ⟨y, rfl⟩
  -- `d_k (d_kp1 y) = 0` by the chain complex law.
  have : d_k (d_kp1 y) = 0 := by
    have := congrArg (fun f => f y) hD2
    simpa using this
  simpa [Zk, LinearMap.mem_ker] using this

/-- The boundary submodule viewed as a submodule of `Zₖ`. -/
def BkInZk : Submodule R (Zk (d_k := d_k)) :=
  (Bk (d_kp1 := d_kp1)).comap (Zk (d_k := d_k)).subtype

/-- Classical homology quotient `Hₖ = Zₖ / Bₖ` (as a Mathlib `Submodule` quotient). -/
abbrev Hk : Type* :=
  (Zk (d_k := d_k)) ⧸ (BkInZk (d_k := d_k) (d_kp1 := d_kp1))

/-- Representative selector on `Hₖ`, transported to an endomorphism on `Zₖ`. -/
noncomputable def homologyRepr (z : Zk (d_k := d_k)) : Zk (d_k := d_k) :=
  MathlibBridge.repr (p := BkInZk (d_k := d_k) (d_kp1 := d_kp1)) z

theorem homologyRepr_eq_iff (x y : Zk (d_k := d_k)) :
    homologyRepr (d_k := d_k) (d_kp1 := d_kp1) x =
        homologyRepr (d_k := d_k) (d_kp1 := d_kp1) y
      ↔ x - y ∈ (BkInZk (d_k := d_k) (d_kp1 := d_kp1)) := by
  simpa [homologyRepr] using
    (MathlibBridge.repr_eq_repr_iff_sub (p := BkInZk (d_k := d_k) (d_kp1 := d_kp1)) x y)

end Homology

end MathlibBridge
end Homology
end Computational
end HeytingLean

