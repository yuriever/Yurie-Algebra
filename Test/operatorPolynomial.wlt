

(* operatorPolynomial.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] operatorPolynomial.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"[1] operatorPolynomial.nb"
]

VerificationTest[
    algebraDefine["test"]
    ,
    Null
    ,
    TestID->"[2] operatorPolynomial.nb"
]

VerificationTest[
    algebraDefault["test"]
    ,
    Null
    ,
    TestID->"[3] operatorPolynomial.nb"
]

VerificationTest[
    algebraAdd["test"]["Generator" -> {x, y}]
    ,
    Null
    ,
    TestID->"[4] operatorPolynomial.nb"
]

VerificationTest[
    operatorPolynomial[x, a, 1]
    ,
    id
    ,
    TestID->"[5] operatorPolynomial.nb"
]

VerificationTest[
    operatorPolynomial[x, a, a]
    ,
    x
    ,
    TestID->"[6] operatorPolynomial.nb"
]

VerificationTest[
    operatorPolynomial[x, a, b]
    ,
    b*id
    ,
    TestID->"[7] operatorPolynomial.nb"
]

VerificationTest[
    operatorPolynomial[x, a, a + b]
    ,
    b*id + x
    ,
    TestID->"[8] operatorPolynomial.nb"
]

VerificationTest[
    operatorPolynomial[x, a, (a + 1)^4]
    ,
    id + 4*x + 6*x**x + 4*x**x**x + x**x**x**x
    ,
    TestID->"[9] operatorPolynomial.nb"
]

VerificationTest[
    operatorPolynomial[x, a, f[a]]
    ,
    operatorPolynomial[x, a, f[a]]
    ,
    TestID->"[10] operatorPolynomial.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    $algebraDefault
    ,
    {}
    ,
    TestID->"[11] operatorPolynomial.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] operatorPolynomial.nb"
]