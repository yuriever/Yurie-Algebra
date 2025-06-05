

(*compose.nb*)

VerificationTest[
    Begin["Global`"];
	ClearAll["`*"]
    ,
    Null
    ,
    TestID->"0-compose.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"1-compose.nb"
]

VerificationTest[
    algebraDefine["test"]
    ,
    Null
    ,
    TestID->"2-compose.nb"
]

VerificationTest[
    algebraDefault["test"]
    ,
    Null
    ,
    TestID->"3-compose.nb"
]

VerificationTest[
    algebraAdd["test"][Association["Generator" -> {x[_], S[], R[___]}, "Rank" -> {S[] -> 2, R[___] -> 3}]]
    ,
    Null
    ,
    TestID->"4-compose.nb"
]

VerificationTest[
    padRight[opList_] := Flatten[Riffle[opList, (Map[ConstantArray[slot, tensorankUnsafe[#1] - 1] & ])[opList]]]; 
    ,
    Null
    ,
    TestID->"5-compose.nb"
]

VerificationTest[
    expr[0] = tensor[R[], id]**tensor[x[0], S[], x[0]]
    ,
    tensor[R[], id]**tensor[x[0], S[], x[0]]
    ,
    TestID->"6-compose.nb"
]

VerificationTest[
    padRight[(Apply[List])[expr[0][[1]]]]
    ,
    {R[], slot, slot, id}
    ,
    TestID->"7-compose.nb"
]

VerificationTest[
    expr[1] = Thread[padRight[List @@ expr[0][[1]]]**padRight[List @@ expr[0][[2]]]]
    ,
    {R[]**x[0], slot**S[], slot**slot, id**x[0]}
    ,
    TestID->"8-compose.nb"
]

VerificationTest[
    expr[2] = (Split[#1, MemberQ[#2, slot] & ] & )[expr[1]]
    ,
    {{R[]**x[0], slot**S[], slot**slot}, {id**x[0]}}
    ,
    TestID->"9-compose.nb"
]

VerificationTest[
    expr[3] = (Map[Thread[#1, NonCommutativeMultiply] & ])[expr[2]]
    ,
    {{R[], slot, slot}**{x[0], S[], slot}, {id}**{x[0]}}
    ,
    TestID->"10-compose.nb"
]

VerificationTest[
    expr[4] = (ReplaceAll[List -> tensor])[(ReplaceAll[{x1_} :> x1])[(ReplaceAll[slot -> Nothing])[expr[3]]]]
    ,
    tensor[R[]**tensor[x[0], S[]], id**x[0]]
    ,
    TestID->"11-compose.nb"
]

VerificationTest[
    algebraUnset["test"]
    ,
    Null
    ,
    {Yurie`Cluster`cluster::rmdefault}
    ,
    TestID->"12-compose.nb"
]

VerificationTest[
    algebraDefine[]
    ,
    {"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
    ,
    TestID->"13-compose.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    algebraDefault[]
    ,
    {}
    ,
    TestID->"14-compose.nb"
]

VerificationTest[
    ClearAll["`*"];
	End[]
    ,
    "Global`"
    ,
    TestID->"∞-compose.nb"
]