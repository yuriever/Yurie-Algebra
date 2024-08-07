

(*SL2.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-SL2.nb"
]

VerificationTest[
	Off[General::shdw]
	,
	Null
	,
	TestID->"1-SL2.nb"
]

VerificationTest[
	Get["Yurie`Algebra`SL2`"]
	,
	Null
	,
	TestID->"2-SL2.nb"
]

VerificationTest[
	algebraDefault[{"SL2", "Verma-module"}]
	,
	Null
	,
	TestID->"3-SL2.nb"
]

VerificationTest[
	algS[Table[h**v[Δ, n] + (2*n - Δ)*v[Δ, n], {n, Range[5]}]]
	,
	{0, 0, 0, 0, 0}
	,
	TestID->"4-SL2.nb"
]

VerificationTest[
	algS[Table[x**v[Δ, n] - n*(Δ - n + 1)*v[Δ, n - 1], {n, Range[5]}]]
	,
	{0, 0, 0, 0, 0}
	,
	TestID->"5-SL2.nb"
]

VerificationTest[
	casimir = h**h + 2*h + 4*y**x; 
	,
	Null
	,
	TestID->"6-SL2.nb"
]

VerificationTest[
	algS[Table[casimir**v[Δ, n] - Δ*(Δ + 2)*v[Δ, n], {n, Range[5]}]]
	,
	{0, 0, 0, 0, 0}
	,
	TestID->"7-SL2.nb"
]

VerificationTest[
	algebraDefault[{"SL2", "Verma-module-extension"}]; 
	,
	Null
	,
	TestID->"8-SL2.nb"
]

VerificationTest[
	Δ0 = 4; 
	,
	Null
	,
	TestID->"9-SL2.nb"
]

VerificationTest[
	Table[checkLieModule[gen1, gen2, v[2, Δ0, 2]], {gen1, operator["SL2"]}, {gen2, operator["SL2"]}]
	,
	{{{x, x, v[2, 4, 2]} -> 0, {x, y, v[2, 4, 2]} -> 0, {x, h, v[2, 4, 2]} -> 0}, {{y, x, v[2, 4, 2]} -> 0, {y, y, v[2, 4, 2]} -> 0, {y, h, v[2, 4, 2]} -> 0}, {{h, x, v[2, 4, 2]} -> 0, {h, y, v[2, 4, 2]} -> 0, {h, h, v[2, 4, 2]} -> 0}}
	,
	TestID->"10-SL2.nb"
]

VerificationTest[
	algS[Table[h**v[2, Δ0, n] + (2 + 2*n + Δ0)*v[2, Δ0, n], {n, Range[5]}]]
	,
	{0, 0, 0, 0, 0}
	,
	TestID->"11-SL2.nb"
]

VerificationTest[
	algS[Table[x**v[2, Δ0, n] - (a*v[1, Δ0, n + Δ0] - (n*(1 + Δ0 + n))*v[2, Δ0, n - 1]), {n, Range[1, 5]}]]
	,
	{0, 0, 0, 0, 0}
	,
	TestID->"12-SL2.nb"
]

VerificationTest[
	algS[Table[casimir**v[2, Δ0, n] - Δ0*(Δ0 + 2)*v[2, Δ0, n] - 4*a*v[1, Δ0, n + Δ0 + 1], {n, Range[5]}]]
	,
	{0, 0, 0, 0, 0}
	,
	TestID->"13-SL2.nb"
]

VerificationTest[
	algebraUnset[]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"14-SL2.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Antipode", "Bialgebra", "Coalgebra", "Conjugate", "Tensor"}
	,
	TestID->"15-SL2.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"16-SL2.nb"
]

VerificationTest[
	On[General::shdw]
	,
	Null
	,
	TestID->"17-SL2.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-SL2.nb"
]