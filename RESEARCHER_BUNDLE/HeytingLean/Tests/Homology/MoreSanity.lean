import HeytingLean.Computational.Homology.HomologyRepr

namespace HeytingLean
namespace Tests
namespace Homology
namespace MoreSanity

open HeytingLean.Computational.Homology

private def bettisOf (C : ChainComplexF2) : Array Nat :=
  match C.bettis with
  | .ok bs => bs
  | .error _ => #[]

private def basisSizesOf (C : ChainComplexF2) : Array Nat :=
  let ks := List.range C.dims.size
  Id.run do
    let mut out : Array Nat := #[]
    for k in ks do
      match ChainComplexF2.homologyBasisReprs C k with
      | .ok bs => out := out.push bs.size
      | .error _ => out := out.push 999999
    out

/-! ### S¹: a 3-cycle graph (no faces) -/

private def mkCircle : Except String ChainComplexF2 := do
  let dims : Array Nat := #[3, 3]
  let d1Cols : Array (Array Nat) :=
    #[ #[0, 1]  -- e01
     , #[1, 2]  -- e12
     , #[2, 0]  -- e20
     ]
  let d1 ← F2Matrix.ofColOnes dims[0]! dims[1]! d1Cols
  let C : ChainComplexF2 := { dims := dims, boundaries := #[d1] }
  C.validateShapes
  pure C

private def circleBettis : Array Nat :=
  match mkCircle with
  | .error _ => #[]
  | .ok C => bettisOf C

example : circleBettis = #[1, 1] := by
  native_decide

example :
    match mkCircle with
    | .error _ => false
    | .ok C => basisSizesOf C = bettisOf C
  := by
  native_decide

/-! ### Disk: a filled triangle (one 2-simplex) -/

private def mkDisk : Except String ChainComplexF2 := do
  let dims : Array Nat := #[3, 3, 1]
  let d1Cols : Array (Array Nat) :=
    #[ #[0, 1]  -- e01
     , #[1, 2]  -- e12
     , #[2, 0]  -- e20
     ]
  let d2Cols : Array (Array Nat) :=
    #[ #[0, 1, 2] ] -- boundary of the single face uses all 3 edges
  let d1 ← F2Matrix.ofColOnes dims[0]! dims[1]! d1Cols
  let d2 ← F2Matrix.ofColOnes dims[1]! dims[2]! d2Cols
  let C : ChainComplexF2 := { dims := dims, boundaries := #[d1, d2] }
  C.validateShapes
  pure C

private def diskBettis : Array Nat :=
  match mkDisk with
  | .error _ => #[]
  | .ok C => bettisOf C

example : diskBettis = #[1, 0, 0] := by
  native_decide

example :
    match mkDisk with
    | .error _ => false
    | .ok C => basisSizesOf C = bettisOf C
  := by
  native_decide

/-! ### Wedge of two circles: two 3-cycles sharing one vertex (no faces) -/

private def mkWedge2 : Except String ChainComplexF2 := do
  -- Vertices: v0 shared, plus v1 v2 for first cycle and v3 v4 for second: total 5
  -- Edges: 3 + 3 = 6
  let dims : Array Nat := #[5, 6]
  let d1Cols : Array (Array Nat) :=
    #[ #[0, 1]  -- first cycle: 0-1
     , #[1, 2]  -- 1-2
     , #[2, 0]  -- 2-0
     , #[0, 3]  -- second cycle: 0-3
     , #[3, 4]  -- 3-4
     , #[4, 0]  -- 4-0
     ]
  let d1 ← F2Matrix.ofColOnes dims[0]! dims[1]! d1Cols
  let C : ChainComplexF2 := { dims := dims, boundaries := #[d1] }
  C.validateShapes
  pure C

private def wedge2Bettis : Array Nat :=
  match mkWedge2 with
  | .error _ => #[]
  | .ok C => bettisOf C

example : wedge2Bettis = #[1, 2] := by
  native_decide

example :
    match mkWedge2 with
    | .error _ => false
    | .ok C => basisSizesOf C = bettisOf C
  := by
  native_decide

end MoreSanity
end Homology
end Tests
end HeytingLean

