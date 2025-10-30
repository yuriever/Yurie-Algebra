

(* BonimialHopf.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] BonimialHopf.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[1] BonimialHopf.nb"
]

VerificationTest[
    Get["Yurie`Algebra`BinomialHopf`"]
    ,
    Null
    ,
    TestID->"[2] BonimialHopf.nb"
]

VerificationTest[
    algebraDefault[{"BinomialHopf", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
    ,
    Null
    ,
    TestID->"[3] BonimialHopf.nb"
]

VerificationTest[
    algebraMinus["BinomialHopf"]["Relation" -> {antipode[x[n_]] :> (-1)^n*x[n]}]; 
    algebraAdd["BinomialHopf"]["Relation" -> {antipode[x[n_]] :> a[n]*x[n]}]
    ,
    Null
    ,
    TestID->"[4] BonimialHopf.nb"
]

VerificationTest[
    eqs = operatorSeparate[Extract[{All, 2, 1}][(Map[checkAntipode[x[#1]] & ])[Range[5]]]]
    ,
    {1 + a[1], 1 + 2*a[1] + a[2], 1 + 3*a[1] + 3*a[2] + a[3], 1 + 4*a[1] + 6*a[2] + 4*a[3] + a[4], 1 + 5*a[1] + 10*a[2] + 10*a[3] + 5*a[4] + a[5]}
    ,
    TestID->"[5] BonimialHopf.nb"
]

VerificationTest[
    (Solve[#1 == 0, Variables[#1]] & )[eqs]
    ,
    {{a[1] -> -1, a[2] -> 1, a[3] -> -1, a[4] -> 1, a[5] -> -1}}
    ,
    TestID->"[6] BonimialHopf.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    $algebraDefault
    ,
    {}
    ,
    TestID->"[7] BonimialHopf.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] BonimialHopf.nb"
]