

(* BCGhost.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] BCGhost.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[1] BCGhost.nb"
]

VerificationTest[
    Get["Yurie`Algebra`BCGhost`"]
    ,
    Null
    ,
    TestID->"[2] BCGhost.nb"
]

VerificationTest[
    genL[h_, m_] := Sum[(m - n)*normOrder[b[h, m + n]**c[h, -n]], {n, Range[-max, max]}]; 
    ,
    Null
    ,
    TestID->"[3] BCGhost.nb"
]

VerificationTest[
    genSL2[h_] := (genL[h, #1] & ) /@ {-1, 0, 1}; 
    ,
    Null
    ,
    TestID->"[4] BCGhost.nb"
]

VerificationTest[
    ghostNumber[h_] := Sum[c[h, -n]**b[h, n] - b[h, -n]**c[h, n], {n, Range[1, max]}] + c[h, 0]**b[h, 0] - 1/2; 
    ,
    Null
    ,
    TestID->"[5] BCGhost.nb"
]

VerificationTest[
    normOrder[b[h_, n_]**c[h_, m_]] := -c[h, m]**b[h, n] /; n >= 1 - h; 
    (normOrder[b[h_, n_]**c[h_, m_]] := b[h, n]**c[h, m] /; n < 1 - h; )
    ,
    Null
    ,
    TestID->"[6] BCGhost.nb"
]

VerificationTest[
    algebraDefault["BCGhost", "Vacuum", "Conjugate"]
    ,
    Null
    ,
    TestID->"[7] BCGhost.nb"
]

VerificationTest[
    h0 = 2; 
    (max = 10; )
    ,
    Null
    ,
    TestID->"[8] BCGhost.nb"
]

VerificationTest[
    algS[Table[op**vac, {op, genSL2[h0]}]]
    ,
    {0, 0, 0}
    ,
    TestID->"[9] BCGhost.nb"
]

VerificationTest[
    algS[Table[op**c[2, -1]**vac, {op, genSL2[h0]}]]
    ,
    {3*c[2, -2]**vac, c[2, -1]**vac, -c[2, 0]**vac}
    ,
    TestID->"[10] BCGhost.nb"
]

VerificationTest[
    algS[Table[op**c[2, 1]**vac, {op, genSL2[h0]}]]
    ,
    {c[2, 0]**vac, -c[2, 1]**vac, 0}
    ,
    TestID->"[11] BCGhost.nb"
]

VerificationTest[
    algS[genL[h0, 1]**c[h0, -1]**vac + genL[h0, -1]**c[h0, 1]**vac]
    ,
    0
    ,
    TestID->"[12] BCGhost.nb"
]

VerificationTest[
    algebraUnset[]; 
    algebraDefine[]
    ,
    Quiet[{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
    ,
    {General::StarRemoveDefault}
    ,
    TestID->"[13] BCGhost.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    algebraDefault[]
    ,
    {}
    ,
    TestID->"[14] BCGhost.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] BCGhost.nb"
]