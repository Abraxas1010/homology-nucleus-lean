# Reproducibility Guide

## Requirements

- **Lean**: v4.24.0
- **Lake**: Included with Lean toolchain
- **Mathlib**: v4.24.0 (fetched automatically)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/Abraxas1010/homology-nucleus-lean.git
cd homology-nucleus-lean/RESEARCHER_BUNDLE

# Build (first build will download Mathlib, ~10-15 min)
lake build --wfail
```

## Verification Steps

### 1. Check for sorry/admit

```bash
grep -rn "sorry\|admit" HeytingLean/
# Should return nothing (zero matches)
```

### 2. Full Build

```bash
lake build --wfail
```

The `--wfail` flag treats warnings as errors, ensuring strict compilation.

### 3. Verify Sanity Tests

All sanity tests are compile-time verified via `native_decide`:

```lean
-- In ReprBasisSanity.lean
example : demoBettis = #[1, 0, 1] := by native_decide
example : demoBasisSizes = demoBettis := by native_decide
example : demoReprIdempotent = true := by native_decide
example : demoBasisVectorsAreCycles = true := by native_decide
example : demoBasisVectorsNotBoundaries = true := by native_decide

-- In QuotNucleusSanity.lean
example : demoNucleusExists = true := by native_decide
```

These are checked at compile time; a successful build proves they pass.

## Expected Build Output

```
Build completed successfully.
```

## Troubleshooting

### Mathlib download fails

If Mathlib download is interrupted:

```bash
rm -rf .lake/packages
lake update
lake build --wfail
```

### Toolchain mismatch

Ensure you're using the correct Lean version:

```bash
cat lean-toolchain
# Should show: leanprover/lean4:v4.24.0
```

If using elan:

```bash
elan override set leanprover/lean4:v4.24.0
```

### Memory issues

Mathlib is large. If build fails with OOM:

```bash
# Reduce parallelism
lake build -j1 --wfail
```

## CI/CD Note

This repository is designed for local verification. No CI/CD configuration is included by default to ensure portability and avoid external dependencies.
