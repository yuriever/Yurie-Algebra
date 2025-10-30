

(* algebraCluster-edge-case.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] algebraCluster-edge-case.nb"
]

VerificationTest[
    Get["Yurie`Algebra`"]
    ,
    Null
    ,
    TestID->"[1] algebraCluster-edge-case.nb"
]

VerificationTest[
    monitor := {$algebraDefine, $algebraDefault, generator[]}
    ,
    Null
    ,
    TestID->"[2] algebraCluster-edge-case.nb"
]

VerificationTest[
    monitor
    ,
    {{"Algebra", "Conjugate", "Inverse", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}, {}, {id}}
    ,
    TestID->"[3] algebraCluster-edge-case.nb"
]

VerificationTest[
    algebraDefine[{}]; 
    monitor
    ,
    {{"Algebra", "Conjugate", "Inverse", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}, {}, {id}}
    ,
    TestID->"[4] algebraCluster-edge-case.nb"
]

VerificationTest[
    algebraDefine[]; 
    monitor
    ,
    {{"Algebra", "Conjugate", "Inverse", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}, {}, {id}}
    ,
    TestID->"[5] algebraCluster-edge-case.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    monitor
    ,
    {{"Algebra", "Conjugate", "Inverse", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}, {}, {id}}
    ,
    TestID->"[6] algebraCluster-edge-case.nb"
]

VerificationTest[
    algebraDefault[]; 
    monitor
    ,
    {{"Algebra", "Conjugate", "Inverse", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}, {}, {id}}
    ,
    TestID->"[7] algebraCluster-edge-case.nb"
]

VerificationTest[
    algebraReset[{}]; 
    monitor
    ,
    {{"Algebra", "Conjugate", "Inverse", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}, {}, {id}}
    ,
    TestID->"[8] algebraCluster-edge-case.nb"
]

VerificationTest[
    algebraUnset[{}]; 
    monitor
    ,
    {{"Algebra", "Conjugate", "Inverse", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}, {}, {id}}
    ,
    TestID->"[9] algebraCluster-edge-case.nb"
]

VerificationTest[
    algebraAdd[{}][{"Generator" -> {x}}]; 
    monitor
    ,
    {{"Algebra", "Conjugate", "Inverse", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}, {}, {id}}
    ,
    TestID->"[10] algebraCluster-edge-case.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    monitor
    ,
    {{"Algebra", "Conjugate", "Inverse", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}, {}, {id}}
    ,
    TestID->"[11] algebraCluster-edge-case.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] algebraCluster-edge-case.nb"
]