

(*CCFT2.nb*)

VerificationTest[
    Begin["Global`"];
	ClearAll["`*"]
    ,
    Null
    ,
    TestID->"0-CCFT2.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"1-CCFT2.nb"
]

VerificationTest[
    Get["Yurie`Algebra`CCFT2`"]
    ,
    Null
    ,
    TestID->"2-CCFT2.nb"
]

VerificationTest[
    algebraDefault[{"conformal-algebra", "singlet", "Conjugate", "conformal-algebra-conjugate", "singlet-conjugate"}]
    ,
    Null
    ,
    TestID->"3-CCFT2.nb"
]

VerificationTest[
    l = 2; 
    ,
    Null
    ,
    TestID->"4-CCFT2.nb"
]

VerificationTest[
    algS[Table[innerProduct[descendant[Δ, ξ, i, l - i], descendant[Δ, ξ, j, l - j]], {i, Range[0, l]}, {j, Range[0, l]}]]
    ,
    {{0, 0, 8*ξ^2}, {0, 4*ξ^2, 4*(ξ + 2*Δ*ξ)}, {8*ξ^2, 4*(ξ + 2*Δ*ξ), 4*Δ*(1 + 2*Δ)}}
    ,
    TestID->"5-CCFT2.nb"
]

VerificationTest[
    algebraUnset[]
    ,
    Null
    ,
    {Yurie`Cluster`cluster::rmdefault}
    ,
    TestID->"6-CCFT2.nb"
]

VerificationTest[
    algebraDefine[]
    ,
    {"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
    ,
    TestID->"7-CCFT2.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    algebraDefault[]
    ,
    {}
    ,
    TestID->"8-CCFT2.nb"
]

VerificationTest[
    ClearAll["`*"];
	End[]
    ,
    "Global`"
    ,
    TestID->"∞-CCFT2.nb"
]