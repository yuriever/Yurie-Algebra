

(*commDefine.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"init-commDefine.nb"
]

VerificationTest[
	Get["Yurie`Algebra`"]
	,
	Null
	,
	TestID->1
]

VerificationTest[
	commDefine[x_Symbol, (y_)?IntegerQ] :> z /; x > y
	,
	(x_Symbol)**(y_)?IntegerQ :> z + y**x /; x > y
	,
	TestID->2
]

VerificationTest[
	commDefine[x_, y_, Normal, 0] :> z
	,
	(x_)**(y_) :> z + y**x
	,
	TestID->3
]

VerificationTest[
	commDefine[x_, y_, Normal, 1] :> z
	,
	(x_)**(y_) :> z - y**x
	,
	TestID->4
]

VerificationTest[
	commDefine[x_, y_, Reverse, 0] :> z
	,
	(y_)**(x_) :> -z + x**y
	,
	TestID->5
]

VerificationTest[
	commDefine[x_, y_, Reverse, 1] :> z
	,
	(y_)**(x_) :> z - x**y
	,
	TestID->6
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"cleanup-commDefine.nb"
]