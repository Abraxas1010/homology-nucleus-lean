# Proof Index

## Theorems

### MathlibBridge.mk_repr
**File**: `MathlibHomologyQuotient.lean`
**Statement**: `(Submodule.Quotient.mk (repr p x)) = Submodule.Quotient.mk x`

The quotient of a representative equals the original quotient.

### MathlibBridge.repr_eq_repr_iff_mk_eq
**File**: `MathlibHomologyQuotient.lean`
**Statement**: `repr p x = repr p y ↔ (Submodule.Quotient.mk x) = Submodule.Quotient.mk y`

Representatives are equal iff quotients are equal.

### MathlibBridge.repr_eq_repr_iff_sub
**File**: `MathlibHomologyQuotient.lean`
**Statement**: `repr p x = repr p y ↔ x - y ∈ p`

**Key theorem**: Representatives are equal iff the difference lies in the submodule.

### MathlibBridge.Bk_le_Zk
**File**: `MathlibHomologyQuotient.lean`
**Statement**: `Bk d_kp1 ≤ Zk d_k` (given `d_k.comp d_kp1 = 0`)

Boundaries are contained in cycles (chain complex law).

### MathlibBridge.homologyRepr_eq_iff
**File**: `MathlibHomologyQuotient.lean`
**Statement**: `homologyRepr x = homologyRepr y ↔ x - y ∈ BkInZk`

Homology representatives coincide iff elements differ by a boundary.

## Definitions

### F2Matrix.rref
**File**: `F2Matrix.lean`
**Type**: `F2Matrix → Except String Rref`

Compute reduced row echelon form with pivot tracking.

### F2Matrix.nullspaceBasis
**File**: `F2Matrix.lean`
**Type**: `F2Matrix → Except String (Array F2Vec)`

Compute a basis for the kernel of an F₂ matrix.

### F2Matrix.columnSpaceBasis
**File**: `F2Matrix.lean`
**Type**: `F2Matrix → Except String (Array F2Vec)`

Compute a basis for the column space (range) of an F₂ matrix.

### ChainComplexF2.homologyBasisReprs
**File**: `HomologyRepr.lean`
**Type**: `ChainComplexF2 → Nat → Except String (Array F2Vec)`

Compute canonical representative basis for homology group Hₖ.

### HomologyQuot.idNucleus
**File**: `HomologyQuotNucleus.lean`
**Type**: `Nucleus (HomologyQuot C k n)`

A genuine Mathlib Nucleus on the computed quotient type.

## Structures

### F2Matrix
**File**: `F2Matrix.lean`

Executable matrix over F₂ (row-major `Array (Array Bool)`).

### Rref
**File**: `F2Matrix.lean`

Reduced row echelon form with pivot position tracking.

### ChainComplexF2
**File**: `ChainComplex.lean`

Chain complex over F₂ with dimension array and boundary matrices.

### VecN
**File**: `HomologyQuotNucleus.lean`

Fixed-length F₂ vector (subtype of `F2Vec`).

## Instances

### HomologyQuot.SemilatticeInf
**File**: `HomologyQuotNucleus.lean`

The computed quotient forms a semilattice with inf.
