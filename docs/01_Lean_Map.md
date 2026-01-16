# Module Structure

## Overview

The Homology Nucleus formalization is organized into two main layers:

```
HeytingLean/
├── Computational/Homology/  # F₂ linear algebra + chain complexes
└── Tests/Homology/          # Sanity tests
```

## Computational Layer

### F2Matrix.lean
XOR Gaussian elimination over F₂.

| Definition | Description |
|------------|-------------|
| `F2Matrix` | Row-major matrix of `Bool`s |
| `F2Vec` | Vector as `Array Bool` |
| `Rref` | Reduced row echelon form with pivot tracking |
| `rref` | Deterministic RREF computation |
| `rank` | Matrix rank via pivot count |
| `nullspaceBasis` | Kernel basis via free columns |
| `columnSpaceBasis` | Image basis via pivot columns |
| `reduceWithRref` | Reduce vector modulo row-span |

### ChainComplex.lean
Chain complex representation and Betti computation.

| Definition | Description |
|------------|-------------|
| `ChainComplexF2` | Chain complex with dims + boundary matrices |
| `validate` | Check shapes + ∂²=0 |
| `bettiAt` | Betti number βₖ = nₖ - rank(∂ₖ) - rank(∂ₖ₊₁) |
| `bettis` | All Betti numbers |
| `parseJson` | Parse from JSON format |

### HomologyRepr.lean
Canonical representatives via reduction modulo boundaries.

| Definition | Description |
|------------|-------------|
| `cyclesBasis` | Basis for Zₖ = ker(∂ₖ) |
| `boundariesBasis` | Basis for Bₖ = im(∂ₖ₊₁) |
| `reprModBoundaries` | Canonical representative selector |
| `isCycle` | Check if vector is a cycle |
| `inSpanBoundaries` | Check if vector is a boundary |
| `homologyBasisReprs` | Basis of Hₖ as canonical reps |

### HomologyQuotNucleus.lean
Mathlib `Nucleus` on the computed quotient.

| Definition | Description |
|------------|-------------|
| `VecN` | Fixed-length F₂ vectors |
| `reprTotalVecN` | Total repr function |
| `reprSetoidVecN` | Setoid induced by repr-kernel |
| `CkModBkQuot` | Quotient type |
| `CkModBkQuot.idNucleus` | Mathlib `Nucleus` instance |

### MathlibHomologyQuotient.lean
Proof that repr-induced quotient = Mathlib `Submodule` quotient.

| Theorem | Statement |
|---------|-----------|
| `repr_eq_repr_iff_sub` | `repr x = repr y ↔ x - y ∈ p` |
| `Bk_le_Zk` | Boundaries are cycles |
| `homologyRepr_eq_iff` | Specialized to Zₖ/Bₖ |

## Dependency Graph

```
F2Matrix
    ↓
ChainComplex
    ↓
HomologyRepr
    ↓
┌────────────────┬──────────────────┐
│ HomologyQuotNucleus │ MathlibHomologyQuotient │
└────────────────┴──────────────────┘
```

## Tests

| Test File | Purpose |
|-----------|---------|
| `Sanity.lean` | Basic Betti number verification |
| `ReprBasisSanity.lean` | Idempotence + cycle/boundary tests |
| `QuotNucleusSanity.lean` | Nucleus existence test |
| `MathlibQuotientReprSanity.lean` | Quotient relation test |
| `MoreSanity.lean` | S¹, disk, wedge additional tests |
