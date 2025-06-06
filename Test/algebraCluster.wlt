

(*algebraCluster.nb*)

VerificationTest[
    Begin["Global`"];
	ClearAll["`*"]
    ,
    Null
    ,
    TestID->"0-algebraCluster.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"1-algebraCluster.nb"
]

VerificationTest[
    algebraAdd["alg"]["Generator" -> {x, y}]
    ,
    Null
    ,
    {Yurie`Cluster`cluster::starundef}
    ,
    TestID->"2-algebraCluster.nb"
]

VerificationTest[
    algebraReset["alg"]
    ,
    Null
    ,
    {Yurie`Cluster`cluster::starundef}
    ,
    TestID->"3-algebraCluster.nb"
]

VerificationTest[
    algebraUnset["alg"]
    ,
    Null
    ,
    {Yurie`Cluster`cluster::starundef}
    ,
    TestID->"4-algebraCluster.nb"
]

VerificationTest[
    algebraDefine["alg1", "alg2"]; 
    algebraDefine[]
    ,
    {"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode", "alg1", "alg2"}
    ,
    TestID->"5-algebraCluster.nb"
]

VerificationTest[
    algebraDefault[{"alg1", "alg2"}]; 
    algebraDefault[]
    ,
    {"alg1", "alg2"}
    ,
    TestID->"6-algebraCluster.nb"
]

VerificationTest[
    algebraAdd["alg1"]["Generator" -> {w, z}]; 
    algebraAdd["alg1", "alg2"]["Generator" -> {y, x}]; 
    generator[]
    ,
    {id, w, z, y, x}
    ,
    TestID->"7-algebraCluster.nb"
]

VerificationTest[
    algebraMinus["alg1", "alg2"]["Generator" -> {z}]; 
    generator[]
    ,
    {id, w, y, x}
    ,
    TestID->"8-algebraCluster.nb"
]

VerificationTest[
    algebraAdd["alg1", "alg2"]["Relation" -> {w -> 1, z -> 1, y -> 1 /; x}]; 
    relation["alg1"]
    ,
    {w -> 1, z -> 1, y -> 1 /; x}
    ,
    TestID->"9-algebraCluster.nb"
]

VerificationTest[
    algebraMinus["alg1", "alg2"]["Relation" -> {y -> 1 /; x}]; 
    relation["alg1"]
    ,
    {w -> 1, z -> 1}
    ,
    TestID->"10-algebraCluster.nb"
]

VerificationTest[
    algebraAdd["alg1", "alg2"]["Printing" -> {x -> 1}]; 
    printing[]
    ,
    {id -> 1, x -> 1}
    ,
    TestID->"11-algebraCluster.nb"
]

VerificationTest[
    algebraAdd["alg1", "alg2"]["Rank" -> {x -> 2}]; 
    tensorankUnsafe[x]
    ,
    2
    ,
    TestID->"12-algebraCluster.nb"
]

VerificationTest[
    algebraAdd["alg1", "alg2"]["Parity" -> {x -> 0}]; 
    parity[x]
    ,
    Null
    ,
    TestID->"13-algebraCluster.nb"
]

VerificationTest[
    algebraReset["alg1"]; 
    generator[]
    ,
    {id, y, x}
    ,
    TestID->"14-algebraCluster.nb"
]

VerificationTest[
    algebraUnset["alg1"]; 
    generator[]
    ,
    Quiet[{id, y, x}]
    ,
    {Yurie`Cluster`cluster::rmdefault}
    ,
    TestID->"15-algebraCluster.nb"
]

VerificationTest[
    algebraUnset["alg2"]; 
    generator[]
    ,
    Quiet[{id}]
    ,
    {Yurie`Cluster`cluster::rmdefault}
    ,
    TestID->"16-algebraCluster.nb"
]

VerificationTest[
    algebraUnset[]
    ,
    Null
    ,
    TestID->"17-algebraCluster.nb"
]

VerificationTest[
    algebraDefine[]
    ,
    {"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
    ,
    TestID->"18-algebraCluster.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    algebraDefault[]
    ,
    {}
    ,
    TestID->"19-algebraCluster.nb"
]

VerificationTest[
    ClearAll["`*"];
	End[]
    ,
    "Global`"
    ,
    TestID->"∞-algebraCluster.nb"
]