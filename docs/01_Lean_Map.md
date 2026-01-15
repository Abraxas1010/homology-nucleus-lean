# Lean Module Map

## Overview

This formalization provides computable homology representatives over F₂ with Mathlib integration.

## Module Structure

```
HeytingLean/
├── Computational/
│   └── Homology/
│       ├── F2Matrix.lean           # Core F₂ linear algebra
│       ├── ChainComplex.lean       # Chain complex + Betti numbers
│       ├── HomologyRepr.lean       # Computable representatives
│       ├── HomologyQuotNucleus.lean # Mathlib Nucleus instance
│       └── MathlibHomologyQuotient.lean # Quotient equivalence proof
└── Tests/
    └── Homology/
        ├── ReprBasisSanity.lean    # Representative sanity checks
        ├── QuotNucleusSanity.lean  # Nucleus existence test
        └── MathlibQuotientReprSanity.lean # Quotient proof test
```

## Module Dependencies

```
F2Matrix.lean
    ↓
ChainComplex.lean
    ↓
HomologyRepr.lean
    ↓
HomologyQuotNucleus.lean
    ↓
MathlibHomologyQuotient.lean (imports Mathlib.LinearAlgebra.Quotient.Basic)
```

## Key Namespaces

| Namespace | Description |
|-----------|-------------|
| `HeytingLean.Computational.Homology` | Main computational homology namespace |
| `HeytingLean.Computational.Homology.F2Matrix` | F₂ matrix operations |
| `HeytingLean.Computational.Homology.ChainComplexF2` | Chain complex over F₂ |
| `HeytingLean.Computational.Homology.MathlibBridge` | Mathlib integration |
| `HeytingLean.Tests.Homology` | Sanity tests |

## External Dependencies

- **Mathlib v4.24.0**: `Mathlib.Order.Nucleus`, `Mathlib.LinearAlgebra.Quotient.Basic`
- **Std**: Standard library for `HashMap`, `Array`, etc.
