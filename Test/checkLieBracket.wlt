

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
	algebraDefine["test"]; 
	(algebraDefault["test"]; )
	,
	Null
	,
	TestID->"2-checkLieBracket.nb"
]

VerificationTest[
	algebraReset["test"]; 
	(algebraAdd["test"][Association[operator -> {x, y, z, xy, yz, xz}, relation -> {x**y -> xy, y**z -> yz, x**z -> xz}]]; )
	,
	Null
	,
	TestID->"3-checkLieBracket.nb"
]

VerificationTest[
	checkLieBracket[x, y, z]
	,
	{x, y, z} -> x**yz - xy**z
	,
	TestID->"4-checkLieBracket.nb"
]

VerificationTest[
	checkLieModule[x, y, z]
	,
	{x, y, z} -> -x**yz + xy**z
	,
	TestID->"5-checkLieBracket.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-checkLieBracket.nb"
]