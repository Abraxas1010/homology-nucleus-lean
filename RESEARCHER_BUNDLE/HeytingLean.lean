-- Homology Nucleus: Computable F₂ Representatives and Mathlib Quotient Proofs
--
-- This module provides:
-- 1. Executable F₂ linear algebra (RREF, nullspace, column-space bases)
-- 2. Computable canonical representatives modulo boundaries for Hₖ = Zₖ/Bₖ
-- 3. A genuine Mathlib.Order.Nucleus instance on the computed quotient type
-- 4. A Mathlib proof that repr-induced quotients coincide with Zₖ/Bₖ submodule quotients

-- Core F₂ matrix operations
import HeytingLean.Computational.Homology.F2Matrix

-- Chain complex structure and Betti number computation
import HeytingLean.Computational.Homology.ChainComplex

-- Computable homology representatives
import HeytingLean.Computational.Homology.HomologyRepr

-- Mathlib Nucleus on computed quotient type
import HeytingLean.Computational.Homology.HomologyQuotNucleus

-- Mathlib proof: repr quotient = submodule quotient
import HeytingLean.Computational.Homology.MathlibHomologyQuotient

-- Sanity tests
import HeytingLean.Tests.Homology.ReprBasisSanity
import HeytingLean.Tests.Homology.QuotNucleusSanity
import HeytingLean.Tests.Homology.MathlibQuotientReprSanity
import HeytingLean.Tests.Homology.MoreSanity
