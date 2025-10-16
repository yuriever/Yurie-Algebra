

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
    commIn[x, y] -> z /; condition
    ,
    x**y -> z + y**x /; condition
    ,
    TestID->"[6] comm.nb"
]

VerificationTest[
    commIn[x_Symbol, (y_)?IntegerQ] :> z /; x > y
    ,
    (x_Symbol)**(y_)?IntegerQ :> y**x + z /; x > y
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
    (x_)**(y_) :> y**x + z
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
    (x_)**(y_) :> -y**x + z
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
    (y_)**(x_) :> x**y - z
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
    (y_)**(x_) :> -x**y + 1*z
    ,
    TestID->"[15] comm.nb"
]

VerificationTest[
    a = 1; 
    ,
    Null
    ,
    TestID->"[16] comm.nb"
]

VerificationTest[
    commIn[x, y] -> a
    ,
    x**y -> 1 + y**x
    ,
    TestID->"[17] comm.nb"
]

VerificationTest[
    commIn[x, y] -> a /; condition
    ,
    x**y -> 1 + y**x /; condition
    ,
    TestID->"[18] comm.nb"
]

VerificationTest[
    commIn[x_, y_] :> a
    ,
    (x_)**(y_) :> y**x + a
    ,
    TestID->"[19] comm.nb"
]

VerificationTest[
    commIn[x_, y_] :> a /; x > y
    ,
    (x_)**(y_) :> y**x + a /; x > y
    ,
    TestID->"[20] comm.nb"
]

VerificationTest[
    a =. 
    ,
    Null
    ,
    TestID->"[21] comm.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] comm.nb"
]