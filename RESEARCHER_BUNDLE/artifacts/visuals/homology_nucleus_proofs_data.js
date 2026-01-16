const homologyNucleusProofsData = {
  items: [
    // F2Matrix module
    { name: "F2Matrix", kind: "structure", family: "Computational/F2Matrix", pos: { x: 0.15, y: 0.20, z: 0.30 } },
    { name: "F2Vec", kind: "abbrev", family: "Computational/F2Matrix", pos: { x: 0.12, y: 0.22, z: 0.28 } },
    { name: "F2Vec.xor", kind: "def", family: "Computational/F2Matrix", pos: { x: 0.18, y: 0.18, z: 0.32 } },
    { name: "F2Vec.zero", kind: "def", family: "Computational/F2Matrix", pos: { x: 0.14, y: 0.24, z: 0.26 } },
    { name: "F2Vec.isZero", kind: "def", family: "Computational/F2Matrix", pos: { x: 0.16, y: 0.20, z: 0.34 } },
    { name: "Rref", kind: "structure", family: "Computational/F2Matrix", pos: { x: 0.20, y: 0.15, z: 0.35 } },
    { name: "F2Matrix.rref", kind: "def", family: "Computational/F2Matrix", pos: { x: 0.22, y: 0.17, z: 0.33 } },
    { name: "F2Matrix.rank", kind: "def", family: "Computational/F2Matrix", pos: { x: 0.24, y: 0.19, z: 0.31 } },
    { name: "F2Matrix.nullspaceBasis", kind: "def", family: "Computational/F2Matrix", pos: { x: 0.26, y: 0.14, z: 0.37 } },
    { name: "F2Matrix.columnSpaceBasis", kind: "def", family: "Computational/F2Matrix", pos: { x: 0.28, y: 0.16, z: 0.35 } },
    { name: "F2Matrix.reduceWithRref", kind: "def", family: "Computational/F2Matrix", pos: { x: 0.25, y: 0.21, z: 0.29 } },
    { name: "F2Matrix.mulVec", kind: "def", family: "Computational/F2Matrix", pos: { x: 0.19, y: 0.23, z: 0.27 } },
    
    // ChainComplex module
    { name: "ChainComplexF2", kind: "structure", family: "Computational/ChainComplex", pos: { x: 0.40, y: 0.30, z: 0.40 } },
    { name: "ChainComplexF2.validate", kind: "def", family: "Computational/ChainComplex", pos: { x: 0.38, y: 0.32, z: 0.38 } },
    { name: "ChainComplexF2.checkD2", kind: "def", family: "Computational/ChainComplex", pos: { x: 0.42, y: 0.28, z: 0.42 } },
    { name: "ChainComplexF2.bettiAt", kind: "def", family: "Computational/ChainComplex", pos: { x: 0.44, y: 0.34, z: 0.36 } },
    { name: "ChainComplexF2.bettis", kind: "def", family: "Computational/ChainComplex", pos: { x: 0.46, y: 0.30, z: 0.44 } },
    { name: "ChainComplexF2.boundaryRanks", kind: "def", family: "Computational/ChainComplex", pos: { x: 0.36, y: 0.36, z: 0.34 } },
    { name: "ChainComplexF2.parseJson", kind: "def", family: "Computational/ChainComplex", pos: { x: 0.48, y: 0.26, z: 0.46 } },
    
    // HomologyRepr module
    { name: "ChainComplexF2.cyclesBasis", kind: "def", family: "Computational/HomologyRepr", pos: { x: 0.55, y: 0.45, z: 0.50 } },
    { name: "ChainComplexF2.boundariesBasis", kind: "def", family: "Computational/HomologyRepr", pos: { x: 0.57, y: 0.43, z: 0.52 } },
    { name: "ChainComplexF2.reprModBoundaries", kind: "def", family: "Computational/HomologyRepr", pos: { x: 0.60, y: 0.48, z: 0.48 } },
    { name: "ChainComplexF2.isCycle", kind: "def", family: "Computational/HomologyRepr", pos: { x: 0.53, y: 0.50, z: 0.46 } },
    { name: "ChainComplexF2.inSpanBoundaries", kind: "def", family: "Computational/HomologyRepr", pos: { x: 0.58, y: 0.46, z: 0.54 } },
    { name: "ChainComplexF2.homologyBasisReprs", kind: "def", family: "Computational/HomologyRepr", pos: { x: 0.62, y: 0.42, z: 0.56 } },
    
    // HomologyQuotNucleus module
    { name: "VecN", kind: "abbrev", family: "Nucleus/QuotNucleus", pos: { x: 0.70, y: 0.60, z: 0.65 } },
    { name: "reprTotalVecN", kind: "def", family: "Nucleus/QuotNucleus", pos: { x: 0.72, y: 0.58, z: 0.67 } },
    { name: "reprSetoidVecN", kind: "def", family: "Nucleus/QuotNucleus", pos: { x: 0.74, y: 0.62, z: 0.63 } },
    { name: "CkModBkQuot", kind: "abbrev", family: "Nucleus/QuotNucleus", pos: { x: 0.76, y: 0.56, z: 0.69 } },
    { name: "CkModBkQuot.idNucleus", kind: "def", family: "Nucleus/QuotNucleus", pos: { x: 0.78, y: 0.64, z: 0.61 } },
    { name: "SemilatticeInf CkModBkQuot", kind: "instance", family: "Nucleus/QuotNucleus", pos: { x: 0.75, y: 0.60, z: 0.71 } },
    
    // MathlibHomologyQuotient module
    { name: "MathlibBridge.repr", kind: "def", family: "Nucleus/MathlibBridge", pos: { x: 0.85, y: 0.75, z: 0.80 } },
    { name: "MathlibBridge.mk_repr", kind: "theorem", family: "Nucleus/MathlibBridge", pos: { x: 0.83, y: 0.77, z: 0.78 } },
    { name: "MathlibBridge.repr_eq_repr_iff_mk_eq", kind: "theorem", family: "Nucleus/MathlibBridge", pos: { x: 0.87, y: 0.73, z: 0.82 } },
    { name: "MathlibBridge.repr_eq_repr_iff_sub", kind: "theorem", family: "Nucleus/MathlibBridge", pos: { x: 0.89, y: 0.79, z: 0.76 } },
    { name: "MathlibBridge.Zk", kind: "abbrev", family: "Nucleus/MathlibBridge", pos: { x: 0.81, y: 0.71, z: 0.84 } },
    { name: "MathlibBridge.Bk", kind: "abbrev", family: "Nucleus/MathlibBridge", pos: { x: 0.82, y: 0.74, z: 0.81 } },
    { name: "MathlibBridge.Bk_le_Zk", kind: "theorem", family: "Nucleus/MathlibBridge", pos: { x: 0.84, y: 0.76, z: 0.79 } },
    { name: "MathlibBridge.BkInZk", kind: "def", family: "Nucleus/MathlibBridge", pos: { x: 0.86, y: 0.72, z: 0.83 } },
    { name: "MathlibBridge.Hk", kind: "abbrev", family: "Nucleus/MathlibBridge", pos: { x: 0.88, y: 0.78, z: 0.77 } },
    { name: "MathlibBridge.homologyRepr", kind: "def", family: "Nucleus/MathlibBridge", pos: { x: 0.90, y: 0.74, z: 0.85 } },
    { name: "MathlibBridge.homologyRepr_eq_iff", kind: "theorem", family: "Nucleus/MathlibBridge", pos: { x: 0.91, y: 0.80, z: 0.75 } },
    
    // Tests
    { name: "demoBettis", kind: "def", family: "Tests", pos: { x: 0.50, y: 0.85, z: 0.20 } },
    { name: "demoReprIdempotent", kind: "def", family: "Tests", pos: { x: 0.52, y: 0.83, z: 0.22 } },
    { name: "demoBasisVectorsAreCycles", kind: "def", family: "Tests", pos: { x: 0.54, y: 0.87, z: 0.18 } },
    { name: "demoBasisVectorsNotBoundaries", kind: "def", family: "Tests", pos: { x: 0.56, y: 0.81, z: 0.24 } },
    { name: "demoNucleusExists", kind: "def", family: "Tests", pos: { x: 0.58, y: 0.89, z: 0.16 } }
  ],
  edges: [
    // F2Matrix dependencies
    [0, 1], [0, 5], [1, 2], [1, 3], [1, 4],
    [5, 6], [6, 7], [6, 8], [6, 9], [6, 10],
    [0, 11],
    
    // ChainComplex depends on F2Matrix
    [12, 0], [12, 13], [12, 14], [13, 14],
    [12, 15], [15, 16], [12, 17], [12, 18],
    
    // HomologyRepr depends on ChainComplex
    [19, 12], [20, 12], [21, 19], [21, 20],
    [22, 12], [23, 21], [24, 19], [24, 21],
    
    // HomologyQuotNucleus depends on HomologyRepr
    [25, 1], [26, 21], [27, 26], [28, 27],
    [29, 28], [30, 28],
    
    // MathlibBridge dependencies
    [31, 0], [32, 31], [33, 32], [34, 33],
    [35, 0], [36, 0], [37, 35], [37, 36],
    [38, 37], [39, 35], [39, 36], [40, 38], [41, 40],
    
    // Tests depend on modules
    [42, 16], [43, 21], [44, 22], [45, 23], [46, 29]
  ]
};
