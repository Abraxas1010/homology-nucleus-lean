import HeytingLean.Computational.Homology.HomologyQuotNucleus
import HeytingLean.Computational.Homology.ChainComplex

namespace HeytingLean
namespace Tests
namespace Homology
namespace QuotNucleusSanity

open HeytingLean.Computational.Homology

private def mkDemo : Except String ChainComplexF2 := do
  let dims : Array Nat := #[4, 6, 4]
  let d1Cols : Array (Array Nat) :=
    #[ #[0, 1]  -- 01
     , #[0, 2]  -- 02
     , #[0, 3]  -- 03
     , #[1, 2]  -- 12
     , #[1, 3]  -- 13
     , #[2, 3]  -- 23
     ]
  let d2Cols : Array (Array Nat) :=
    #[ #[0, 1, 3]  -- 012
     , #[0, 2, 4]  -- 013
     , #[1, 2, 5]  -- 023
     , #[3, 4, 5]  -- 123
     ]
  let d1 ← F2Matrix.ofColOnes dims[0]! dims[1]! d1Cols
  let d2 ← F2Matrix.ofColOnes dims[1]! dims[2]! d2Cols
  let C : ChainComplexF2 := { dims := dims, boundaries := #[d1, d2] }
  C.validateShapes
  pure C

private def demoNucleusExists : Bool :=
  match mkDemo with
  | .error _ => false
  | .ok C =>
      let n1 := C.dims[1]!
      let _N : Nucleus (ChainComplexF2.HomologyQuot C 1 n1) :=
        ChainComplexF2.HomologyQuot.idNucleus (C := C) (k := 1) (n := n1)
      true

example : demoNucleusExists = true := by
  native_decide

end QuotNucleusSanity
end Homology
end Tests
end HeytingLean

