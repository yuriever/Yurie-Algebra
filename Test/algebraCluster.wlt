

(*algebraCluster.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"init-algebraCluster.nb"
]

VerificationTest[
	Get["Yurie`Algebra`"]
	,
	Null
	,
	TestID->1
]

VerificationTest[
	algebraAdd["alg"][operator -> {x, y}]; 
	,
	Null
	,
	{Yurie`Cluster`cluster::starundef}
	,
	TestID->2
]

VerificationTest[
	algebraReset["alg"]; 
	,
	Null
	,
	{Yurie`Cluster`cluster::starundef}
	,
	TestID->3
]

VerificationTest[
	algebraUnset["alg"]; 
	,
	Null
	,
	{Yurie`Cluster`cluster::starundef}
	,
	TestID->4
]

VerificationTest[
	algebraDefine[{"alg1", "alg2"}]; 
	algebraCluster["starList"]
	,
	{"comultiplication", "conjugate", "multiplication", "tensor-product", "alg1", "alg2"}
	,
	TestID->5
]

VerificationTest[
	algebraAdd["alg1"][{operator -> {x}}]; 
	algebraAdd[{"alg1", "alg2"}][Association[operator -> {y, z}, printing -> {y -> 1}]]; 
	algebraDefault[{"alg1", "alg2"}]; 
	algebraCluster["starDefaultData"][operator]
	,
	{x, y, z}
	,
	TestID->6
]

VerificationTest[
	algebraReset["alg1"]; 
	algebraCluster["starDefaultData"][operator]
	,
	{y, z}
	,
	TestID->7
]

VerificationTest[
	algebraUnset["alg1"]; 
	algebraCluster["starDefaultData"][operator]
	,
	{y, z}
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->8
]

VerificationTest[
	algebraUnset["alg2"]; 
	algebraCluster["starDefaultData"][operator]
	,
	{}
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->9
]

VerificationTest[
	algebraDefine[]
	,
	{"comultiplication", "conjugate", "multiplication", "tensor-product"}
	,
	TestID->10
]

VerificationTest[
	algebraDefault[]
	,
	{}
	,
	TestID->11
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"cleanup-algebraCluster.nb"
]