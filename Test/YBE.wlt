

(* YBE.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] YBE.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[1] YBE.nb"
]

VerificationTest[
    Get["Yurie`Algebra`YBE`"]
    ,
    Null
    ,
    TestID->"[2] YBE.nb"
]

VerificationTest[
    algebraDefault[{"YBE", "Tensor"}]
    ,
    Null
    ,
    TestID->"[3] YBE.nb"
]

VerificationTest[
    expr = R[1, 2, u, v]**tensor[x[1], x[2], x[3]]
    ,
    R[1, 2, u, v]**tensor[x[1], x[2], x[3]]
    ,
    TestID->"[4] YBE.nb"
]

VerificationTest[
    expr == algS[expr]
    ,
    R[1, 2, u, v]**tensor[x[1], x[2], x[3]] == ((u - v)*tensor[x[1], x[2], x[3]] + I*tensor[x[2], x[1], x[3]])/(I + u - v)
    ,
    TestID->"[5] YBE.nb"
]

VerificationTest[
    LHS = R[1, 2, u, v]**R[1, 3, u, w]**R[2, 3, v, w]**tensor[x[1], x[2], x[3]]; 
    (RHS = R[2, 3, v, w]**R[1, 3, u, w]**R[1, 2, u, v]**tensor[x[1], x[2], x[3]]; )
    ,
    Null
    ,
    TestID->"[6] YBE.nb"
]

VerificationTest[
    algS[LHS]
    ,
    (1/((I + u - v)*(I + u - w)*(I + v - w)))*((u - v)*(u - w)*(v - w)*tensor[x[1], x[2], x[3]] + I*((u - v)*(u - w)*tensor[x[1], x[3], x[2]] + (u - w)*(v - w)*tensor[x[2], x[1], x[3]] + I*u*tensor[x[2], x[3], x[1]] - I*w*tensor[x[2], x[3], x[1]] + I*u*tensor[x[3], x[1], x[2]] - I*w*tensor[x[3], x[1], x[2]] - tensor[x[3], x[2], x[1]] + u*v*tensor[x[3], x[2], x[1]] - v^2*tensor[x[3], x[2], x[1]] - u*w*tensor[x[3], x[2], x[1]] + v*w*tensor[x[3], x[2], x[1]]))
    ,
    TestID->"[7] YBE.nb"
]

VerificationTest[
    algEqualQ[LHS, RHS]
    ,
    True
    ,
    TestID->"[8] YBE.nb"
]

VerificationTest[
    algebraUnset[]; 
    algebraDefine[]
    ,
    Quiet[{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
    ,
    {General::StarRemoveDefault}
    ,
    TestID->"[9] YBE.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    algebraDefault[]
    ,
    {}
    ,
    TestID->"[10] YBE.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] YBE.nb"
]