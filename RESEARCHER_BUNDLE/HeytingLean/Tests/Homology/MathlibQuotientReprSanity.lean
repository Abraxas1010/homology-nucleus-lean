import HeytingLean.Computational.Homology.MathlibHomologyQuotient

namespace HeytingLean
namespace Tests
namespace Homology
namespace MathlibQuotientReprSanity

open HeytingLean.Computational.Homology.MathlibBridge

section

open scoped BigOperators

-- Smoke test: the representative selector induces exactly the usual quotient relation.
example :
    let R := ZMod 2
    let M := (Fin 3 → R)
    let p : Submodule R M := ⊤
    ∀ x y : M, repr p x = repr p y ↔ x - y ∈ p := by
  intro R M p x y
  simpa using (repr_eq_repr_iff_sub (p := p) x y)

end

end MathlibQuotientReprSanity
end Homology
end Tests
end HeytingLean

