

(*Sweedler.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-Sweedler.nb"
]

VerificationTest[
	Off[General::shdw]
	,
	Null
	,
	TestID->"1-Sweedler.nb"
]

VerificationTest[
	Get["Yurie`Algebra`Sweedler`"]
	,
	Null
	,
	TestID->"2-Sweedler.nb"
]

VerificationTest[
	algebraDefault[{"Sweedler", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
	,
	Null
	,
	TestID->"3-Sweedler.nb"
]

VerificationTest[
	(Map[checkCoassociativity])[generator[]]
	,
	{{id} -> 0, {g} -> 0, {x} -> 0}
	,
	TestID->"4-Sweedler.nb"
]

VerificationTest[
	(Map[checkCounitality])[generator[]]
	,
	{{id} -> {0, 0}, {g} -> {0, 0}, {x} -> {0, 0}}
	,
	TestID->"5-Sweedler.nb"
]

VerificationTest[
	(Map[checkAntipode])[generator[]]
	,
	{{id} -> {0, 0}, {g} -> {0, 0}, {x} -> {0, 0}}
	,
	TestID->"6-Sweedler.nb"
]

VerificationTest[
	algebraUnset[]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"7-Sweedler.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
	,
	TestID->"8-Sweedler.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"9-Sweedler.nb"
]

VerificationTest[
	On[General::shdw]
	,
	Null
	,
	TestID->"10-Sweedler.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-Sweedler.nb"
]