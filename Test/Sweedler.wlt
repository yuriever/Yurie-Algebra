

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
	algSP[comultiply[g**x**g]]
	,
	-(g ⊗ x) - x ⊗ 1
	,
	TestID->"4-Sweedler.nb"
]

VerificationTest[
	algebraUnset[]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"5-Sweedler.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Antipode", "Bialgebra", "Coalgebra", "Conjugate", "Tensor"}
	,
	TestID->"6-Sweedler.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"7-Sweedler.nb"
]

VerificationTest[
	On[General::shdw]
	,
	Null
	,
	TestID->"8-Sweedler.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-Sweedler.nb"
]