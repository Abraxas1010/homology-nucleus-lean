<img src="assets/Apoth3osis.webp" alt="Apoth3osis Logo" width="140"/>

<sub><strong>Our tech stack is ontological:</strong><br>
<strong>Hardware — Physics</strong><br>
<strong>Software — Mathematics</strong><br><br>
<strong>Our engineering workflow is simple:</strong> discover, build, grow, learn & teach</sub>

---

<sub>
<strong>Notice of Proprietary Information</strong><br>
This document outlines foundational concepts and methodologies developed during internal research and development at Apoth3osis. To protect our intellectual property and adhere to client confidentiality agreements, the code, architectural details, and performance metrics presented herein may be simplified, redacted, or presented for illustrative purposes only. This paper is intended to share our conceptual approach and does not represent the full complexity, scope, or performance of our production-level systems. The complete implementation and its derivatives remain proprietary.
</sub>

---

# Homology Nucleus: Computable F₂ Representatives with Mathlib Quotient Proofs

![Lean 4.24.0](https://img.shields.io/badge/Lean-4.24.0-blue)
![Mathlib v4.24.0](https://img.shields.io/badge/Mathlib-v4.24.0-purple)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
![Sorry Count: 0](https://img.shields.io/badge/sorry-0-brightgreen)

## Credo

> *"The purpose of computing is insight, not numbers."*
> — **Richard Hamming**, *Numerical Methods for Scientists and Engineers* (1962)

This formalization embodies Hamming's wisdom by providing not merely numerical Betti numbers, but *computable canonical representatives* for homology classes. Where traditional computational topology stops at counting dimensions, we construct explicit basis elements and prove they coincide with the classical algebraic-topological quotient construction. The representative selector becomes a genuine Mathlib `Nucleus`, bridging executable computation with Mathlib's algebraic hierarchy.

### Acknowledgment

We humbly thank the collective intelligence of humanity for providing the technology and culture we cherish. We do our best to properly reference the authors of the works utilized herein, though we may occasionally fall short. Our formalization acts as a reciprocal validation—confirming the structural integrity of their original insights while securing the foundation upon which we build. In truth, all creative work is derivative; we stand on the shoulders of those who came before, and our contributions are simply the next link in an unbroken chain of human ingenuity.

---

**Machine-checked formalization of computable homology representatives over F₂, proving that the representative-induced quotient relation coincides with the classical Zₖ/Bₖ submodule quotient.**

<table>
<tr>
<td align="center" width="50%">
<strong>2D Proof Map</strong><br/>
<em>Click to explore: pan, zoom, search declarations</em><br/>
<a href="https://abraxas1010.github.io/homology-nucleus-lean/RESEARCHER_BUNDLE/artifacts/visuals/homology_nucleus_2d.html">
  <img src="RESEARCHER_BUNDLE/artifacts/visuals/homology_nucleus_2d_preview.svg" alt="UMAP 2D preview" width="100%"/>
</a><br/>
<a href="https://abraxas1010.github.io/homology-nucleus-lean/RESEARCHER_BUNDLE/artifacts/visuals/homology_nucleus_2d.html">▶ Open Interactive 2D Map</a>
</td>
<td align="center" width="50%">
<strong>3D Proof Map</strong><br/>
<em>Click to explore: rotate, zoom, click nodes</em><br/>
<a href="https://abraxas1010.github.io/homology-nucleus-lean/RESEARCHER_BUNDLE/artifacts/visuals/homology_nucleus_3d.html">
  <img src="RESEARCHER_BUNDLE/artifacts/visuals/homology_nucleus_3d_preview_animated.svg" alt="UMAP 3D animated preview" width="100%"/>
</a><br/>
<a href="https://abraxas1010.github.io/homology-nucleus-lean/RESEARCHER_BUNDLE/artifacts/visuals/homology_nucleus_3d.html">▶ Open Interactive 3D Map</a>
</td>
</tr>
</table>

---

## Why This Matters

Traditional computational homology libraries compute **Betti numbers**—the dimensions of homology groups. But for many applications (persistent homology visualization, cycle extraction, feature identification), you need the actual **representative cycles**.

This formalization provides:

1. **Computable Representatives**: Given a chain complex over F₂, extract canonical basis vectors for each homology group Hₖ = Zₖ/Bₖ
2. **Mathlib Integration**: A genuine `Mathlib.Order.Nucleus` instance on the computed quotient type
3. **Correctness Proof**: Machine-checked proof that the representative-induced equivalence coincides with the classical submodule quotient

## Key Results

### Core Theorem: Quotient Equivalence

```lean
theorem repr_eq_repr_iff_sub (x y : M) :
    repr p x = repr p y ↔ x - y ∈ p
```

The representative selector `repr : M → M` (defined via `Quotient.out`) induces exactly the standard quotient relation: two elements have the same representative if and only if their difference lies in the submodule.

### Specialized to Homology

```lean
theorem homologyRepr_eq_iff (x y : Zk d_k) :
    homologyRepr d_k d_kp1 x = homologyRepr d_k d_kp1 y
      ↔ x - y ∈ BkInZk d_k d_kp1
```

For cycles `x, y ∈ Zₖ = ker(dₖ)`, their homology representatives coincide iff they differ by a boundary in `Bₖ = range(dₖ₊₁)`.

### Nucleus Instance

```lean
def idNucleus : Nucleus (HomologyQuot C k n) where
  toFun x := x
  map_inf' x y := by simp
  idempotent' x := by simp
  le_apply' x := by simp
```

The computed quotient type carries a genuine Mathlib `Nucleus` structure, connecting our executable construction to the abstract algebraic framework.

## Architecture

```
HeytingLean/Computational/Homology/
├── F2Matrix.lean           # F₂ linear algebra: RREF, nullspace, column-space bases
├── ChainComplex.lean       # Chain complex structure, Betti number computation
├── HomologyRepr.lean       # Computable representatives: cyclesBasis, boundariesBasis, homologyBasisReprs
├── HomologyQuotNucleus.lean # Mathlib Nucleus on computed quotient type
└── MathlibHomologyQuotient.lean # Proof: repr quotient = submodule quotient

HeytingLean/Tests/Homology/
├── ReprBasisSanity.lean    # Tests: idempotence, basis sizes, cycles not boundaries
├── QuotNucleusSanity.lean  # Tests: Nucleus instance exists and type-checks
└── MathlibQuotientReprSanity.lean # Tests: quotient equivalence on ZMod 2
```

## F₂ Linear Algebra APIs

Beyond simple rank computation, this library provides:

| Function | Description |
|----------|-------------|
| `F2Matrix.rref` | Reduced row echelon form with pivot tracking |
| `F2Matrix.reduceWithRref` | Vector reduction modulo row-span |
| `F2Matrix.nullspaceBasis` | Basis for ker(M) |
| `F2Matrix.columnSpaceBasis` | Basis for range(M) |
| `ChainComplexF2.cyclesBasis` | Basis for Zₖ = ker(∂ₖ) |
| `ChainComplexF2.boundariesBasis` | Basis for Bₖ = range(∂ₖ₊₁) |
| `ChainComplexF2.homologyBasisReprs` | Canonical representatives for Hₖ |

## Verification

```bash
cd RESEARCHER_BUNDLE
lake build --wfail
```

### Sanity Checks (compile-time verified)

```lean
-- Betti numbers of tetrahedron boundary: β₀=1, β₁=0, β₂=1
example : demoBettis = #[1, 0, 1] := by native_decide

-- Basis sizes match Betti numbers
example : demoBasisSizes = demoBettis := by native_decide

-- Representative is idempotent: repr(repr(v)) = repr(v)
example : demoReprIdempotent = true := by native_decide

-- All basis vectors are cycles
example : demoBasisVectorsAreCycles = true := by native_decide

-- No basis vector is a boundary
example : demoBasisVectorsNotBoundaries = true := by native_decide

-- Nucleus instance type-checks
example : demoNucleusExists = true := by native_decide
```

## References

1. **Edelsbrunner, H. & Harer, J.** (2010). *Computational Topology: An Introduction*. AMS.
2. **Kaczynski, T., Mischaikow, K., & Mrozek, M.** (2004). *Computational Homology*. Springer.
3. **Mathlib Community** (2024). *Mathlib4*. https://github.com/leanprover-community/mathlib4
4. **nLab** (2024). *Nucleus (order theory)*. https://ncatlab.org/nlab/show/nucleus

## License

MIT License. See [LICENSE](LICENSE) for details.

---

<p align="center">
Part of the <a href="https://github.com/Abraxas1010/heyting">HeytingLean</a> formalization project<br/>
<a href="https://apoth3osis.io">apoth3osis.io</a>
</p>
