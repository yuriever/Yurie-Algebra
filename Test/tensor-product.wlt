

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
	algebraDefine["YBE"]; 
	algebraDefault[{"YBE", "TensorProduct"}]
	,
	Null
	,
	TestID->"2-tensor-product.nb"
]

VerificationTest[
	algebraAdd["YBE"][Association[operator -> {R, x}, relation -> {R[i_, j_, u_, v_]**((x_) ⊗ (y_) ⊗ (z_)) :> ((u - v)/(u - v + I))*x ⊗ y ⊗ z + (I/(u - v + I))*Permute[x ⊗ y ⊗ z, Cycles[{{i, j}}]]}, printing -> {(op_)?generatorQ[i_] :> Subscript[op, i], R[i_, j_, u_, v_] :> Subscript[R, i, j]}]]; 
	,
	Null
	,
	TestID->"3-tensor-product.nb"
]

VerificationTest[
	tensorRankSet[R[___], 3]
	,
	3
	,
	TestID->"4-tensor-product.nb"
]

VerificationTest[
	expr = (id ⊗ R[1, 2, u, v])**(x[1] ⊗ x[2] ⊗ x[3] ⊗ x[4])
	,
	(id ⊗ R[1, 2, u, v])**(x[1] ⊗ x[2] ⊗ x[3] ⊗ x[4])
	,
	TestID->"5-tensor-product.nb"
]

VerificationTest[
	longexpr = operatorPower[expr, 2]
	,
	(id ⊗ R[1, 2, u, v])**(x[1] ⊗ x[2] ⊗ x[3] ⊗ x[4])**(id ⊗ R[1, 2, u, v])**(x[1] ⊗ x[2] ⊗ x[3] ⊗ x[4])
	,
	TestID->"6-tensor-product.nb"
]

VerificationTest[
	tensorRankGet[expr]
	,
	4
	,
	TestID->"7-tensor-product.nb"
]

VerificationTest[
	tensorRankGet[longexpr]
	,
	4
	,
	TestID->"8-tensor-product.nb"
]

VerificationTest[
	algS[longexpr]
	,
	(1/(I + u - v)^2)*((u - v)^2*x[1]**x[1] ⊗ x[2]**x[2] ⊗ x[3]**x[3] ⊗ x[4]**x[4] + I*((u - v)*x[1]**x[1] ⊗ x[2]**x[3] ⊗ x[3]**x[2] ⊗ x[4]**x[4] + (u - v)*x[1]**x[1] ⊗ x[3]**x[2] ⊗ x[2]**x[3] ⊗ x[4]**x[4] + I*x[1]**x[1] ⊗ x[3]**x[3] ⊗ x[2]**x[2] ⊗ x[4]**x[4]))
	,
	TestID->"9-tensor-product.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-tensor-product.nb"
]