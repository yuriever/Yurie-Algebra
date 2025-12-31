

(* tensor-product.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] tensor-product.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"[1] tensor-product.nb"
]

VerificationTest[
    algebraDefine["test"]
    ,
    Null
    ,
    TestID->"[2] tensor-product.nb"
]

VerificationTest[
    algebraDefault["test", "Tensor"]
    ,
    Null
    ,
    TestID->"[3] tensor-product.nb"
]

VerificationTest[
    algebraAdd["test"][Association["Generator" -> {x[_], S[], R[___]}, "Relation" -> {S[]**tensor[x_, y_] :> tensor[y, x], R[i_, j_, u_, v_]**tensor[x_, y_, z_] :> ((u - v)/(u - v + I))*tensor[x, y, z] + (I/(u - v + I))*Permute[tensor[x, y, z], Cycles[{{i, j}}]]}, "Printing" -> {x[i_] :> Subscript[x, i], S[] -> S, R[i_, j_, u_, v_] :> Subscript[R, i, j]}, "Rank" -> {S[] -> 2, R[___] -> 3}]]
    ,
    Null
    ,
    TestID->"[4] tensor-product.nb"
]

VerificationTest[
    algS[S[]**tensor[x[1], x[2]]]
    ,
    tensor[x[2], x[1]]
    ,
    TestID->"[5] tensor-product.nb"
]

VerificationTest[
    algS[tensor[id, S[]]**tensor[x[1], x[2], x[3]]]
    ,
    tensor[x[1], x[3], x[2]]
    ,
    TestID->"[6] tensor-product.nb"
]

VerificationTest[
    expr = tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
    ,
    tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
    ,
    TestID->"[7] tensor-product.nb"
]

VerificationTest[
    algS[expr]
    ,
    ((u - v)*tensor[x[1], x[2], x[3], x[4]] + I*tensor[x[1], x[3], x[2], x[4]])/(I + u - v)
    ,
    TestID->"[8] tensor-product.nb"
]

VerificationTest[
    longexpr = operatorPower[expr, 2]
    ,
    tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]**tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
    ,
    TestID->"[9] tensor-product.nb"
]

VerificationTest[
    algS[longexpr]
    ,
    (1/(I + u - v)^2)*((u - v)^2*tensor[x[1]**x[1], x[2]**x[2], x[3]**x[3], x[4]**x[4]] + I*((u - v)*tensor[x[1]**x[1], x[2]**x[3], x[3]**x[2], x[4]**x[4]] + (u - v)*tensor[x[1]**x[1], x[3]**x[2], x[2]**x[3], x[4]**x[4]] + I*tensor[x[1]**x[1], x[3]**x[3], x[2]**x[2], x[4]**x[4]]))
    ,
    TestID->"[10] tensor-product.nb"
]

VerificationTest[
    operatorSeparate[algS[longexpr]]
    ,
    {(u - v)^2/(I + u - v)^2, (I*u - I*v)/(I + u - v)^2, (I*u - I*v)/(I + u - v)^2, -(1/(I + u - v)^2)}
    ,
    TestID->"[11] tensor-product.nb"
]

VerificationTest[
    (Map[tensorankUnsafe])[{1, id, tensor[id], tensor[id, id]}]
    ,
    {0, 1, 1, 2}
    ,
    TestID->"[12] tensor-product.nb"
]

VerificationTest[
    (Map[tensorankUnsafe])[{x[0], 2*x[0], tensor[x[0]], tensor[2*x[0]], tensor[id, x[0]], 2*tensor[id, 2*x[0]]}]
    ,
    {1, 1, 1, 1, 2, 2}
    ,
    TestID->"[13] tensor-product.nb"
]

VerificationTest[
    (Map[tensorankUnsafe])[{R[], 2*R[], tensor[R[]], tensor[2*R[]], tensor[R[], S[], x[0]], 2*tensor[2*R[], 2*S[], 2*x[0]]}]
    ,
    {3, 3, 3, 3, 6, 6}
    ,
    TestID->"[14] tensor-product.nb"
]

VerificationTest[
    tensorankUnsafe[tensor[R[]**tensor[S[], x[0]], x[0]]]
    ,
    4
    ,
    TestID->"[15] tensor-product.nb"
]

VerificationTest[
    tensorankUnsafe[tensor[id**x[0], R[]**tensor[x[0], x[0], x[0]]]]
    ,
    4
    ,
    TestID->"[16] tensor-product.nb"
]

VerificationTest[
    tensorank[2*R[]**x[0]]
    ,
    Quiet[tensorank[R[]**x[0]]]
    ,
    {Yurie`Algebra`tensorank::RankNotMatch}
    ,
    TestID->"[17] tensor-product.nb"
]

VerificationTest[
    tensorank[tensor[id**S[], R[]**tensor[S[], id], x[0]]]
    ,
    Quiet[tensorank[id**S[]]]
    ,
    {Yurie`Algebra`tensorank::RankNotMatch}
    ,
    TestID->"[18] tensor-product.nb"
]

VerificationTest[
    tensorankUnsafe[x[0] + tensor[x[0]]]
    ,
    tensorankUnsafe[tensor[x[0]] + x[0]]
    ,
    TestID->"[19] tensor-product.nb"
]

VerificationTest[
    tensorank[x[0] + tensor[x[0]]]
    ,
    1
    ,
    TestID->"[20] tensor-product.nb"
]

VerificationTest[
    tensorankUnsafe[x[0] + tensor[x[0], x[0]]]
    ,
    tensorankUnsafe[tensor[x[0], x[0]] + x[0]]
    ,
    TestID->"[21] tensor-product.nb"
]

VerificationTest[
    tensorank[x[0] + tensor[x[0], x[0]]]
    ,
    Indeterminate
    ,
    TestID->"[22] tensor-product.nb"
]

VerificationTest[
    tensorankUnsafe[tensor[x[0], x[0] + x[1]]]
    ,
    1 + tensorankUnsafe[x[0] + x[1]]
    ,
    TestID->"[23] tensor-product.nb"
]

VerificationTest[
    tensorank[tensor[x[0], x[0] + x[1]]]
    ,
    2
    ,
    TestID->"[24] tensor-product.nb"
]

VerificationTest[
    tensorCompose[2*tensor[id, x[0]]**tensor[x[0], id]]
    ,
    2*tensor[id**x[0], x[0]**id]
    ,
    TestID->"[25] tensor-product.nb"
]

VerificationTest[
    tensorCompose[2*tensor[id, R[]]**tensor[x[0], x[0], S[]]]
    ,
    2*tensor[id**x[0], R[]**tensor[x[0], S[]]]
    ,
    TestID->"[26] tensor-product.nb"
]

VerificationTest[
    tensorCompose[tensor[id, R[]]**tensor[id, S[], id]]
    ,
    tensor[id**id, R[]**tensor[S[], id]]
    ,
    TestID->"[27] tensor-product.nb"
]

VerificationTest[
    tensorCompose[tensor[id, x[0]]**tensor[x[0], id]**tensor[x[1], x[2]]]
    ,
    tensor[id**x[0]**x[1], x[0]**id**x[2]]
    ,
    TestID->"[28] tensor-product.nb"
]

VerificationTest[
    tensorCompose[tensor[id**id, R[]**tensor[S[], id]]**tensor[x[0], x[0], x[0], x[0]]]
    ,
    tensor[id**id**x[0], R[]**tensor[S[], id]**tensor[x[0], x[0], x[0]]]
    ,
    TestID->"[29] tensor-product.nb"
]

VerificationTest[
    tensorCompose[tensor[id, R[]]**tensor[id, S[], id]**tensor[x[0], x[0], x[0], x[0]]]
    ,
    tensor[id**id**x[0], R[]**tensor[S[], id]**tensor[x[0], x[0], x[0]]]
    ,
    TestID->"[30] tensor-product.nb"
]

VerificationTest[
    tensorCompose[tensor[S[], S[]]**tensor[id, R[1, 2, u, v]]]
    ,
    tensor[S[], S[]]**tensor[id, R[1, 2, u, v]]
    ,
    TestID->"[31] tensor-product.nb"
]

VerificationTest[
    tensorCompose[tensor[S[], S[]]**tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]]
    ,
    tensor[S[], S[]]**tensor[id, R[1, 2, u, v]]**tensor[x[1], x[2], x[3], x[4]]
    ,
    TestID->"[32] tensor-product.nb"
]

VerificationTest[
    tensorPermute[][tensor[a, b, c, d, e]]
    ,
    tensor[a, b, c, d, e]
    ,
    TestID->"[33] tensor-product.nb"
]

VerificationTest[
    tensorPermute[1, 2][tensor[a, b, c, d, e]]
    ,
    tensor[b, a, c, d, e]
    ,
    TestID->"[34] tensor-product.nb"
]

VerificationTest[
    tensorPermute[{1, 2}, {3, 4}][tensor[a, b, c, d, e]]
    ,
    tensor[b, a, d, c, e]
    ,
    TestID->"[35] tensor-product.nb"
]

VerificationTest[
    tensorPermute[1, 2][2*tensor[a, b] + tensor[c, d]]
    ,
    2*tensor[b, a] + tensor[d, c]
    ,
    TestID->"[36] tensor-product.nb"
]

VerificationTest[
    tensorPermute[{1, 2, 3, 4, 5, 6}][tensor[a, b, c, d, e]]
    ,
    Quiet[Permute[tensor[a, b, c, d, e], Cycles[{{1, 2, 3, 4, 5, 6}}]]]
    ,
    {Permute::lowlen}
    ,
    TestID->"[37] tensor-product.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    $algebraDefault
    ,
    {}
    ,
    TestID->"[38] tensor-product.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] tensor-product.nb"
]