import HeytingLean.Computational.Homology.HomologyRepr

namespace HeytingLean
namespace Tests
namespace Homology
namespace ReprBasisSanity

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

private def demoBettis : Array Nat :=
  match mkDemo with
  | .error _ => #[]
  | .ok C =>
      match C.bettis with
      | .ok bs => bs
      | .error _ => #[]

private def demoBasisSizes : Array Nat :=
  match mkDemo with
  | .error _ => #[]
  | .ok C =>
      let ks := [0, 1, 2]
      Id.run do
        let mut out : Array Nat := #[]
        for k in ks do
          match ChainComplexF2.homologyBasisReprs C k with
          | .ok bs => out := out.push bs.size
          | .error _ => out := out.push 999999
        out

private def demoReprIdempotent : Bool :=
  match mkDemo with
  | .error _ => false
  | .ok C =>
      let v : F2Matrix.F2Vec := #[true, false, true, true, false, true]  -- arbitrary C₁ vector
      match ChainComplexF2.reprModBoundaries C 1 v with
      | .error _ => false
      | .ok r1 =>
          match ChainComplexF2.reprModBoundaries C 1 r1 with
          | .error _ => false
          | .ok r2 => r1 == r2

private def demoBasisVectorsAreCycles : Bool :=
  match mkDemo with
  | .error _ => false
  | .ok C =>
      let ks := [0, 1, 2]
      ks.all fun k =>
        match ChainComplexF2.homologyBasisReprs C k with
        | .error _ => false
        | .ok bs =>
            bs.all fun v =>
              match ChainComplexF2.isCycle C k v with
              | .ok b => b
              | .error _ => false

private def demoBasisVectorsNotBoundaries : Bool :=
  match mkDemo with
  | .error _ => false
  | .ok C =>
      let ks := [0, 1, 2]
      ks.all fun k =>
        match ChainComplexF2.homologyBasisReprs C k with
        | .error _ => false
        | .ok bs =>
            bs.all fun v =>
              match ChainComplexF2.inSpanBoundaries C k v with
              | .ok b => b == false
              | .error _ => false

example : demoBettis = #[1, 0, 1] := by
  native_decide

example : demoBasisSizes = demoBettis := by
  native_decide

example : demoReprIdempotent = true := by
  native_decide

example : demoBasisVectorsAreCycles = true := by
  native_decide

example : demoBasisVectorsNotBoundaries = true := by
  native_decide

end ReprBasisSanity
end Homology
end Tests
end HeytingLean

