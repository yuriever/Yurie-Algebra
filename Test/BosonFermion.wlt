

(* BosonFermion.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] BosonFermion.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[1] BosonFermion.nb"
]

VerificationTest[
    Get["Yurie`Algebra`BosonFermion`"]
    ,
    Null
    ,
    TestID->"[2] BosonFermion.nb"
]

VerificationTest[
    algebraDefault[{"Boson", "Fermion", "BosonFermion", "Vacuum", "BosonVacuum", "FermionVacuum", "Conjugate"}]
    ,
    Null
    ,
    TestID->"[3] BosonFermion.nb"
]

VerificationTest[
    expr = (boson[1, an] + boson[1, cr] + boson[2, an])**boson[1, cr]**(fermion[1, cr] + boson[2, an]**fermion[1, an])**boson[2, cr]; 
    ,
    Null
    ,
    TestID->"[4] BosonFermion.nb"
]

VerificationTest[
    (operatorSeparate[#1, "Operator" -> True] & )[algS[expr**vac]]
    ,
    {fermion[1, cr]**boson[1, cr]**vac -> 1, fermion[1, cr]**boson[2, cr]**vac -> 1, fermion[1, cr]**boson[2, cr]**boson[1, cr]**boson[1, cr]**vac -> 1}
    ,
    TestID->"[5] BosonFermion.nb"
]

VerificationTest[
    H[k_] := boson[k, cr]**boson[k, an]*f[k] + fermion[k, cr]**fermion[k, an]*g[k]; 
    ,
    Null
    ,
    TestID->"[6] BosonFermion.nb"
]

VerificationTest[
    Hsum[expr_] := Module[{k}, Sum[H[k]**expr, {k, -2, 2}]]; 
    ,
    Null
    ,
    TestID->"[7] BosonFermion.nb"
]

VerificationTest[
    (operatorSeparate[#1, "Operator" -> True] & )[algS[Hsum[expr**vac]]]
    ,
    {fermion[1, cr]**boson[1, cr]**vac -> f[1] + g[1], fermion[1, cr]**boson[2, cr]**vac -> f[2] + g[1], fermion[1, cr]**boson[2, cr]**boson[1, cr]**boson[1, cr]**vac -> 2*f[1] + f[2] + g[1]}
    ,
    TestID->"[8] BosonFermion.nb"
]

VerificationTest[
    algS[innerProduct[expr**vac]]
    ,
    4
    ,
    TestID->"[9] BosonFermion.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    $algebraDefault
    ,
    {}
    ,
    TestID->"[10] BosonFermion.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] BosonFermion.nb"
]