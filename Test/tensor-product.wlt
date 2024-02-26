

(*tensor-product.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"init-tensor-product.nb"
]

VerificationTest[
	Get["Yurie`Algebra`"]
	,
	Null
	,
	TestID->1
]

VerificationTest[
	algebraDefine["YBE"]; 
	algebraDefault[{"YBE", "tensor-product"}]
	,
	Null
	,
	TestID->2
]

VerificationTest[
	algebraAdd["YBE"][Association[operator -> {R, x}, relation -> {R[i_, j_, u_, v_]**((x_) ⊗ (y_) ⊗ (z_)) :> ((u - v)/(u - v + I))*x ⊗ y ⊗ z + (I/(u - v + I))*Permute[x ⊗ y ⊗ z, Cycles[{{i, j}}]]}, printing -> {(op_)?generatorQ[i_] :> Subscript[op, i], R[i_, j_, u_, v_] :> Subscript[R, i, j]}]]; 
	,
	Null
	,
	TestID->3
]

VerificationTest[
	tensorRankSet[R[___], 3]
	,
	3
	,
	TestID->4
]

VerificationTest[
	expr = (id ⊗ R[1, 2, u, v])**(x[1] ⊗ x[2] ⊗ x[3] ⊗ x[4])
	,
	(id ⊗ R[1, 2, u, v])**(x[1] ⊗ x[2] ⊗ x[3] ⊗ x[4])
	,
	TestID->5
]

VerificationTest[
	longexpr = operatorPower[expr, 2]
	,
	(id ⊗ R[1, 2, u, v])**(x[1] ⊗ x[2] ⊗ x[3] ⊗ x[4])**(id ⊗ R[1, 2, u, v])**(x[1] ⊗ x[2] ⊗ x[3] ⊗ x[4])
	,
	TestID->6
]

VerificationTest[
	tensorRankGet[expr]
	,
	4
	,
	TestID->7
]

VerificationTest[
	tensorRankGet[longexpr]
	,
	4
	,
	TestID->8
]

VerificationTest[
	algS[longexpr]
	,
	(1/(I + u - v)^2)*((u - v)^2*x[1]**x[1] ⊗ x[2]**x[2] ⊗ x[3]**x[3] ⊗ x[4]**x[4] + I*((u - v)*x[1]**x[1] ⊗ x[2]**x[3] ⊗ x[3]**x[2] ⊗ x[4]**x[4] + (u - v)*x[1]**x[1] ⊗ x[3]**x[2] ⊗ x[2]**x[3] ⊗ x[4]**x[4] + I*x[1]**x[1] ⊗ x[3]**x[3] ⊗ x[2]**x[2] ⊗ x[4]**x[4]))
	,
	TestID->9
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"cleanup-tensor-product.nb"
]