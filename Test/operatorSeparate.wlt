

(*operatorSeparate.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-operatorSeparate.nb"
]

VerificationTest[
	Get["Yurie`Algebra`"]
	,
	Null
	,
	TestID->"1-operatorSeparate.nb"
]

VerificationTest[
	algebraDefine["test"]
	,
	Null
	,
	TestID->"2-operatorSeparate.nb"
]

VerificationTest[
	algebraDefault["test", "Tensor"]
	,
	Null
	,
	TestID->"3-operatorSeparate.nb"
]

VerificationTest[
	algebraReset["test"]; 
	algebraAdd["test"][Association[operator -> {x, y, z}]]
	,
	Null
	,
	TestID->"4-operatorSeparate.nb"
]

VerificationTest[
	SetOptions[operatorSeparate, "Operator" -> True]
	,
	{"Scalar" -> True, "Operator" -> True}
	,
	TestID->"5-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[1]
	,
	1
	,
	{Yurie`Algebra`operatorSeparate::notOperator}
	,
	TestID->"6-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[x]
	,
	{x -> 1}
	,
	TestID->"7-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[2*x]
	,
	{x -> 2}
	,
	TestID->"8-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[x**y]
	,
	{x**y -> 1}
	,
	TestID->"9-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[2*x**y]
	,
	{x**y -> 2}
	,
	TestID->"10-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[tensor[x, y]]
	,
	{tensor[x, y] -> 1}
	,
	TestID->"11-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[2*tensor[x, y]]
	,
	{tensor[x, y] -> 2}
	,
	TestID->"12-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[a[0]*x + a[1]*x**y]
	,
	{x -> a[0], x**y -> a[1]}
	,
	TestID->"13-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[a[0]*x + a[1]*x**y, "Operator" -> False]
	,
	{a[0], a[1]}
	,
	TestID->"14-operatorSeparate.nb"
]

VerificationTest[
	operatorSeparate[a[0]*x + a[1]*x**y, "Scalar" -> False]
	,
	{x, x**y}
	,
	TestID->"15-operatorSeparate.nb"
]

VerificationTest[
	SetOptions[operatorSeparate, "Operator" -> False]
	,
	{"Scalar" -> True, "Operator" -> False}
	,
	TestID->"16-operatorSeparate.nb"
]

VerificationTest[
	algebraUnset["test"]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"17-operatorSeparate.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
	,
	TestID->"18-operatorSeparate.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"19-operatorSeparate.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-operatorSeparate.nb"
]