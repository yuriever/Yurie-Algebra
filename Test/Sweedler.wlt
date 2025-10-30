

(* Sweedler.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] Sweedler.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[1] Sweedler.nb"
]

VerificationTest[
    Get["Yurie`Algebra`Sweedler`"]
    ,
    Null
    ,
    TestID->"[2] Sweedler.nb"
]

VerificationTest[
    algebraDefault[{"Sweedler", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
    ,
    Null
    ,
    TestID->"[3] Sweedler.nb"
]

VerificationTest[
    (Map[checkCoassociativity])[generator[]]
    ,
    {{id} -> 0, {g} -> 0, {x} -> 0}
    ,
    TestID->"[4] Sweedler.nb"
]

VerificationTest[
    (Map[checkCounitality])[generator[]]
    ,
    {{id} -> {0, 0}, {g} -> {0, 0}, {x} -> {0, 0}}
    ,
    TestID->"[5] Sweedler.nb"
]

VerificationTest[
    (Map[checkAntipode])[generator[]]
    ,
    {{id} -> {0, 0}, {g} -> {0, 0}, {x} -> {0, 0}}
    ,
    TestID->"[6] Sweedler.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    $algebraDefault
    ,
    {}
    ,
    TestID->"[7] Sweedler.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] Sweedler.nb"
]