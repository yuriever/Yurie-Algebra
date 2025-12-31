

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
    expr = {a[1]*x + a[2]*y, a[3]*x + a[4]*y}
    ,
    {x*a[1] + y*a[2], x*a[3] + y*a[4]}
    ,
    TestID->"[12] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[x][expr]
    ,
    {id*a[1], id*a[3]}
    ,
    TestID->"[13] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[{x, y}][expr[[1]]]
    ,
    {id*a[1], id*a[2]}
    ,
    TestID->"[14] operatorCoefficient.nb"
]

VerificationTest[
    operatorCoefficient[{x, y}][expr]
    ,
    {{id*a[1], id*a[2]}, {id*a[3], id*a[4]}}
    ,
    TestID->"[15] operatorCoefficient.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    $algebraDefault
    ,
    {}
    ,
    TestID->"[16] operatorCoefficient.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] operatorCoefficient.nb"
]