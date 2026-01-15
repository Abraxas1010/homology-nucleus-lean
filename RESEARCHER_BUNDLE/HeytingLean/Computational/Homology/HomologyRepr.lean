import HeytingLean.Computational.Homology.ChainComplex

namespace HeytingLean
namespace Computational
namespace Homology

open Std

namespace ChainComplexF2

open HeytingLean.Computational.Homology.F2Matrix

private def stdBasis (n : Nat) : Array F2Vec :=
  Id.run do
    let mut out : Array F2Vec := Array.mkEmpty n
    for i in [:n] do
      let mut v := F2Vec.zero n
      v := v.set! i true
      out := out.push v
    out

def cyclesBasis (C : ChainComplexF2) (k : Nat) : Except String (Array F2Vec) := do
  if k ≥ C.dims.size then
    throw s!"cyclesBasis: k out of range: {k} (dims length={C.dims.size})"
  if k == 0 then
    pure (stdBasis (C.dims[0]!))
  else
    let dk := C.boundaries[k - 1]!
    if dk.cols != C.dims[k]! then
      throw s!"cyclesBasis: internal shape mismatch at k={k}"
    F2Matrix.nullspaceBasis dk

def boundariesBasis (C : ChainComplexF2) (k : Nat) : Except String (Array F2Vec) := do
  if k ≥ C.dims.size then
    throw s!"boundariesBasis: k out of range: {k} (dims length={C.dims.size})"
  if k ≥ C.boundaries.size then
    pure #[]
  else
    let dNext := C.boundaries[k]!
    if dNext.rows != C.dims[k]! then
      throw s!"boundariesBasis: internal shape mismatch at k={k}"
    F2Matrix.columnSpaceBasis dNext

private def boundariesRref (C : ChainComplexF2) (k : Nat) : Except String (Option Rref) := do
  let bs ← boundariesBasis C k
  if bs.isEmpty then
    pure none
  else
    let B ← F2Matrix.ofRows bs
    pure (some (← F2Matrix.rref B))

def reprModBoundariesWith (Rb : Option Rref) (v : F2Vec) : Except String F2Vec := do
  match Rb with
  | none => pure v
  | some R =>
      let (rem, _) ← F2Matrix.reduceWithRref R v
      pure rem

def reprModBoundaries (C : ChainComplexF2) (k : Nat) (v : F2Vec) : Except String F2Vec := do
  if k ≥ C.dims.size then
    throw s!"reprModBoundaries: k out of range: {k} (dims length={C.dims.size})"
  if v.size != C.dims[k]! then
    throw s!"reprModBoundaries: vec length {v.size} != dim C_{k} = {C.dims[k]!}"
  let Rb ← boundariesRref C k
  reprModBoundariesWith Rb v

def isCycle (C : ChainComplexF2) (k : Nat) (v : F2Vec) : Except String Bool := do
  if k ≥ C.dims.size then
    throw s!"isCycle: k out of range: {k} (dims length={C.dims.size})"
  if v.size != C.dims[k]! then
    throw s!"isCycle: vec length {v.size} != dim C_{k} = {C.dims[k]!}"
  if k == 0 then
    pure true
  else
    let dk := C.boundaries[k - 1]!
    let y ← F2Matrix.mulVec dk v
    pure (F2Vec.isZero y)

def inSpanBoundaries (C : ChainComplexF2) (k : Nat) (v : F2Vec) : Except String Bool := do
  let r ← reprModBoundaries C k v
  pure (F2Vec.isZero r)

/-- A basis of canonical representatives for `Hₖ = Zₖ / Bₖ`, computed by:

1) basis for `Zₖ` as a nullspace basis of `∂ₖ` (or standard basis for `k=0`),
2) reduce each cycle modulo `Bₖ`,
3) take a basis of the resulting span via RREF.
-/
def homologyBasisReprs (C : ChainComplexF2) (k : Nat) : Except String (Array F2Vec) := do
  C.validate
  let Rb ← boundariesRref C k
  let zs ← cyclesBasis C k
  let mut reps : Array F2Vec := Array.mkEmpty zs.size
  for z in zs do
    reps := reps.push (← reprModBoundariesWith Rb z)
  reps := reps.filter (fun v => !F2Vec.isZero v)
  if reps.isEmpty then
    pure #[]
  else
    let M ← F2Matrix.ofRows reps
    let R ← F2Matrix.rref M
    pure (F2Matrix.nonzeroRows R.matrix)

end ChainComplexF2

end Homology
end Computational
end HeytingLean
