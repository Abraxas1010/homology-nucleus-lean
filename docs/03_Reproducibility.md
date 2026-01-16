# Reproducibility Guide

## Requirements

- **Lean**: v4.24.0 (pinned in `lean-toolchain`)
- **Mathlib**: v4.24.0 (pinned in `lakefile.lean`)
- **elan**: Latest (for Lean toolchain management)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/Abraxas1010/homology-nucleus-lean.git
cd homology-nucleus-lean/RESEARCHER_BUNDLE

# Install Lean toolchain (if needed)
elan default leanprover/lean4:v4.24.0

# Fetch dependencies
lake update

# Build and verify
lake build --wfail
```

## Verification Steps

### 1. Build Library

```bash
lake build --wfail
```

This compiles all modules and verifies all proofs. The `--wfail` flag treats warnings as errors.

### 2. Check for Sorry/Admit

```bash
grep -rn "sorry\|admit" HeytingLean/*.lean HeytingLean/**/*.lean
```

Expected output: no matches (exit code 1).

### 3. Run Sanity Tests

The test files use `native_decide` to verify computational results:

```lean
-- ReprBasisSanity.lean
example : demoBettis = #[1, 0, 1] := by native_decide
example : demoReprIdempotent = true := by native_decide
```

These tests execute at compile time—if the build succeeds, the tests pass.

## Build Times

| Component | Approximate Time |
|-----------|------------------|
| First build (with Mathlib) | 15-30 minutes |
| Incremental rebuild | <1 minute |
| Full clean rebuild | 15-30 minutes |

## Troubleshooting

### Missing Lean Toolchain

```bash
elan install leanprover/lean4:v4.24.0
elan default leanprover/lean4:v4.24.0
```

### Lake Cache Issues

```bash
lake clean
lake update
lake build
```

### Mathlib Version Mismatch

The `lakefile.lean` pins all dependencies. If you see version conflicts:

```bash
rm -rf .lake lake-manifest.json
lake update
```

## File Checksums

To verify file integrity:

```bash
sha256sum HeytingLean/Computational/Homology/*.lean
```

## CI Integration

For GitHub Actions:

```yaml
- uses: leanprover/lean4-action@v1
  with:
    lean-version: 'v4.24.0'
- run: cd RESEARCHER_BUNDLE && lake build --wfail
```
