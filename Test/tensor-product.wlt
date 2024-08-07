

(*tensor-product.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-tensor-product.nb"
]

VerificationTest[
	Get["Yurie`Algebra`"]
	,
	Null
	,
	TestID->"1-tensor-product.nb"
]

VerificationTest[
	algebraDefine["test"]
	,
	Null
	,
	TestID->"2-tensor-product.nb"
]

VerificationTest[
	algebraAdd["test"][Association[operator -> {R, x}, relation -> {R[i_, j_, u_, v_]**tensor[x_, y_, z_] :> (I*Permute[tensor[x, y, z], Cycles[{{i, j}}]])/(I + u - v) + ((u - v)*tensor[x, y, z])/(I + u - v)}, printing -> {(op_)?generatorQ[i_] :> Subscript[op, i], R[i_, j_, u_, v_] :> Subscript[R, i, j]}]]
	,
	Null
	,
	TestID->"3-tensor-product.nb"
]

VerificationTest[
	tensorRankSet[R[___], 3]
	,
	Null
	,
	TestID->"4-tensor-product.nb"
]

VerificationTest[
	algebraDefault["test", "Tensor"]
	,
	Null
	,
	TestID->"5-tensor-product.nb"
]

VerificationTest[
	tensorRankEqualQ[tensor[id, x], tensor[x, x]]
	,
	True
	,
	TestID->"6-tensor-product.nb"
]

VerificationTest[
	(Map[#1 -> tensorRankGet[#1] & ])[{1, id, tensor[id], tensor[id, id], x, 2*x, tensor[2*x], tensor[id, x], 2*tensor[id, 2*x], R[], 2*R[], tensor[R[]], tensor[2*R[]], 2*tensor[2*R[], 2*x]}]
	,
	{1 -> 0, id -> 1, tensor[id] -> 1, tensor[id, id] -> 2, x -> 1, 2*x -> 1, tensor[2*x] -> 1, tensor[id, x] -> 2, 2*tensor[id, 2*x] -> 2, R[] -> 3, 2*R[] -> 3, tensor[R[]] -> 3, tensor[2*R[]] -> 3, 2*tensor[2*R[], 2*x] -> 4}
	,
	TestID->"7-tensor-product.nb"
]

VerificationTest[
	algS[tensorCompose[tensor[id, x]**tensor[x, id]]]
	,
	tensor[x, x]
	,
	TestID->"8-tensor-product.nb"
]

VerificationTest[
	expr = tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
	,
	tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
	,
	TestID->"9-tensor-product.nb"
]

VerificationTest[
	longexpr = operatorPower[expr, 2]
	,
	tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]**tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
	,
	TestID->"10-tensor-product.nb"
]

VerificationTest[
	algS[longexpr]
	,
	(1/(I + u - v)^2)*((u - v)^2*tensor[x[1]**x[1], x[2]**x[2], x[3]**x[3], x[4]**x[4]] + I*((u - v)*tensor[x[1]**x[1], x[2]**x[3], x[3]**x[2], x[4]**x[4]] + (u - v)*tensor[x[1]**x[1], x[3]**x[2], x[2]**x[3], x[4]**x[4]] + I*tensor[x[1]**x[1], x[3]**x[3], x[2]**x[2], x[4]**x[4]]))
	,
	TestID->"11-tensor-product.nb"
]

VerificationTest[
	operatorSeparate[algS[longexpr]]
	,
	{tensor[x[1]**x[1], x[2]**x[2], x[3]**x[3], x[4]**x[4]] -> (u - v)^2/(I + u - v)^2, tensor[x[1]**x[1], x[2]**x[3], x[3]**x[2], x[4]**x[4]] -> (I*u - I*v)/(I + u - v)^2, tensor[x[1]**x[1], x[3]**x[2], x[2]**x[3], x[4]**x[4]] -> (I*u - I*v)/(I + u - v)^2, tensor[x[1]**x[1], x[3]**x[3], x[2]**x[2], x[4]**x[4]] -> -(1/(I + u - v)^2)}
	,
	TestID->"12-tensor-product.nb"
]

VerificationTest[
	algebraUnset["test"]
	,
	Null
	,
	{Yurie`Cluster`cluster::rmdefault}
	,
	TestID->"13-tensor-product.nb"
]

VerificationTest[
	algebraDefine[]
	,
	{"Algebra", "Antipode", "Bialgebra", "Coalgebra", "Conjugate", "Tensor"}
	,
	TestID->"14-tensor-product.nb"
]

VerificationTest[
	algebraDefault[{}]; 
	algebraDefault[]
	,
	{}
	,
	TestID->"15-tensor-product.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-tensor-product.nb"
]