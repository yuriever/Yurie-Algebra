

(*algebraCluster-edge-case.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-algebraCluster-edge-case.nb"
]

VerificationTest[
	Get["Yurie`Algebra`"]
	,
	Null
	,
	TestID->"1-algebraCluster-edge-case.nb"
]

VerificationTest[
	algebraDefine[{}]; 
	algebraDefine[]
	,
	{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
	,
	TestID->"2-algebraCluster-edge-case.nb"
]

VerificationTest[
	algebraAdd[{}][{operator -> {x}}]; 
	algebraDefault[{}]; 
	operator[]
	,
	{id}
	,
	TestID->"3-algebraCluster-edge-case.nb"
]

VerificationTest[
	algebraReset[{}]; 
	operator[]
	,
	{id}
	,
	TestID->"4-algebraCluster-edge-case.nb"
]

VerificationTest[
	algebraUnset[{}]; 
	operator[]
	,
	{id}
	,
	TestID->"5-algebraCluster-edge-case.nb"
]

VerificationTest[
	algebraUnset[]
	,
	Null
	,
	TestID->"6-algebraCluster-edge-case.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
	,
	TestID->"7-algebraCluster-edge-case.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"8-algebraCluster-edge-case.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-algebraCluster-edge-case.nb"
]