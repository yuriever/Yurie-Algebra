

(* commDefine.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] commDefine.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"[1] commDefine.nb"
]

VerificationTest[
    commDefine[x, y] -> z /; x > y
    ,
    x**y -> z + y**x /; x > y
    ,
    TestID->"[2] commDefine.nb"
]

VerificationTest[
    commDefine[x_Symbol, (y_)?IntegerQ] :> z /; x > y
    ,
    (x_Symbol)**(y_)?IntegerQ :> z + y**x /; x > y
    ,
    TestID->"[3] commDefine.nb"
]

VerificationTest[
    commDefine[x, y, Normal, 0] -> z
    ,
    x**y -> z + y**x
    ,
    TestID->"[4] commDefine.nb"
]

VerificationTest[
    commDefine[x_, y_, Normal, 0] :> z
    ,
    (x_)**(y_) :> z + y**x
    ,
    TestID->"[5] commDefine.nb"
]

VerificationTest[
    commDefine[x, y, Normal, 1] -> z
    ,
    x**y -> z - y**x
    ,
    TestID->"[6] commDefine.nb"
]

VerificationTest[
    commDefine[x_, y_, Normal, 1] :> z
    ,
    (x_)**(y_) :> z - y**x
    ,
    TestID->"[7] commDefine.nb"
]

VerificationTest[
    commDefine[x, y, Reverse, 0] -> z
    ,
    y**x -> -z + x**y
    ,
    TestID->"[8] commDefine.nb"
]

VerificationTest[
    commDefine[x_, y_, Reverse, 0] :> z
    ,
    (y_)**(x_) :> -z + x**y
    ,
    TestID->"[9] commDefine.nb"
]

VerificationTest[
    commDefine[x, y, Reverse, 1] -> z
    ,
    y**x -> z - x**y
    ,
    TestID->"[10] commDefine.nb"
]

VerificationTest[
    commDefine[x_, y_, Reverse, 1] :> z
    ,
    (y_)**(x_) :> z - x**y
    ,
    TestID->"[11] commDefine.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] commDefine.nb"
]