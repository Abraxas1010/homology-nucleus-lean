# Dependencies

## Lean Toolchain

| Component | Version | Source |
|-----------|---------|--------|
| Lean 4 | v4.24.0 | [lean-lang.org](https://lean-lang.org/) |
| Lake | (bundled) | Lean package manager |

## Mathlib Dependencies

All dependencies are pinned in `lakefile.lean` for reproducibility.

| Package | Version/Commit | Purpose |
|---------|----------------|---------|
| mathlib | v4.24.0 | Core mathematics library |
| batteries | 8da40b7... | Extended standard library |
| Qq | dea6a33... | Quotation/metaprogramming |
| aesop | 725ac8c... | Proof automation |
| Cli | 91c18fa... | Command-line parsing |
| importGraph | d768126... | Import graph utilities |
| LeanSearchClient | 99657ad... | Mathlib search client |
| plausible | dfd06eb... | Property-based testing |

## Mathlib Modules Used

### Order Theory

| Module | Imports |
|--------|---------|
| `Mathlib.Order.Nucleus` | `Nucleus` definition |
| `Mathlib.Order.Closure` | Closure operator basics |
| `Mathlib.Order.Basic` | Partial order fundamentals |

### Linear Algebra

| Module | Imports |
|--------|---------|
| `Mathlib.LinearAlgebra.Quotient.Basic` | `Submodule.Quotient` |
| `Mathlib.LinearAlgebra.Basic` | Linear maps |
| `Mathlib.Algebra.Module.Submodule.Basic` | Submodule definition |

## Standard Library

| Module | Purpose |
|--------|---------|
| `Std` | Arrays, HashMap, basic utilities |
| `Lean.Data.Json` | JSON parsing for chain complexes |

## No External Runtime Dependencies

The formalization is purely type-checked—no external solvers, SMT integrations, or runtime libraries are required. All computations use Lean's native `native_decide` tactic.

## Updating Dependencies

To update to newer Mathlib (may break proofs):

```bash
# Edit lakefile.lean to change mathlib version
lake update
lake build
```

We recommend keeping the pinned versions for reproducibility.
