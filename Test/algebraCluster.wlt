

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
	algebraAdd["alg"][operator -> {x, y}]; 
	,
	Null
	,
	{Yurie`Cluster`cluster::starundef}
	,
	TestID->"2-algebraCluster.nb"
]

VerificationTest[
	algebraReset["alg"]; 
	,
	Null
	,
	{Yurie`Cluster`cluster::starundef}
	,
	TestID->"3-algebraCluster.nb"
]

VerificationTest[
	algebraUnset["alg"]; 
	,
	Null
	,
	{Yurie`Cluster`cluster::starundef}
	,
	TestID->"4-algebraCluster.nb"
]

VerificationTest[
	algebraDefine[{"alg1", "alg2"}]; 
	algebraCluster["StarList"]
	,
	{"Comultiplication", "Conjugate", "Multiplication", "TensorProduct", "alg1", "alg2"}
	,
	TestID->"5-algebraCluster.nb"
]

VerificationTest[
	algebraAdd["alg1"][{operator -> {x}}]; 
	algebraAdd[{"alg1", "alg2"}][Association[operator -> {y, z}, printing -> {y -> 1}]]; 
	algebraDefault[{"alg1", "alg2"}]; 
	algebraCluster["StarDefaultData"][operator]
	,
	{x, y, z}
	,
	TestID->"6-algebraCluster.nb"
]

VerificationTest[
	algebraReset["alg1"]; 
	algebraCluster["StarDefaultData"][operator]
	,
	{y, z}
	,
	TestID->"7-algebraCluster.nb"
]

VerificationTest[
	algebraUnset["alg1"]; 
	algebraCluster["StarDefaultData"][operator]
	,
	{y, z}
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"8-algebraCluster.nb"
]

VerificationTest[
	algebraUnset["alg2"]; 
	algebraCluster["StarDefaultData"][operator]
	,
	{}
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"9-algebraCluster.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Comultiplication", "Conjugate", "Multiplication", "TensorProduct"}
	,
	TestID->"10-algebraCluster.nb"
]

VerificationTest[
	algebraDefault[]
	,
	{}
	,
	TestID->"11-algebraCluster.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-algebraCluster.nb"
]