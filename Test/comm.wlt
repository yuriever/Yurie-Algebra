

(* comm.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] comm.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"[1] comm.nb"
]

VerificationTest[
    comm[x, y]
    ,
    x**y - y**x
    ,
    TestID->"[2] comm.nb"
]

VerificationTest[
    comm[x, y, 1]
    ,
    x**y + y**x
    ,
    TestID->"[3] comm.nb"
]

VerificationTest[
    comm[{x, y, z}]
    ,
    x**(y**z - z**y) - (y**z - z**y)**x
    ,
    TestID->"[4] comm.nb"
]

VerificationTest[
    comm[{x, y, z}, 1]
    ,
    x**(y**z + z**y) + (y**z + z**y)**x
    ,
    TestID->"[5] comm.nb"
]

VerificationTest[
    commIn[x, y] -> z /; x > y
    ,
    x**y -> z + y**x /; x > y
    ,
    TestID->"[6] comm.nb"
]

VerificationTest[
    commIn[x_Symbol, (y_)?IntegerQ] :> z /; x > y
    ,
    (x_Symbol)**(y_)?IntegerQ :> z + y**x /; x > y
    ,
    TestID->"[7] comm.nb"
]

VerificationTest[
    commIn[x, y, Normal, 0] -> z
    ,
    x**y -> z + y**x
    ,
    TestID->"[8] comm.nb"
]

VerificationTest[
    commIn[x_, y_, Normal, 0] :> z
    ,
    (x_)**(y_) :> z + y**x
    ,
    TestID->"[9] comm.nb"
]

VerificationTest[
    commIn[x, y, Normal, 1] -> z
    ,
    x**y -> z - y**x
    ,
    TestID->"[10] comm.nb"
]

VerificationTest[
    commIn[x_, y_, Normal, 1] :> z
    ,
    (x_)**(y_) :> z - y**x
    ,
    TestID->"[11] comm.nb"
]

VerificationTest[
    commIn[x, y, Reverse, 0] -> z
    ,
    y**x -> -z + x**y
    ,
    TestID->"[12] comm.nb"
]

VerificationTest[
    commIn[x_, y_, Reverse, 0] :> z
    ,
    (y_)**(x_) :> -z + x**y
    ,
    TestID->"[13] comm.nb"
]

VerificationTest[
    commIn[x, y, Reverse, 1] -> z
    ,
    y**x -> z - x**y
    ,
    TestID->"[14] comm.nb"
]

VerificationTest[
    commIn[x_, y_, Reverse, 1] :> z
    ,
    (y_)**(x_) :> z - x**y
    ,
    TestID->"[15] comm.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] comm.nb"
]