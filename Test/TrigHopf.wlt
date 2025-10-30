

(* TrigHopf.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] TrigHopf.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[1] TrigHopf.nb"
]

VerificationTest[
    Get["Yurie`Algebra`TrigHopf`"]
    ,
    Null
    ,
    TestID->"[2] TrigHopf.nb"
]

VerificationTest[
    algebraDefault[{"TrigHopf", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
    ,
    Null
    ,
    TestID->"[3] TrigHopf.nb"
]

VerificationTest[
    (Map[checkCoassociativity])[generator[]]
    ,
    {{id} -> 0, {c} -> 0, {s} -> 0}
    ,
    TestID->"[4] TrigHopf.nb"
]

VerificationTest[
    (Map[checkCounitality])[generator[]]
    ,
    {{id} -> {0, 0}, {c} -> {0, 0}, {s} -> {0, 0}}
    ,
    TestID->"[5] TrigHopf.nb"
]

VerificationTest[
    (Map[checkAntipode])[generator[]]
    ,
    {{id} -> {0, 0}, {c} -> {0, 0}, {s} -> {0, 0}}
    ,
    TestID->"[6] TrigHopf.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    $algebraDefault
    ,
    {}
    ,
    TestID->"[7] TrigHopf.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] TrigHopf.nb"
]