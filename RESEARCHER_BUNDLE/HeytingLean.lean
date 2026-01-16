/-!
# Homology Nucleus Lean - Computable F₂ Representatives

Machine-checked formalization proving that computable `repr`-induced quotients
coincide with the classical Mathlib `Zₖ/Bₖ` submodule quotients.

## Modules

### Computational Layer (F₂ Linear Algebra)
- `F2Matrix`: XOR Gaussian elimination, RREF, nullspace/column-space bases
- `ChainComplex`: Chain complex representation, Betti number computation
- `HomologyRepr`: Canonical representatives via reduction modulo boundaries

### Nucleus Layer (Mathlib Integration)
- `HomologyQuotNucleus`: Genuine Mathlib `Nucleus` on the computed quotient
- `MathlibHomologyQuotient`: Proof that `repr x = repr y ↔ x - y ∈ Bₖ`

### Key Results
- `repr` is idempotent: `repr(repr(z)) = repr(z)`
- Basis representatives are cycles but not boundaries
- Quotient-by-repr equals classical `Zₖ/Bₖ` quotient
- The quotient carries a Mathlib `Nucleus` structure
-/

-- Computational Layer
import HeytingLean.Computational.Homology.F2Matrix
import HeytingLean.Computational.Homology.ChainComplex
import HeytingLean.Computational.Homology.HomologyRepr

-- Nucleus Layer
import HeytingLean.Computational.Homology.HomologyQuotNucleus
import HeytingLean.Computational.Homology.MathlibHomologyQuotient

-- Tests
import HeytingLean.Tests.Homology.Sanity
import HeytingLean.Tests.Homology.ReprBasisSanity
import HeytingLean.Tests.Homology.QuotNucleusSanity
import HeytingLean.Tests.Homology.MathlibQuotientReprSanity
import HeytingLean.Tests.Homology.MoreSanity
