# Dependencies

## Direct Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| Mathlib | v4.24.0 | Order.Nucleus, LinearAlgebra.Quotient.Basic |
| Std | (via Mathlib) | HashMap, Array utilities |

## Mathlib Modules Used

### Mathlib.Order.Nucleus

Provides the `Nucleus` typeclass for closure operators on meet-semilattices:

```lean
class Nucleus (α : Type*) [SemilatticeInf α] where
  toFun : α → α
  map_inf' : ∀ x y, toFun (x ⊓ y) = toFun x ⊓ toFun y
  idempotent' : ∀ x, toFun (toFun x) = toFun x
  le_apply' : ∀ x, x ≤ toFun x
```

### Mathlib.LinearAlgebra.Quotient.Basic

Provides `Submodule.Quotient` and the key theorem:

```lean
theorem Submodule.Quotient.eq (x y : M) :
    (Submodule.Quotient.mk x : M ⧸ p) = Submodule.Quotient.mk y ↔ x - y ∈ p
```

## Pinned Auxiliary Packages

For build reproducibility, auxiliary packages are pinned to specific revisions:

| Package | Revision | Notes |
|---------|----------|-------|
| Cli | 91c18fa | Lean 4 CLI library |
| Qq | dea6a33 | Quote4 metaprogramming |
| aesop | 725ac8c | Proof automation |
| importGraph | d768126 | Import graph utilities |
| LeanSearchClient | 99657ad | Lean search integration |
| plausible | dfd06eb | Property testing |
| batteries | 8da40b7 | Standard library extensions |

## Version Compatibility

This formalization requires:
- Lean 4.24.0 (specified in `lean-toolchain`)
- Mathlib v4.24.0 (specified in `lakefile.lean`)

Earlier or later versions may require adjustments due to:
- API changes in Mathlib
- Syntax changes in Lean 4
- Tactic behavior differences

## Updating Dependencies

To update to a newer Mathlib version:

1. Edit `lakefile.lean` to point to new version
2. Update `lean-toolchain` if required
3. Update auxiliary package pins to match Mathlib's manifest
4. Run `lake update`
5. Fix any API breakages
6. Rebuild and verify all sanity tests pass
