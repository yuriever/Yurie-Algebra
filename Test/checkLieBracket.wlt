

(*checkLieBracket.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"init-checkLieBracket.nb"
]

VerificationTest[
	Get["Yurie`Algebra`"]
	,
	Null
	,
	TestID->1
]

VerificationTest[
	algebraDefine["test"]; 
	(algebraDefault["test"]; )
	,
	Null
	,
	TestID->2
]

VerificationTest[
	algebraReset["test"]; 
	(algebraAdd["test"][Association[operator -> {x, y, z, xy, yz, xz}, relation -> {x**y -> xy, y**z -> yz, x**z -> xz}]]; )
	,
	Null
	,
	TestID->3
]

VerificationTest[
	checkLieBracket[x, y, z]
	,
	{x, y, z} -> x**yz - xy**z
	,
	TestID->4
]

VerificationTest[
	checkLieModule[x, y, z]
	,
	{x, y, z} -> -x**yz + xy**z
	,
	TestID->5
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"cleanup-checkLieBracket.nb"
]