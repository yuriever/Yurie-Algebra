

(* operatorCoefficient.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] operatorCoefficient.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"[1] operatorCoefficient.nb"
]

VerificationTest[
    algebraDefine["test"]
    ,
    Null
    ,
    TestID->"[2] operatorCoefficient.nb"
]

VerificationTest[
    algebraDefault["test", "Tensor"]
    ,
    Null
    ,
    TestID->"[3] operatorCoefficient.nb"
]

VerificationTest[
    algebraAdd["test"][Association["Generator" -> {x, y, z}]]
    ,
    Null
    ,
    TestID->"[4] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[x][1]
    ,
    0
    ,
    TestID->"[5] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[x][x]
    ,
    id
    ,
    TestID->"[6] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[x][2*x]
    ,
    2*id
    ,
    TestID->"[7] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[x][y**x]
    ,
    y
    ,
    TestID->"[8] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[x][2*y**x]
    ,
    2*y
    ,
    TestID->"[9] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[x][a[0]*x + a[1]*y**x]
    ,
    id*a[0] + y*a[1]
    ,
    TestID->"[10] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[x][a[0]*x + a[1]*y**x + a[2]*z**(x + y + z**(x + y))]
    ,
    id*a[0] + y*a[1] + a[2]*z**(id + z**id)
    ,
    TestID->"[11] operatorCoefficient.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    $algebraDefault
    ,
    {}
    ,
    TestID->"[12] operatorCoefficient.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] operatorCoefficient.nb"
]