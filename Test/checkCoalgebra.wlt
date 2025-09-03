

(* checkCoalgebra.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] checkCoalgebra.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"[1] checkCoalgebra.nb"
]

VerificationTest[
    algebraDefine["test"]
    ,
    Null
    ,
    TestID->"[2] checkCoalgebra.nb"
]

VerificationTest[
    algebraDefault[{"test", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
    ,
    Null
    ,
    TestID->"[3] checkCoalgebra.nb"
]

VerificationTest[
    algebraAdd["test"][Association["Generator" -> {g, x}, "Relation" -> {commDefine[g, x, Reverse, 1] -> 0, x**x :> 0, g**g :> id, comultiply[g] :> tensor[g, g], comultiply[x] :> tensor[g, x] + c[1]*tensor[x, id], counit[g] :> d[1], counit[x] :> d[2], antipode[g] :> a[1]*g + a[2]*x + a[3]*g**x + a[4]*id, antipode[x] :> b[1]*g + b[2]*x + b[3]*g**x + b[4]*id}, "Printing" -> {}, "Rank" -> {g -> 1, x -> 1}]]; 
    ,
    Null
    ,
    TestID->"[4] checkCoalgebra.nb"
]

VerificationTest[
    eqs1 = operatorSeparate[Extract[{All, 2}][(Map[checkCoassociativity])[{x, g, g**x}]]]
    ,
    {(-1 + c[1])*c[1], (-1 + c[1])*c[1]}
    ,
    TestID->"[5] checkCoalgebra.nb"
]

VerificationTest[
    sol1 = Solve[eqs1 == 0, Variables[eqs1]]
    ,
    {{c[1] -> 0}, {c[1] -> 1}}
    ,
    TestID->"[6] checkCoalgebra.nb"
]

VerificationTest[
    eqs2 = operatorSeparate[Extract[{All, 2}][(Map[checkCounitality])[{x, g, g**x}]]]
    ,
    {-1 + d[1], c[1]*d[2], -1 + c[1], d[2], -1 + d[1], -1 + d[1], c[1]*d[1]*d[2], d[1]*d[2], -1 + c[1]*d[1]}
    ,
    TestID->"[7] checkCoalgebra.nb"
]

VerificationTest[
    sol2 = Solve[eqs2 == 0, Variables[eqs2]]
    ,
    {{c[1] -> 1, d[1] -> 1, d[2] -> 0}}
    ,
    TestID->"[8] checkCoalgebra.nb"
]

VerificationTest[
    eqs = (ReplaceAll[sol2])[operatorSeparate[Extract[{All, 2}][(Map[checkAntipode])[{x, g}]]]]
    ,
    {{a[4] + b[2], b[1], b[4], a[1] + b[3], b[1], 1 + b[3], b[4], b[2], -1 + a[1], -a[3], a[4], -a[2], -1 + a[1], a[3], a[4], a[2]}}
    ,
    TestID->"[9] checkCoalgebra.nb"
]

VerificationTest[
    sol = Solve[eqs == 0, Variables[eqs]]
    ,
    {{a[1] -> 1, a[2] -> 0, a[3] -> 0, a[4] -> 0, b[1] -> 0, b[2] -> 0, b[3] -> -1, b[4] -> 0}}
    ,
    TestID->"[10] checkCoalgebra.nb"
]

VerificationTest[
    (ReplaceAll[sol2])[(ReplaceAll[sol])[algS[{comultiply[x], counit[g], counit[x], antipode[g], antipode[x]}]]]
    ,
    {{{tensor[g, x] + tensor[x, id], 1, 0, g, -g**x}}}
    ,
    TestID->"[11] checkCoalgebra.nb"
]

VerificationTest[
    algebraUnset[]; 
    algebraDefine[]
    ,
    Quiet[{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
    ,
    {General::StarRemoveDefault}
    ,
    TestID->"[12] checkCoalgebra.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    algebraDefault[]
    ,
    {}
    ,
    TestID->"[13] checkCoalgebra.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] checkCoalgebra.nb"
]