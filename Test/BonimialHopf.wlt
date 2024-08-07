

(*BonimialHopf.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-BonimialHopf.nb"
]

VerificationTest[
	Off[General::shdw]
	,
	Null
	,
	TestID->"1-BonimialHopf.nb"
]

VerificationTest[
	Get["Yurie`Algebra`BinomialHopf`"]
	,
	Null
	,
	TestID->"2-BonimialHopf.nb"
]

VerificationTest[
	algebraUnset[]
	,
	Null
	,
	TestID->"3-BonimialHopf.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Antipode", "Bialgebra", "Coalgebra", "Conjugate", "Tensor"}
	,
	TestID->"4-BonimialHopf.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"5-BonimialHopf.nb"
]

VerificationTest[
	On[General::shdw]
	,
	Null
	,
	TestID->"6-BonimialHopf.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-BonimialHopf.nb"
]