

(*checkLieBracket.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-checkLieBracket.nb"
]

VerificationTest[
	Get["Yurie`Algebra`"]
	,
	Null
	,
	TestID->"1-checkLieBracket.nb"
]

VerificationTest[
	algebraDefine["test"]
	,
	Null
	,
	TestID->"2-checkLieBracket.nb"
]

VerificationTest[
	algebraDefault["test"]
	,
	Null
	,
	TestID->"3-checkLieBracket.nb"
]

VerificationTest[
	algebraAdd["test"][Association["Generator" -> {x, y, z, xy, yz, xz}, "Relation" -> {x**y -> xy, y**z -> yz, x**z -> xz}]]
	,
	Null
	,
	TestID->"4-checkLieBracket.nb"
]

VerificationTest[
	checkLieBracket[x, y, z]
	,
	{x, y, z} -> x**yz - xy**z
	,
	TestID->"5-checkLieBracket.nb"
]

VerificationTest[
	checkLieModule[x, y, z]
	,
	{x, y, z} -> -x**yz + xy**z
	,
	TestID->"6-checkLieBracket.nb"
]

VerificationTest[
	algebraUnset["test"]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"7-checkLieBracket.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
	,
	TestID->"8-checkLieBracket.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"9-checkLieBracket.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-checkLieBracket.nb"
]