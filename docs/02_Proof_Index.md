# Proof Index

## Key Theorems

### Computational Results

| Name | Statement | File |
|------|-----------|------|
| `F2Matrix.rank` | Rank via RREF pivot count | F2Matrix.lean |
| `ChainComplexF2.checkD2` | ∂² = 0 verification | ChainComplex.lean |
| `ChainComplexF2.bettiAt` | βₖ = nₖ - rank(∂ₖ) - rank(∂ₖ₊₁) | ChainComplex.lean |

### Representative Properties

| Name | Statement | File |
|------|-----------|------|
| `reprModBoundaries` | Canonical rep via RREF reduction | HomologyRepr.lean |
| `homologyBasisReprs` | Basis of Hₖ as fixed reps | HomologyRepr.lean |
| `demoReprIdempotent` | `repr(repr(z)) = repr(z)` | ReprBasisSanity.lean |
| `demoBasisVectorsAreCycles` | Basis reps are cycles | ReprBasisSanity.lean |
| `demoBasisVectorsNotBoundaries` | Basis reps not boundaries | ReprBasisSanity.lean |

### Nucleus Integration

| Name | Statement | File |
|------|-----------|------|
| `SemilatticeInf CkModBkQuot` | Quotient is semilattice | HomologyQuotNucleus.lean |
| `CkModBkQuot.idNucleus` | Mathlib `Nucleus` on quotient | HomologyQuotNucleus.lean |
| `repr_eq_repr_iff_sub` | `repr x = repr y ↔ x - y ∈ p` | MathlibHomologyQuotient.lean |
| `Bk_le_Zk` | `Bₖ ⊆ Zₖ` (boundaries are cycles) | MathlibHomologyQuotient.lean |
| `homologyRepr_eq_iff` | Homology-specific quotient criterion | MathlibHomologyQuotient.lean |

## Test Examples

### Tetrahedron Boundary (β = [1, 0, 1])

```lean
-- 4 vertices, 6 edges, 4 faces (hollow tetrahedron)
example : demoBettis = #[1, 0, 1] := by native_decide
example : demoBasisSizes = demoBettis := by native_decide
example : demoReprIdempotent = true := by native_decide
```

### S¹ (Circle, β = [1, 1])

```lean
-- 3 vertices, 3 edges forming a triangle boundary
-- β₀ = 1 (connected), β₁ = 1 (one hole)
```

### Disk (Filled Triangle, β = [1, 0, 0])

```lean
-- 3 vertices, 3 edges, 1 face
-- β₀ = 1 (connected), β₁ = 0 (no holes), β₂ = 0 (solid)
```

## Definitions

| Name | Type | Description |
|------|------|-------------|
| `F2Matrix` | `structure` | Row-major F₂ matrix |
| `F2Vec` | `abbrev` | `Array Bool` |
| `Rref` | `structure` | RREF + pivot tracking |
| `ChainComplexF2` | `structure` | Chain complex representation |
| `VecN` | `abbrev` | Fixed-length F₂ vector |
| `CkModBkQuot` | `abbrev` | Quotient by repr-kernel |
| `Zk` | `abbrev` | `ker(∂ₖ)` |
| `Bk` | `abbrev` | `im(∂ₖ₊₁)` |
| `BkInZk` | `def` | Bk as submodule of Zk |
| `Hk` | `abbrev` | `Zk ⧸ BkInZk` |
