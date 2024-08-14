

(*antipode-rigidity.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-antipode-rigidity.nb"
]

VerificationTest[
	Get["Yurie`Algebra`"]
	,
	Null
	,
	TestID->"1-antipode-rigidity.nb"
]

VerificationTest[
	algebraDefine["test"]
	,
	Null
	,
	TestID->"2-antipode-rigidity.nb"
]

VerificationTest[
	algebraDefault[{"test", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
	,
	Null
	,
	TestID->"3-antipode-rigidity.nb"
]

VerificationTest[
	algebraAdd["test"][Association[operator -> {g, x}, relation -> {commDefine[g, x, Reverse, 1] -> 0, x**x :> 0, g**g :> id, comultiply[g] :> tensor[g, g], comultiply[x] :> tensor[g, x] + c[1]*tensor[x, id], counit[g] :> 1, counit[x] :> 0, antipode[g] :> a[1]*g + a[2]*x + a[3]*g**x + a[4]*id, antipode[x] :> b[1]*g + b[2]*x + b[3]*g**x + b[4]*id}, printing -> {}]]; 
	,
	Null
	,
	TestID->"4-antipode-rigidity.nb"
]

VerificationTest[
	eqs1 = Extract[{All, 2}][operatorSeparate[Extract[{All, 2}][(Map[checkCoassociativity])[{x, g, g**x}]]]]
	,
	{(-1 + c[1])*c[1], (-1 + c[1])*c[1]}
	,
	TestID->"5-antipode-rigidity.nb"
]

VerificationTest[
	sol1 = Solve[eqs1 == 0, Variables[eqs1]]
	,
	{{c[1] -> 0}, {c[1] -> 1}}
	,
	TestID->"6-antipode-rigidity.nb"
]

VerificationTest[
	eqs2 = (ReplaceAll[sol1])[Extract[{All, 2}][operatorSeparate[Extract[{All, 2}][(Map[checkAntipode])[{x, g}]]]]]
	,
	{{a[4], 0, 0, a[1], b[1], b[3], b[4], b[2], -1 + a[1], -a[3], a[4], -a[2], -1 + a[1], a[3], a[4], a[2]}, {a[4] + b[2], b[1], b[4], a[1] + b[3], b[1], 1 + b[3], b[4], b[2], -1 + a[1], -a[3], a[4], -a[2], -1 + a[1], a[3], a[4], a[2]}}
	,
	TestID->"7-antipode-rigidity.nb"
]

VerificationTest[
	Solve[eqs2[[1]] == 0, Variables[eqs2]]
	,
	{}
	,
	TestID->"8-antipode-rigidity.nb"
]

VerificationTest[
	sol2 = Solve[eqs2[[2]] == 0, Variables[eqs2]]
	,
	{{a[1] -> 1, a[2] -> 0, a[3] -> 0, a[4] -> 0, b[1] -> 0, b[2] -> 0, b[3] -> -1, b[4] -> 0}}
	,
	TestID->"9-antipode-rigidity.nb"
]

VerificationTest[
	(ReplaceAll[sol2])[(ReplaceAll[sol1[[2]]])[algS[{comultiply[x], antipode[g], antipode[x]}]]]
	,
	{{tensor[g, x] + tensor[x, id], g, -g**x}}
	,
	TestID->"10-antipode-rigidity.nb"
]

VerificationTest[
	algebraUnset["test"]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"11-antipode-rigidity.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Antipode", "Bialgebra", "Coalgebra", "Conjugate", "Tensor"}
	,
	TestID->"12-antipode-rigidity.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"13-antipode-rigidity.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-antipode-rigidity.nb"
]