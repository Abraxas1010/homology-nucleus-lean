// UMAP projection data for Homology Nucleus formalization
// Generated from HeytingLean.Computational.Homology namespace

const homologyNucleusProofsData = {
  items: [
    // F2Matrix core types and operations
    { name: "F2Matrix", kind: "structure", family: "F2Matrix", pos: { x: 0.15, y: 0.25, z: 0.30 } },
    { name: "F2Vec", kind: "abbrev", family: "F2Matrix", pos: { x: 0.12, y: 0.28, z: 0.32 } },
    { name: "F2Vec.zero", kind: "def", family: "F2Matrix", pos: { x: 0.10, y: 0.30, z: 0.28 } },
    { name: "F2Vec.xor", kind: "def", family: "F2Matrix", pos: { x: 0.13, y: 0.32, z: 0.34 } },
    { name: "F2Vec.isZero", kind: "def", family: "F2Matrix", pos: { x: 0.11, y: 0.27, z: 0.36 } },

    // Matrix operations
    { name: "F2Matrix.zero", kind: "def", family: "F2Matrix", pos: { x: 0.18, y: 0.22, z: 0.28 } },
    { name: "F2Matrix.validate", kind: "def", family: "F2Matrix", pos: { x: 0.20, y: 0.24, z: 0.26 } },
    { name: "F2Matrix.ofColOnes", kind: "def", family: "F2Matrix", pos: { x: 0.17, y: 0.20, z: 0.32 } },
    { name: "F2Matrix.ofRows", kind: "def", family: "F2Matrix", pos: { x: 0.19, y: 0.26, z: 0.30 } },
    { name: "F2Matrix.mulVec", kind: "def", family: "F2Matrix", pos: { x: 0.22, y: 0.28, z: 0.28 } },
    { name: "F2Matrix.mul", kind: "def", family: "F2Matrix", pos: { x: 0.24, y: 0.30, z: 0.26 } },
    { name: "F2Matrix.rank", kind: "def", family: "F2Matrix", pos: { x: 0.26, y: 0.32, z: 0.24 } },

    // RREF and linear algebra
    { name: "Rref", kind: "structure", family: "LinearAlgebra", pos: { x: 0.30, y: 0.35, z: 0.40 } },
    { name: "F2Matrix.rref", kind: "def", family: "LinearAlgebra", pos: { x: 0.32, y: 0.38, z: 0.42 } },
    { name: "F2Matrix.pivotCols", kind: "def", family: "LinearAlgebra", pos: { x: 0.28, y: 0.40, z: 0.38 } },
    { name: "F2Matrix.reduceWithRref", kind: "def", family: "LinearAlgebra", pos: { x: 0.34, y: 0.42, z: 0.44 } },
    { name: "F2Matrix.columnSpaceBasis", kind: "def", family: "LinearAlgebra", pos: { x: 0.36, y: 0.36, z: 0.46 } },
    { name: "F2Matrix.nullspaceBasis", kind: "def", family: "LinearAlgebra", pos: { x: 0.38, y: 0.34, z: 0.48 } },

    // Chain complex
    { name: "ChainComplexF2", kind: "structure", family: "ChainComplex", pos: { x: 0.50, y: 0.50, z: 0.50 } },
    { name: "ChainComplexF2.validate", kind: "def", family: "ChainComplex", pos: { x: 0.48, y: 0.52, z: 0.48 } },
    { name: "ChainComplexF2.validateShapes", kind: "def", family: "ChainComplex", pos: { x: 0.52, y: 0.48, z: 0.52 } },
    { name: "ChainComplexF2.checkD2", kind: "def", family: "ChainComplex", pos: { x: 0.54, y: 0.54, z: 0.46 } },
    { name: "ChainComplexF2.boundaryRanks", kind: "def", family: "ChainComplex", pos: { x: 0.46, y: 0.56, z: 0.54 } },
    { name: "ChainComplexF2.bettiAt", kind: "def", family: "ChainComplex", pos: { x: 0.56, y: 0.58, z: 0.44 } },
    { name: "ChainComplexF2.bettis", kind: "def", family: "ChainComplex", pos: { x: 0.58, y: 0.46, z: 0.56 } },
    { name: "ChainComplexF2.parseJson", kind: "def", family: "ChainComplex", pos: { x: 0.44, y: 0.44, z: 0.58 } },

    // Homology representatives
    { name: "ChainComplexF2.cyclesBasis", kind: "def", family: "HomologyRepr", pos: { x: 0.65, y: 0.60, z: 0.55 } },
    { name: "ChainComplexF2.boundariesBasis", kind: "def", family: "HomologyRepr", pos: { x: 0.67, y: 0.62, z: 0.53 } },
    { name: "ChainComplexF2.reprModBoundaries", kind: "def", family: "HomologyRepr", pos: { x: 0.70, y: 0.65, z: 0.50 } },
    { name: "ChainComplexF2.isCycle", kind: "def", family: "HomologyRepr", pos: { x: 0.63, y: 0.58, z: 0.57 } },
    { name: "ChainComplexF2.inSpanBoundaries", kind: "def", family: "HomologyRepr", pos: { x: 0.72, y: 0.68, z: 0.48 } },
    { name: "ChainComplexF2.homologyBasisReprs", kind: "def", family: "HomologyRepr", pos: { x: 0.75, y: 0.70, z: 0.45 } },

    // Quotient nucleus (Mathlib integration)
    { name: "VecN", kind: "abbrev", family: "QuotientNucleus", pos: { x: 0.80, y: 0.75, z: 0.60 } },
    { name: "VecN.zero", kind: "def", family: "QuotientNucleus", pos: { x: 0.78, y: 0.77, z: 0.62 } },
    { name: "reprTotalVecN", kind: "def", family: "QuotientNucleus", pos: { x: 0.82, y: 0.73, z: 0.58 } },
    { name: "reprSetoidVecN", kind: "def", family: "QuotientNucleus", pos: { x: 0.84, y: 0.78, z: 0.56 } },
    { name: "HomologyQuot", kind: "abbrev", family: "QuotientNucleus", pos: { x: 0.86, y: 0.80, z: 0.54 } },
    { name: "HomologyQuot.SemilatticeInf", kind: "instance", family: "QuotientNucleus", pos: { x: 0.88, y: 0.82, z: 0.52 } },
    { name: "HomologyQuot.idNucleus", kind: "def", family: "QuotientNucleus", pos: { x: 0.90, y: 0.85, z: 0.50 } },

    // Mathlib bridge theorems
    { name: "MathlibBridge.repr", kind: "def", family: "MathlibBridge", pos: { x: 0.75, y: 0.85, z: 0.70 } },
    { name: "MathlibBridge.mk_repr", kind: "theorem", family: "MathlibBridge", pos: { x: 0.77, y: 0.87, z: 0.72 } },
    { name: "MathlibBridge.repr_eq_repr_iff_mk_eq", kind: "theorem", family: "MathlibBridge", pos: { x: 0.79, y: 0.83, z: 0.74 } },
    { name: "MathlibBridge.repr_eq_repr_iff_sub", kind: "theorem", family: "MathlibBridge", pos: { x: 0.81, y: 0.89, z: 0.68 } },
    { name: "Zk", kind: "abbrev", family: "MathlibBridge", pos: { x: 0.73, y: 0.81, z: 0.76 } },
    { name: "Bk", kind: "abbrev", family: "MathlibBridge", pos: { x: 0.71, y: 0.79, z: 0.78 } },
    { name: "Bk_le_Zk", kind: "theorem", family: "MathlibBridge", pos: { x: 0.83, y: 0.91, z: 0.66 } },
    { name: "BkInZk", kind: "def", family: "MathlibBridge", pos: { x: 0.69, y: 0.77, z: 0.80 } },
    { name: "Hk", kind: "abbrev", family: "MathlibBridge", pos: { x: 0.85, y: 0.93, z: 0.64 } },
    { name: "homologyRepr", kind: "def", family: "MathlibBridge", pos: { x: 0.87, y: 0.88, z: 0.62 } },
    { name: "homologyRepr_eq_iff", kind: "theorem", family: "MathlibBridge", pos: { x: 0.89, y: 0.90, z: 0.60 } },

    // Sanity tests
    { name: "demoBettis", kind: "def", family: "Tests", pos: { x: 0.40, y: 0.80, z: 0.85 } },
    { name: "demoBasisSizes", kind: "def", family: "Tests", pos: { x: 0.42, y: 0.82, z: 0.83 } },
    { name: "demoReprIdempotent", kind: "def", family: "Tests", pos: { x: 0.44, y: 0.78, z: 0.87 } },
    { name: "demoBasisVectorsAreCycles", kind: "def", family: "Tests", pos: { x: 0.38, y: 0.84, z: 0.81 } },
    { name: "demoBasisVectorsNotBoundaries", kind: "def", family: "Tests", pos: { x: 0.46, y: 0.76, z: 0.89 } },
    { name: "demoNucleusExists", kind: "def", family: "Tests", pos: { x: 0.36, y: 0.86, z: 0.79 } }
  ],
  edges: [
    // F2Vec depends on basic Bool operations
    [1, 0], [2, 1], [3, 1], [4, 1],
    // F2Matrix operations depend on F2Matrix structure
    [5, 0], [6, 0], [7, 0], [8, 0], [9, 0], [10, 0], [11, 0],
    // RREF depends on F2Matrix
    [12, 0], [13, 12], [14, 12], [15, 12], [16, 12], [17, 12],
    // Chain complex depends on F2Matrix
    [18, 0], [19, 18], [20, 18], [21, 18], [22, 18], [23, 18], [24, 18], [25, 18],
    // HomologyRepr depends on chain complex and RREF
    [26, 18], [26, 17], [27, 18], [27, 16], [28, 26], [28, 27], [29, 18], [30, 28], [31, 28], [31, 26], [31, 27],
    // QuotientNucleus depends on HomologyRepr
    [32, 1], [33, 32], [34, 28], [35, 34], [36, 35], [37, 36], [38, 36],
    // MathlibBridge depends on Mathlib
    [39, 0], [40, 39], [41, 39], [42, 41], [43, 0], [44, 0], [45, 43], [45, 44], [46, 44], [47, 43], [47, 46], [48, 47], [49, 48],
    // Tests depend on everything
    [50, 24], [51, 31], [52, 28], [53, 31], [53, 29], [54, 31], [54, 30], [55, 38]
  ]
};

// Color scheme by module family
const familyColors = {
  'F2Matrix': '#5e9cff',
  'LinearAlgebra': '#c77dff',
  'ChainComplex': '#4ade80',
  'HomologyRepr': '#fbbf24',
  'QuotientNucleus': '#f472b6',
  'MathlibBridge': '#22d3d3',
  'Tests': '#a3a3a3'
};
