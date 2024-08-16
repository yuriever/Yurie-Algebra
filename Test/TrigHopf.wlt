

(*TrigHopf.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-TrigHopf.nb"
]

VerificationTest[
	Off[General::shdw]
	,
	Null
	,
	TestID->"1-TrigHopf.nb"
]

VerificationTest[
	Get["Yurie`Algebra`TrigHopf`"]
	,
	Null
	,
	TestID->"2-TrigHopf.nb"
]

VerificationTest[
	algebraDefault[{"TrigHopf", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
	,
	Null
	,
	TestID->"3-TrigHopf.nb"
]

VerificationTest[
	(Map[checkCoassociativity])[operator[]]
	,
	{{id} -> 0, {c} -> 0, {s} -> 0}
	,
	TestID->"4-TrigHopf.nb"
]

VerificationTest[
	(Map[checkCounitality])[operator[]]
	,
	{{id} -> {0, 0}, {c} -> {0, 0}, {s} -> {0, 0}}
	,
	TestID->"5-TrigHopf.nb"
]

VerificationTest[
	(Map[checkAntipode])[operator[]]
	,
	{{id} -> {0, 0}, {c} -> {0, 0}, {s} -> {0, 0}}
	,
	TestID->"6-TrigHopf.nb"
]

VerificationTest[
	algebraUnset[]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"7-TrigHopf.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
	,
	TestID->"8-TrigHopf.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"9-TrigHopf.nb"
]

VerificationTest[
	On[General::shdw]
	,
	Null
	,
	TestID->"10-TrigHopf.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-TrigHopf.nb"
]