

(*CFT1.nb*)

VerificationTest[
    Begin["Global`"];
	ClearAll["`*"]
    ,
    Null
    ,
    TestID->"0-CFT1.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"1-CFT1.nb"
]

VerificationTest[
    Get["Yurie`Algebra`CFT1`"]
    ,
    Null
    ,
    TestID->"2-CFT1.nb"
]

VerificationTest[
    algebraDefault[{"conformal-algebra", "singlet", "Conjugate", "conformal-algebra-conjugate", "singlet-conjugate"}]
    ,
    Null
    ,
    TestID->"3-CFT1.nb"
]

VerificationTest[
    algFS[Table[innerProduct[descendant[h, i], descendant[h, j]], {i, Range[4]}, {j, Range[4]}]]
    ,
    {{2*h, 0, 0, 0}, {0, 4*h*(1 + 2*h), 0, 0}, {0, 0, 24*h*(1 + h)*(1 + 2*h), 0}, {0, 0, 0, 96*h*(1 + h)*(1 + 2*h)*(3 + 2*h)}}
    ,
    TestID->"4-CFT1.nb"
]

VerificationTest[
    Llist[n_] := (MapApply[Lmonomial])[-IntegerPartitions[n]]; 
    (gramian[n_, primary_] := Table[innerProduct[bra**primary, ket**primary], {bra, Llist[n]}, {ket, Llist[n]}]; )
    ,
    Null
    ,
    TestID->"5-CFT1.nb"
]

VerificationTest[
    algebraDefault[{"Virasoro", "vacuum", "singlet", "Conjugate", "Virasoro-conjugate", "singlet-conjugate", "vacuum-conjugate"}]
    ,
    Null
    ,
    TestID->"6-CFT1.nb"
]

VerificationTest[
    algSP[gramian[1, primary[h]]]
    ,
    {{2*h}}
    ,
    TestID->"7-CFT1.nb"
]

VerificationTest[
    algSP[gramian[2, primary[h]]]
    ,
    {{(1/2)*("c" + 8*h), 6*h}, {6*h, 4*h*(1 + 2*h)}}
    ,
    TestID->"8-CFT1.nb"
]

VerificationTest[
    algebraUnset[]
    ,
    Null
    ,
    {Yurie`Cluster`cluster::rmdefault}
    ,
    TestID->"9-CFT1.nb"
]

VerificationTest[
    algebraDefine[]
    ,
    {"Algebra", "Conjugate", "Tensor", "Coalgebra", "Bialgebra", "Antipode"}
    ,
    TestID->"10-CFT1.nb"
]

VerificationTest[
    algebraDefault[{}]; 
    algebraDefault[]
    ,
    {}
    ,
    TestID->"11-CFT1.nb"
]

VerificationTest[
    ClearAll["`*"];
	End[]
    ,
    "Global`"
    ,
    TestID->"∞-CFT1.nb"
]