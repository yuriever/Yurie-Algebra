

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
	algebraDefine["YBE"]
	,
	Null
	,
	TestID->"2-tensor-product.nb"
]

VerificationTest[
	algebraDefault["YBE", "Tensor"]
	,
	Null
	,
	TestID->"3-tensor-product.nb"
]

VerificationTest[
	algebraAdd["YBE"][Association[operator -> {R, x}, relation -> {R[i_, j_, u_, v_]**tensor[x_, y_, z_] :> (I*Permute[tensor[x, y, z], Cycles[{{i, j}}]])/(I + u - v) + ((u - v)*tensor[x, y, z])/(I + u - v)}, printing -> {(op_)?generatorQ[i_] :> Subscript[op, i], R[i_, j_, u_, v_] :> Subscript[R, i, j]}]]; 
	,
	Null
	,
	TestID->"4-tensor-product.nb"
]

VerificationTest[
	tensorRankSet[R[___], 3]
	,
	3
	,
	TestID->"5-tensor-product.nb"
]

VerificationTest[
	tensorRankEqualQ[tensor[1, x], tensor[x, x]]
	,
	True
	,
	TestID->"6-tensor-product.nb"
]

VerificationTest[
	(Map[#1 -> tensorRankGet[#1] & ])[{1, tensor[1], tensor[1, 1], x, 2*x, tensor[2*x], tensor[1, x], 2*tensor[1, x], R[], tensor[R[]], 2*R[], tensor[2*R[]], 2*tensor[2*R[], 2*x]}]
	,
	{1 -> 1, tensor[1] -> 1, tensor[1, 1] -> 2, x -> 1, 2*x -> 1, tensor[2*x] -> 1, tensor[1, x] -> 2, 2*tensor[1, x] -> 2, R[] -> 3, tensor[R[]] -> 3, 2*R[] -> 3, tensor[2*R[]] -> 3, 2*tensor[2*R[], 2*x] -> 4}
	,
	TestID->"7-tensor-product.nb"
]

VerificationTest[
	algS[tensorCompose[tensor[1, x]**tensor[x, 1]]]
	,
	tensor[x, x]
	,
	TestID->"8-tensor-product.nb"
]

VerificationTest[
	expr = tensor[1, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
	,
	tensor[1, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
	,
	TestID->"9-tensor-product.nb"
]

VerificationTest[
	longexpr = operatorPower[expr, 2]
	,
	tensor[1, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]**tensor[1, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
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
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-tensor-product.nb"
]