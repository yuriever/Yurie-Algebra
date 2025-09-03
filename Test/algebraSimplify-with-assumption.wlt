

(* algebraSimplify-with-assumption.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"[1] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    algebraDefine["test"]
    ,
    Null
    ,
    TestID->"[2] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    algebraDefault["test"]
    ,
    Null
    ,
    TestID->"[3] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    algebraAdd["test"][Association["Generator" -> {L}, "Relation" -> {commDefine[L[n_], L[m_]] :> f[n - m]*L[n + m] /; Simplify[n > m]}]]
    ,
    Null
    ,
    TestID->"[4] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    res = Simplify[Total[{Assuming[n > m > k > 0, commSim[L[n], L[m], L[k]] + commSim[L[m], L[k], L[n]]], Assuming[k > n > m > 0, commSim[L[k], L[n], L[m]]]}]]
    ,
    ((-f[k - m])*f[k + m - n] + f[k - n]*f[k - m + n] + f[-m + n]*f[-k + m + n])*L[k + m + n]
    ,
    TestID->"[5] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    Simplify[(ReplaceAll[f -> Function[x, x]])[operatorSeparate[res]]]
    ,
    {0}
    ,
    TestID->"[6] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    Simplify[(ReplaceAll[f -> Function[x, x^2]])[operatorSeparate[res]]]
    ,
    {2*(k - n)*(-m + n)*(k^2 - 2*k*m + m^2 - n^2)}
    ,
    TestID->"[7] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    algebraUnset[]; 
    algebraDefine[]
    ,
    Quiet[{"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}]
    ,
    {General::StarRemoveDefault}
    ,
    TestID->"[8] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    algebraDefault[]
    ,
    {}
    ,
    TestID->"[9] algebraSimplify-with-assumption.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] algebraSimplify-with-assumption.nb"
]