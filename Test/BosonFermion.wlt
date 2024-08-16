

(*BosonFermion.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-BosonFermion.nb"
]

VerificationTest[
	Off[General::shdw]
	,
	Null
	,
	TestID->"1-BosonFermion.nb"
]

VerificationTest[
	Get["Yurie`Algebra`BosonFermion`"]
	,
	Null
	,
	TestID->"2-BosonFermion.nb"
]

VerificationTest[
	algebraDefault[{"boson", "fermion", "boson-fermion", "vacuum", "boson-vacuum", "fermion-vacuum", "Conjugate"}]
	,
	Null
	,
	TestID->"3-BosonFermion.nb"
]

VerificationTest[
	expr = (boson[1, an] + boson[1, cr] + boson[2, an])**boson[1, cr]**(fermion[1, cr] + boson[2, an]**fermion[1, an])**boson[2, cr]; 
	,
	Null
	,
	TestID->"4-BosonFermion.nb"
]

VerificationTest[
	algP[expr]
	,
	(Subscript["a", 1] + Subscript["a", 2] + Subscript[SuperDagger["a"], 1])**Subscript[SuperDagger["a"], 1]**(Subscript["a", 2]**Subscript["b", 1] + Subscript[SuperDagger["b"], 1])**Subscript[SuperDagger["a"], 2]
	,
	TestID->"5-BosonFermion.nb"
]

VerificationTest[
	algSP[expr**vacuum]
	,
	Subscript[SuperDagger["b"], 1]**Subscript[SuperDagger["a"], 1]**vacuum + Subscript[SuperDagger["b"], 1]**Subscript[SuperDagger["a"], 2]**vacuum + Subscript[SuperDagger["b"], 1]**Subscript[SuperDagger["a"], 2]**Subscript[SuperDagger["a"], 1]**Subscript[SuperDagger["a"], 1]**vacuum
	,
	TestID->"6-BosonFermion.nb"
]

VerificationTest[
	H[k_] := boson[k, cr]**boson[k, an]*f[k] + fermion[k, cr]**fermion[k, an]*g[k]; 
	,
	Null
	,
	TestID->"7-BosonFermion.nb"
]

VerificationTest[
	Hsum[expr_] := Module[{k}, Sum[H[k]**expr, {k, -2, 2}]]; 
	,
	Null
	,
	TestID->"8-BosonFermion.nb"
]

VerificationTest[
	algSP[Hsum[expr**vacuum]]
	,
	(f[1] + g[1])*Subscript[SuperDagger["b"], 1]**Subscript[SuperDagger["a"], 1]**vacuum + (f[2] + g[1])*Subscript[SuperDagger["b"], 1]**Subscript[SuperDagger["a"], 2]**vacuum + (2*f[1] + f[2] + g[1])*Subscript[SuperDagger["b"], 1]**Subscript[SuperDagger["a"], 2]**Subscript[SuperDagger["a"], 1]**Subscript[SuperDagger["a"], 1]**vacuum
	,
	TestID->"9-BosonFermion.nb"
]

VerificationTest[
	algS[innerProduct[expr**vacuum]]
	,
	4
	,
	TestID->"10-BosonFermion.nb"
]

VerificationTest[
	algebraUnset[]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"11-BosonFermion.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
	,
	TestID->"12-BosonFermion.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"13-BosonFermion.nb"
]

VerificationTest[
	On[General::shdw]
	,
	Null
	,
	TestID->"14-BosonFermion.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-BosonFermion.nb"
]