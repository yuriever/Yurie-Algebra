(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Global`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


L::usage =
    "operator: L.";

Lb::usage =
    "operator: Lbar.";

vac::usage =
    "state: vacuum.";

prim::usage =
    "state: prim.";

desc::usage =
    "state: desc.";


$CFT::usage =
    "index list, generator list and Casimir element of the conformal algebra.";

$centralCharge::usage =
    "central charge: Virasoro, holomorphic.";

$centralChargeb::usage =
    "central charge: Virasoro, anti-holomorphic.";


Lmonomial::usage =
    "monomial of L.";

Lbmonomial::usage =
    "monomial of Lbar.";

Lpower::usage =
    "power of single L generator.";

Lbpower::usage =
    "power of single Lbar generator.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


algebraDefine[
    "CA","CAIP",
    "Verma","VermaIP",
    "VermaLog","VermaLogUpper","VermaLogLower","VermaLogIP",
    (*  *)
    "LocalCA","LocalCAIP",
    "LocalVerma","LocalVermaIP",
    "LocalVermaLog","LocalVermaLogUpper","LocalVermaLogLower","LocalVermaLogIP",
    (*  *)
    "Vacuum","VacuumIP"
];


(* ::Subsubsection:: *)
(*Conformal algebra*)


<|
    "Generator"->{L,Lb},
    "Relation"->{
        L[n_]**L[m_]:>L[m]**L[n]+(n-m)L[n+m]/;n>m,
        Lb[n_]**Lb[m_]:>Lb[m]**Lb[n]+(n-m)Lb[n+m]/;n>m,
        L[n_]**Lb[m_]:>Lb[m]**L[n]/;n>m,
        Lb[n_]**L[m_]:>L[m]**Lb[n]/;n>=m
    },
    "Printing"->{
        L[n_]:>Subscript[L,n],
        Lb[n_]:>Subscript[OverBar[L],n],
        Subscript[op_,n_]**Subscript[op_,n_]:>Subsuperscript[op,n,2],
        Subscript[op_,n_]**Subsuperscript[op_,n_,power_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power_]**Subscript[op_,n_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power1_]**Subsuperscript[op_,n_,power2_]:>Subsuperscript[op,n,power1+power2]
    }
|>//algebraAdd["CA"];


"Relation"->{
    conjugate[L[n_]]:>L[-n],
    conjugate[Lb[n_]]:>Lb[-n]
}//algebraAdd["CAIP"];


(* ::Subsubsection:: *)
(*Conformal algebra: local*)


<|
    "Generator"->{L,Lb},
    "Relation"->{
        L[n_]**L[m_]:>L[m]**L[n]+(n-m)L[n+m]+$centralCharge*KroneckerDelta[n+m,0]*(n^3-n)/12*id/;n>m,
        Lb[n_]**Lb[m_]:>Lb[m]**Lb[n]+(n-m)Lb[n+m]+$centralChargeb*KroneckerDelta[n+m,0]*(n^3-n)/12*id/;n>m,
        L[n_]**Lb[m_]:>Lb[m]**L[n]/;n>m,
        Lb[n_]**L[m_]:>L[m]**Lb[n]/;n>=m
    },
    "Printing"->{
        L[n_]:>Subscript[L,n],
        Lb[n_]:>Subscript[OverBar[L],n],
        Subscript[op_,n_]**Subscript[op_,n_]:>Subsuperscript[op,n,2],
        Subscript[op_,n_]**Subsuperscript[op_,n_,power_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power_]**Subscript[op_,n_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power1_]**Subsuperscript[op_,n_,power2_]:>Subsuperscript[op,n,power1+power2],
        $centralCharge->c,
        $centralChargeb->OverBar[c]
    }
|>//algebraAdd["LocalCA"];


"Relation"->{
    conjugate[L[n_]]:>L[-n],
    conjugate[Lb[n_]]:>Lb[-n]
}//algebraAdd["LocalCAIP"];


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vac},
    "Relation"->{
        L[_]**vac:>0,
        Lb[_]**vac:>0
    },
    "Printing"->{
        vac:>Ket[{0}]
    }
|>//algebraAdd["Vacuum"];


"Relation"->{
    conjugate[vac]**vac:>1,
    conjugate[vac]**L[_]:>0,
    conjugate[vac]**Lb[_]:>0
}//algebraAdd["VacuumIP"];


(* ::Subsubsection:: *)
(*Verma*)


<|
    "Generator"->{prim},
    "Relation"->{
        L[0]**prim[h_,hb_]:>h*prim[h,hb],
        Lb[0]**prim[h_,hb_]:>hb*prim[h,hb],
        L[1]**prim[h_,hb_]:>0,
        Lb[1]**prim[h_,hb_]:>0
    }
|>//algebraAdd["Verma"];


"Relation"->{
    conjugate[prim[h_,hb_]]**prim[h_,hb_]:>1,
    conjugate[prim[h_,hb_]]**L[-1]:>0,
    conjugate[prim[h_,hb_]]**Lb[-1]:>0
}//algebraAdd["VermaIP"];


(* ::Subsubsection:: *)
(*Verma: log*)


<|
    "Generator"->{prim},
    "Relation"->{
        (* Boundary condition *)
        prim[rank_,a_,h_,hb_]:>0/;a<=0,
        prim[rank_,a_,h_,hb_]:>0/;a>rank,
        (* Annihilation rule *)
        L[1]**prim[rank_,a_,h_,hb_]:>0,
        Lb[1]**prim[rank_,a_,h_,hb_]:>0
    }
|>//algebraAdd["VermaLog","VermaLogUpper","VermaLogLower"];


"Relation"->{
    conjugate[prim[rank_,a_,h_,hb_]]**prim[rank_,b_,h_,hb_]:>KroneckerDelta[a+b,rank+1],
    conjugate[prim[rank_,a_,h_,hb_]]**L[-1]:>0,
    conjugate[prim[rank_,a_,h_,hb_]]**Lb[-1]:>0
}//algebraAdd["VermaLogIP"];


"Relation"->{
    L[0]**prim[rank_,a_,h_,hb_]:>h*prim[rank,a,h,hb]+1/2*prim[rank,a+1,h,hb],
    Lb[0]**prim[rank_,a_,h_,hb_]:>hb*prim[rank,a,h,hb]+1/2*prim[rank,a+1,h,hb]
}//algebraAdd["VermaLog","VermaLogUpper"];

"Relation"->{
    L[0]**prim[rank_,a_,h_,hb_]:>h*prim[rank,a,h,hb]+1/2*prim[rank,a-1,h,hb],
    Lb[0]**prim[rank_,a_,h_,hb_]:>hb*prim[rank,a,h,hb]+1/2*prim[rank,a-1,h,hb]
}//algebraAdd["VermaLogLower"];


(* ::Subsubsection:: *)
(*Verma: local*)


<|
    "Generator"->{prim},
    "Relation"->{
        L[0]**prim[h_,hb_]:>h*prim[h,hb],
        Lb[0]**prim[h_,hb_]:>hb*prim[h,hb],
        L[n_]**prim[h_,hb_]:>0/;n>=1,
        Lb[n_]**prim[h_,hb_]:>0/;n>=1
    }
|>//algebraAdd["LocalVerma"];


"Relation"->{
    conjugate[prim[h_,hb_]]**prim[h_,hb_]:>1,
    conjugate[prim[h_,hb_]]**L[n_]:>0/;n<=-1,
    conjugate[prim[h_,hb_]]**Lb[n_]:>0/;n<=-1
}//algebraAdd["LocalVermaIP"];


(* ::Subsubsection:: *)
(*Verma: local, log*)


<|
    "Generator"->{prim},
    "Relation"->{
        (* Boundary condition *)
        prim[rank_,a_,h_,hb_]:>0/;a<=0,
        prim[rank_,a_,h_,hb_]:>0/;a>rank,
        (* Annihilation rule *)
        L[n_]**prim[rank_,a_,h_,hb_]:>0/;n>=1,
        Lb[n_]**prim[rank_,a_,h_,hb_]:>0/;n>=1
    }
|>//algebraAdd["LocalVermaLog","LocalVermaLogUpper","LocalVermaLogLower"];


"Relation"->{
    conjugate[prim[rank_,a_,h_,hb_]]**prim[rank_,b_,h_,hb_]:>KroneckerDelta[a+b,rank+1],
    conjugate[prim[rank_,a_,h_,hb_]]**L[n_]:>0/;n<=-1,
    conjugate[prim[rank_,a_,h_,hb_]]**Lb[n_]:>0/;n<=-1
}//algebraAdd["LocalVermaLogIP"];


"Relation"->{
    L[0]**prim[rank_,a_,h_,hb_]:>h*prim[rank,a,h,hb]+1/2*prim[rank,a+1,h,hb],
    Lb[0]**prim[rank_,a_,h_,hb_]:>hb*prim[rank,a,h,hb]+1/2*prim[rank,a+1,h,hb]
}//algebraAdd["LocalVermaLog","LocalVermaLogUpper"];

"Relation"->{
    L[0]**prim[rank_,a_,h_,hb_]:>h*prim[rank,a,h,hb]+1/2*prim[rank,a-1,h,hb],
    Lb[0]**prim[rank_,a_,h_,hb_]:>hb*prim[rank,a,h,hb]+1/2*prim[rank,a-1,h,hb]
}//algebraAdd["LocalVermaLogLower"];


(* ::Subsection:: *)
(*Constant*)


With[{
        casimir = L[0]**L[0]-L[0]-L[-1]**L[1],
        casimirb = Lb[0]**Lb[0]-Lb[0]-Lb[-1]**Lb[1]
    },
    $CFT = <|
        "Index"->{-1,0,1},
        "L"->{L[-1],L[0],L[1]},
        "Lb"->{Lb[-1],Lb[0],Lb[1]},
        "LLb"->{L[-1],L[0],L[1],Lb[-1],Lb[0],Lb[1]},
        "Casimir"->casimir,
        "Casimirb"->casimirb,
        "C"->casimir,
        "Cb"->casimirb,
        "Ch"->Function[h,casimir-h*(h-1)id],
        "Chb"->Function[hb,casimirb-hb*(hb-1)id]
    |>;
];


(* ::Subsection:: *)
(*Function*)


Lmonomial[] :=
    id;

Lmonomial[n_] :=
    L[n];

Lmonomial[n__] :=
    Map[L,NonCommutativeMultiply[n]];


Lbmonomial[] :=
    id;

Lbmonomial[n_] :=
    Lb[n];

Lbmonomial[n__] :=
    Map[Lb,NonCommutativeMultiply[n]];


Lpower[k_,n_Integer?NonNegative] :=
    operatorPower[L[k],n];


Lbpower[k_,n_Integer?NonNegative] :=
    operatorPower[Lb[k],n];


desc[h_,hb_,n_Integer?NonNegative,nb_Integer?NonNegative] :=
    operatorPower[L[-1],n]**operatorPower[Lb[-1],nb]**prim[h,hb];

desc[rank_,a_,h_,hb_,n_Integer?NonNegative,nb_Integer?NonNegative] :=
    operatorPower[L[-1],n]**operatorPower[Lb[-1],nb]**prim[rank,a,h,hb];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
