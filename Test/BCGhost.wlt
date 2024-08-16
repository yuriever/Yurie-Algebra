

(*BCGhost.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-BCGhost.nb"
]

VerificationTest[
	Off[General::shdw]
	,
	Null
	,
	TestID->"1-BCGhost.nb"
]

VerificationTest[
	Get["Yurie`Algebra`BCGhost`"]
	,
	Null
	,
	TestID->"2-BCGhost.nb"
]

VerificationTest[
	genL[h_, m_] := Sum[(m - n)*normOrder[ghostB[h, m + n]**ghostC[h, -n]], {n, Range[-max, max]}]; 
	,
	Null
	,
	TestID->"3-BCGhost.nb"
]

VerificationTest[
	genSL2[h_] := (genL[h, #1] & ) /@ {-1, 0, 1}; 
	,
	Null
	,
	TestID->"4-BCGhost.nb"
]

VerificationTest[
	ghostNumber[h_] := Sum[ghostC[h, -n]**ghostB[h, n] - ghostB[h, -n]**ghostC[h, n], {n, Range[1, max]}] + ghostC[h, 0]**ghostB[h, 0] - 1/2; 
	,
	Null
	,
	TestID->"5-BCGhost.nb"
]

VerificationTest[
	normOrder[ghostB[h_, n_]**ghostC[h_, m_]] := -ghostC[h, m]**ghostB[h, n] /; n >= 1 - h; 
	(normOrder[ghostB[h_, n_]**ghostC[h_, m_]] := ghostB[h, n]**ghostC[h, m] /; n < 1 - h; )
	,
	Null
	,
	TestID->"6-BCGhost.nb"
]

VerificationTest[
	algebraDefault[{"bc", "bc-vacuum", "Conjugate"}]
	,
	Null
	,
	TestID->"7-BCGhost.nb"
]

VerificationTest[
	h0 = 2; 
	(max = 10; )
	,
	Null
	,
	TestID->"8-BCGhost.nb"
]

VerificationTest[
	algS[Table[op**vacuum, {op, genSL2[h0]}]]
	,
	{0, 0, 0}
	,
	TestID->"9-BCGhost.nb"
]

VerificationTest[
	algSP[Table[op**ghostC[2, -1]**vacuum, {op, genSL2[h0]}]]
	,
	{3*Subscript["c", -2]**vacuum, Subscript["c", -1]**vacuum, -Subscript["c", 0]**vacuum}
	,
	TestID->"10-BCGhost.nb"
]

VerificationTest[
	algSP[Table[op**ghostC[2, 1]**vacuum, {op, genSL2[h0]}]]
	,
	{Subscript["c", 0]**vacuum, -Subscript["c", 1]**vacuum, 0}
	,
	TestID->"11-BCGhost.nb"
]

VerificationTest[
	algS[genL[h0, 1]**ghostC[h0, -1]**vacuum + genL[h0, -1]**ghostC[h0, 1]**vacuum]
	,
	0
	,
	TestID->"12-BCGhost.nb"
]

VerificationTest[
	algebraUnset[]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"13-BCGhost.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
	,
	TestID->"14-BCGhost.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"15-BCGhost.nb"
]

VerificationTest[
	On[General::shdw]
	,
	Null
	,
	TestID->"16-BCGhost.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-BCGhost.nb"
]