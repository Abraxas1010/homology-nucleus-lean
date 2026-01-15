import Std

namespace HeytingLean
namespace Computational
namespace Homology

open Std

/-- A small, executable matrix over `F₂`, represented row-major as `Bool`s. -/
structure F2Matrix where
  rows : Nat
  cols : Nat
  data : Array (Array Bool)   -- each row has length `cols`
  deriving Repr

namespace F2Matrix

instance : Inhabited F2Matrix :=
  ⟨{ rows := 0, cols := 0, data := #[] }⟩

/-- An executable `F₂` vector, represented as an `Array Bool`. -/
abbrev F2Vec := Array Bool

namespace F2Vec

def zero (n : Nat) : F2Vec :=
  Array.replicate n false

private def xorUnsafe (a b : F2Vec) : F2Vec :=
  Id.run do
    let mut out : F2Vec := Array.mkEmpty a.size
    for i in [:a.size] do
      out := out.push (Bool.xor a[i]! b[i]!)
    out

def xor (a b : F2Vec) : Except String F2Vec := do
  if a.size != b.size then
    throw s!"F2Vec.xor: length mismatch {a.size} vs {b.size}"
  pure (xorUnsafe a b)

def onesIdx (v : F2Vec) : Array Nat :=
  Id.run do
    let mut out : Array Nat := #[]
    for i in [:v.size] do
      if v[i]! then
        out := out.push i
    out

def isZero (v : F2Vec) : Bool :=
  v.all (fun b => b == false)

end F2Vec

/-- Check the structural invariants of the matrix representation. -/
def validate (M : F2Matrix) : Except String Unit := do
  if M.data.size != M.rows then
    throw s!"malformed F2Matrix: data has {M.data.size} rows, expected {M.rows}"
  for i in [:M.rows] do
    let row := M.data[i]!
    if row.size != M.cols then
      throw s!"malformed F2Matrix: row {i} has {row.size} cols, expected {M.cols}"

def wellFormed (M : F2Matrix) : Bool :=
  match M.validate with
  | .ok _ => true
  | .error _ => false

def zero (rows cols : Nat) : F2Matrix :=
  { rows := rows
  , cols := cols
  , data := Array.replicate rows (Array.replicate cols false)
  }

/-- Build a matrix from a "columns of ones" sparse encoding.

`colOnes[j]` lists the row indices `i` where `M[i,j] = 1`.

This is convenient for boundary matrices of simplicial complexes over `F₂`. -/
def ofColOnes (rows cols : Nat) (colOnes : Array (Array Nat)) : Except String F2Matrix := do
  if colOnes.size != cols then
    throw s!"expected {cols} columns, got {colOnes.size}"
  let mut data : Array (Array Bool) := Array.replicate rows (Array.replicate cols false)
  for j in [:cols] do
    for i in colOnes[j]! do
      if i < rows then
        let row := data[i]!
        data := data.set! i (row.set! j true)
      else
        throw s!"row index out of bounds: {i} (rows={rows})"
  pure { rows := rows, cols := cols, data := data }

def ofRows (rows : Array F2Vec) : Except String F2Matrix := do
  if rows.isEmpty then
    pure { rows := 0, cols := 0, data := #[] }
  else
    let cols := rows[0]!.size
    for i in [:rows.size] do
      if rows[i]!.size != cols then
        throw s!"ofRows: row {i} has {rows[i]!.size} cols, expected {cols}"
    pure { rows := rows.size, cols := cols, data := rows }

private def rowXorUnsafe (a b : Array Bool) : Array Bool :=
  Id.run do
    let mut out : Array Bool := Array.mkEmpty a.size
    for i in [:a.size] do
      out := out.push (Bool.xor a[i]! b[i]!)
    out

def isZero (M : F2Matrix) : Bool :=
  M.data.all (fun row => row.all (fun b => b == false))

def getCol (M : F2Matrix) (j : Nat) : Except String F2Vec := do
  if j ≥ M.cols then
    throw s!"getCol: col index out of bounds: {j} (cols={M.cols})"
  M.validate
  let mut out : F2Vec := Array.mkEmpty M.rows
  for i in [:M.rows] do
    out := out.push (M.data[i]![j]!)
  pure out

def mulVec (A : F2Matrix) (x : F2Vec) : Except String F2Vec := do
  if x.size != A.cols then
    throw s!"mulVec: dimension mismatch: {A.rows}×{A.cols} times vec({x.size})"
  A.validate
  let mut out : F2Vec := Array.mkEmpty A.rows
  for i in [:A.rows] do
    let row := A.data[i]!
    let mut t : Bool := false
    for j in [:A.cols] do
      t := Bool.xor t (row[j]! && x[j]!)
    out := out.push t
  pure out

def mul (A B : F2Matrix) : Except String F2Matrix := do
  if A.cols != B.rows then
    throw s!"dimension mismatch: {A.rows}×{A.cols} times {B.rows}×{B.cols}"
  A.validate
  B.validate
  let n := A.rows
  let k := A.cols
  let m := B.cols
  let out := Id.run do
    let mut rowsAcc : Array (Array Bool) := Array.mkEmpty n
    for i in [:n] do
      let rowA := A.data[i]!
      let mut rowC : Array Bool := Array.mkEmpty m
      for j in [:m] do
        let s := Id.run do
          let mut t : Bool := false
          for p in [:k] do
            t := Bool.xor t (rowA[p]! && B.data[p]![j]!)
          t
        rowC := rowC.push s
      rowsAcc := rowsAcc.push rowC
    rowsAcc
  pure { rows := n, cols := m, data := out }

private def findPivotRow (data : Array (Array Bool)) (col : Nat) (start : Nat) : Option Nat :=
  let rec loop (i : Nat) : Option Nat :=
    if h : i < data.size then
      if data[i]![col]! then
        some i
      else
        loop (i + 1)
    else
      none
  loop start

/-- Reduced row echelon form of an `F₂` matrix, tracking which columns have pivots. -/
structure Rref where
  matrix : F2Matrix
  /-- `pivotAt[col] = some row` if `col` is a pivot column with pivot at `row`. -/
  pivotAt : Array (Option Nat)
  deriving Repr

/-- Compute reduced row echelon form (RREF) over `F₂`.

Pivot strategy: scan columns left-to-right and choose the first available pivot row (top-down),
swapping deterministically. -/
def rref (M : F2Matrix) : Except String Rref := do
  M.validate
  let mut data := M.data
  let mut pivotRow : Nat := 0
  let mut pivotAt : Array (Option Nat) := Array.replicate M.cols none

  for col in [:M.cols] do
    if pivotRow ≥ M.rows then
      break
    match findPivotRow data col pivotRow with
    | none => continue
    | some pr =>
        if pr != pivotRow then
          let tmp := data[pr]!
          data := (data.set! pr data[pivotRow]!).set! pivotRow tmp
        pivotAt := pivotAt.set! col (some pivotRow)
        let piv := data[pivotRow]!
        for i in [:M.rows] do
          if i != pivotRow && data[i]![col]! then
            data := data.set! i (rowXorUnsafe data[i]! piv)
        pivotRow := pivotRow + 1

  pure { matrix := { rows := M.rows, cols := M.cols, data := data }, pivotAt := pivotAt }

def pivotCols (R : Rref) : Array Nat :=
  Id.run do
    let mut out : Array Nat := #[]
    for j in [:R.matrix.cols] do
      if (R.pivotAt[j]!).isSome then
        out := out.push j
    out

def nonzeroRows (M : F2Matrix) : Array F2Vec :=
  M.data.filter (fun r => !F2Vec.isZero r)

/-- Reduce a vector modulo the row-span of the RREF rows, producing a canonical remainder.

Returns `(rem, coeffs)` where `coeffs` selects a subset of the RREF rows such that
`orig = rem XOR linComb(coeffs)` and `rem` has `0` in every pivot column. -/
def reduceWithRref (R : Rref) (v : F2Vec) : Except String (F2Vec × Array Bool) := do
  if v.size != R.matrix.cols then
    throw s!"reduceWithRref: dimension mismatch: vec({v.size}) vs cols={R.matrix.cols}"
  R.matrix.validate
  let mut rem := v
  let mut coeffs : Array Bool := Array.replicate R.matrix.rows false
  for col in [:R.matrix.cols] do
    match R.pivotAt[col]! with
    | none => continue
    | some r =>
        if rem[col]! then
          rem := rowXorUnsafe rem R.matrix.data[r]!
          coeffs := coeffs.set! r (Bool.xor coeffs[r]! true)
  pure (rem, coeffs)

def linCombRows (rows : Array F2Vec) (coeffs : Array Bool) : Except String F2Vec := do
  if rows.isEmpty then
    if coeffs.isEmpty then
      pure #[]
    else
      throw s!"linCombRows: empty rows but coeffs length is {coeffs.size}"
  else
    if coeffs.size != rows.size then
      throw s!"linCombRows: coeffs length {coeffs.size} != rows length {rows.size}"
    let n := rows[0]!.size
    for i in [:rows.size] do
      if rows[i]!.size != n then
        throw s!"linCombRows: row {i} has {rows[i]!.size} cols, expected {n}"
    let mut out : F2Vec := F2Vec.zero n
    for i in [:rows.size] do
      if coeffs[i]! then
        out := rowXorUnsafe out rows[i]!
    pure out

/-- Basis for the column space of `M` (as vectors in `F₂^(rows)`), via pivot columns of the RREF. -/
def columnSpaceBasis (M : F2Matrix) : Except String (Array F2Vec) := do
  let R ← rref M
  let pivs := pivotCols R
  let mut out : Array F2Vec := Array.mkEmpty pivs.size
  for j in pivs do
    out := out.push (← M.getCol j)
  pure out

/-- Basis for the nullspace of `M` (as vectors in `F₂^(cols)`), via the RREF description. -/
def nullspaceBasis (M : F2Matrix) : Except String (Array F2Vec) := do
  let R ← rref M
  let mut out : Array F2Vec := #[]
  for freeCol in [:M.cols] do
    if (R.pivotAt[freeCol]!).isSome then
      continue
    let mut x : F2Vec := F2Vec.zero M.cols
    x := x.set! freeCol true
    for pivCol in [:M.cols] do
      match R.pivotAt[pivCol]! with
      | none => continue
      | some r =>
          if R.matrix.data[r]![freeCol]! then
            x := x.set! pivCol (Bool.xor x[pivCol]! true)
    if !F2Vec.isZero x then
      out := out.push x
  pure out

/-- Compute matrix rank over `F₂` as the number of pivot columns in `rref`. -/
def rank (M : F2Matrix) : Except String Nat := do
  let R ← rref M
  pure (pivotCols R).size

end F2Matrix

end Homology
end Computational
end HeytingLean
