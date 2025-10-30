

(* Harmonic.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] Harmonic.nb"
]

VerificationTest[
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[1] Harmonic.nb"
]

VerificationTest[
    Get["Yurie`Algebra`Harmonic`"]
    ,
    Null
    ,
    TestID->"[2] Harmonic.nb"
]

VerificationTest[
    algebraDefault[{"HarmonicOscillator", "Vacuum", "Conjugate"}]
    ,
    Null
    ,
    TestID->"[3] Harmonic.nb"
]

VerificationTest[
    cN = cr**an; 
    cH = ω*ℏ*(id/2 + cr**an); 
    cX = Sqrt[ℏ/(2*m*ω)]*(cr + an); 
    cP = I*Sqrt[(ℏ*m*ω)/2]*(cr - an); 
    cH
    ,
    ω*ℏ*(id/2 + cr**an)
    ,
    TestID->"[4] Harmonic.nb"
]

VerificationTest[
    PowerExpand[commSim[cX, cP]]
    ,
    I*id*ℏ
    ,
    TestID->"[5] Harmonic.nb"
]

VerificationTest[
    algS[((m*ω^2)/2)*cX**cX + (1/(2*m))*cP**cP - cH]
    ,
    0
    ,
    TestID->"[6] Harmonic.nb"
]

VerificationTest[
    algSP[Table[cN**ket[n], {n, 0, 4}]]
    ,
    {0, Ket[{1}], 2*Ket[{2}], 3*Ket[{3}], 4*Ket[{4}]}
    ,
    TestID->"[7] Harmonic.nb"
]

VerificationTest[
    algSP[Table[cH**ket[n], {n, 0, 4}]]
    ,
    {(ω*ℏ*Ket[{0}])/2, (3*ω*ℏ*Ket[{1}])/2, (5*ω*ℏ*Ket[{2}])/2, (7*ω*ℏ*Ket[{3}])/2, (9*ω*ℏ*Ket[{4}])/2}
    ,
    TestID->"[8] Harmonic.nb"
]

VerificationTest[
    algebraDefault[]; 
    algebraUnset[]; 
    $algebraDefault
    ,
    {}
    ,
    TestID->"[9] Harmonic.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] Harmonic.nb"
]