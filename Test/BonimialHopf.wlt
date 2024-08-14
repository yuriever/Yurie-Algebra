

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
	algebraDefault[{"BinomialHopf", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
	,
	Null
	,
	TestID->"3-BonimialHopf.nb"
]

VerificationTest[
	eqs = operatorSeparate[Extract[{All, 2, 1}][(Map[checkAntipode[x[#1]] & ])[Range[5]]]]
	,
	{1 + a[1], 1 + 2*a[1] + a[2], 1 + 3*a[1] + 3*a[2] + a[3], 1 + 4*a[1] + 6*a[2] + 4*a[3] + a[4], 1 + 5*a[1] + 10*a[2] + 10*a[3] + 5*a[4] + a[5]}
	,
	TestID->"4-BonimialHopf.nb"
]

VerificationTest[
	(Solve[#1 == 0, Variables[#1]] & )[eqs]
	,
	{{a[1] -> -1, a[2] -> 1, a[3] -> -1, a[4] -> 1, a[5] -> -1}}
	,
	TestID->"5-BonimialHopf.nb"
]

VerificationTest[
	algebraUnset[]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"6-BonimialHopf.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Antipode", "Bialgebra", "Coalgebra", "Conjugate", "Tensor"}
	,
	TestID->"7-BonimialHopf.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"8-BonimialHopf.nb"
]

VerificationTest[
	On[General::shdw]
	,
	Null
	,
	TestID->"9-BonimialHopf.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-BonimialHopf.nb"
]