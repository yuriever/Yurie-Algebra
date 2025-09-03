

(* CarCFT2.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] CarCFT2.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[1] CarCFT2.nb"
]

VerificationTest[
    Get["Yurie`Algebra`CarCFT2`"]
    ,
    Null
    ,
    TestID->"[2] CarCFT2.nb"
]

VerificationTest[
    algebraDefault[{"ConformalAlgebra", "Singlet", "Conjugate", "ConformalAlgebraConjugate", "SingletConjugate"}]
    ,
    Null
    ,
    TestID->"[3] CarCFT2.nb"
]

VerificationTest[
    desc[h, ξ, 4, 2]
    ,
    L[-1]**L[-1]**L[-1]**L[-1]**M[-1]**M[-1]**prim[h, ξ]
    ,
    TestID->"[4] CarCFT2.nb"
]

VerificationTest[
    Lmonomial[1, 2, 3, 4]
    ,
    L[1]**L[2]**L[3]**L[4]
    ,
    TestID->"[5] CarCFT2.nb"
]

VerificationTest[
    l = 2; 
    algS[Table[innerProduct[desc[h, ξ, i, l - i], desc[h, ξ, j, l - j]], {i, Range[0, l]}, {j, Range[0, l]}]]
    ,
    {{0, 0, 8*ξ^2}, {0, 4*ξ^2, 4*(ξ + 2*h*ξ)}, {8*ξ^2, 4*(ξ + 2*h*ξ), 4*h*(1 + 2*h)}}
    ,
    TestID->"[6] CarCFT2.nb"
]

VerificationTest[
    algebraUnset[]; 
    algebraDefine[]
    ,
    Quiet[{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
    ,
    {General::StarRemoveDefault}
    ,
    TestID->"[7] CarCFT2.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    algebraDefault[]
    ,
    {}
    ,
    TestID->"[8] CarCFT2.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] CarCFT2.nb"
]