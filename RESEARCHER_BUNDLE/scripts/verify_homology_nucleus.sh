#!/usr/bin/env bash
set -euo pipefail

echo "=== Homology Nucleus Verification ==="
echo ""

# Check for sorry/admit
echo "Checking for sorry/admit..."
if grep -rn "sorry\|admit" HeytingLean/*.lean HeytingLean/**/*.lean 2>/dev/null; then
    echo "ERROR: Found sorry/admit in codebase"
    exit 1
fi
echo "✓ No sorry/admit found"
echo ""

# Build
echo "Building with strict flags..."
lake build --wfail
echo "✓ Build successful"
echo ""

# Count declarations
echo "Declaration count:"
echo "  Modules: $(find HeytingLean -name '*.lean' | wc -l)"
echo "  Lines: $(find HeytingLean -name '*.lean' -exec cat {} + | wc -l)"
echo ""

echo "=== All checks passed ==="
