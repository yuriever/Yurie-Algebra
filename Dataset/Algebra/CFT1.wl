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

vac::usage =
    "state: vacuum.";

prim::usage =
    "state: prim.";

desc::usage =
    "state: desc.";


$CFT::usage =
    "index list, generator list and Casimir element of the conformal algebra.";

$centralCharge::usage =
    "Virasoro central charge.";


Lmonomial::usage =
    "monomial of L.";

Lpower::usage =
    "power of single L generator.";


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
    "Generator"->{L},
    "Relation"->{
        L[n_]**L[m_]:>L[m]**L[n]+(n-m)L[n+m]/;n>m
    },
    "Printing"->{
        L[n_]:>Subscript[L,n],
        Subscript[op_,n_]**Subscript[op_,n_]:>Subsuperscript[op,n,2],
        Subscript[op_,n_]**Subsuperscript[op_,n_,power_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power_]**Subscript[op_,n_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power1_]**Subsuperscript[op_,n_,power2_]:>Subsuperscript[op,n,power1+power2]
    }
|>//algebraAdd["CA"];


"Relation"->{
    conjugate[L[n_]]:>L[-n]
}//algebraAdd["CAIP"];


(* ::Subsubsection:: *)
(*Conformal algebra: local*)


<|
    "Generator"->{L},
    "Relation"->{
        L[n_]**L[m_]:>L[m]**L[n]+(n-m)L[n+m]+$centralCharge*KroneckerDelta[n+m,0]*(n^3-n)/12*id/;n>m
    },
    "Printing"->{
        L[n_]:>Subscript[L,n],
        Subscript[op_,n_]**Subscript[op_,n_]:>Subsuperscript[op,n,2],
        Subscript[op_,n_]**Subsuperscript[op_,n_,power_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power_]**Subscript[op_,n_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power1_]**Subsuperscript[op_,n_,power2_]:>Subsuperscript[op,n,power1+power2],
        $centralCharge->c
    }
|>//algebraAdd["LocalCA"];


"Relation"->{
    conjugate[L[n_]]:>L[-n]
}//algebraAdd["LocalCAIP"];


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vac},
    "Relation"->{
        L[_]**vac:>0
    },
    "Printing"->{
        vac:>Ket[{0}]
    }
|>//algebraAdd["Vacuum"];


"Relation"->{
    conjugate[vac]**vac:>1,
    conjugate[vac]**L[_]:>0
}//algebraAdd["VacuumIP"];


(* ::Subsubsection:: *)
(*Verma*)


<|
    "Generator"->{prim},
    "Relation"->{
        L[0]**prim[h_]:>h*prim[h],
        L[1]**prim[h_]:>0
    }
|>//algebraAdd["Verma"];


"Relation"->{
    conjugate[prim[h_]]**prim[h_]:>1,
    conjugate[prim[h_]]**L[-1]:>0
}//algebraAdd["VermaIP"];


(* ::Subsubsection:: *)
(*Verma: log*)


<|
    "Generator"->{prim},
    "Relation"->{
        (* Boundary condition *)
        prim[rank_,a_,h_]:>0/;a<=0,
        prim[rank_,a_,h_]:>0/;a>rank,
        (* Annihilation rule *)
        L[1]**prim[rank_,a_,h_]:>0
    }
|>//algebraAdd["VermaLog","VermaLogUpper","VermaLogLower"];


"Relation"->{
    conjugate[prim[rank_,a_,h_]]**prim[rank_,b_,h_]:>KroneckerDelta[a+b,rank+1],
    conjugate[prim[rank_,a_,h_]]**L[-1]:>0
}//algebraAdd["VermaLogIP"];


"Relation"->{
    L[0]**prim[rank_,a_,h_]:>h*prim[rank,a,h]+prim[rank,a+1,h]
}//algebraAdd["VermaLog","VermaLogUpper"];

"Relation"->{
    L[0]**prim[rank_,a_,h_]:>h*prim[rank,a,h]+prim[rank,a-1,h]
}//algebraAdd["VermaLogLower"];


(* ::Subsubsection:: *)
(*Verma: local*)


<|
    "Generator"->{prim},
    "Relation"->{
        L[0]**prim[h_]:>h*prim[h],
        L[n_]**prim[h_]:>0/;n>=1
    }
|>//algebraAdd["LocalVerma"];


"Relation"->{
    conjugate[prim[h_]]**prim[h_]:>1,
    conjugate[prim[h_]]**L[n_]:>0/;n<=-1
}//algebraAdd["LocalVermaIP"];


(* ::Subsubsection:: *)
(*Verma: local, log*)


<|
    "Generator"->{prim},
    "Relation"->{
        (* Boundary condition *)
        prim[rank_,a_,h_]:>0/;a<=0,
        prim[rank_,a_,h_]:>0/;a>rank,
        (* Annihilation rule *)
        L[n_]**prim[rank_,a_,h_]:>0/;n>=1
    }
|>//algebraAdd["LocalVermaLog","LocalVermaLogUpper","LocalVermaLogLower"];


"Relation"->{
    conjugate[prim[rank_,a_,h_]]**prim[rank_,b_,h_]:>KroneckerDelta[a+b,rank+1],
    conjugate[prim[rank_,a_,h_]]**L[n_]:>0/;n<=-1
}//algebraAdd["LocalVermaLogIP"];


"Relation"->{
    L[0]**prim[rank_,a_,h_]:>h*prim[rank,a,h]+prim[rank,a+1,h]
}//algebraAdd["LocalVermaLog","LocalVermaLogUpper"];

"Relation"->{
    L[0]**prim[rank_,a_,h_]:>h*prim[rank,a,h]+prim[rank,a-1,h]
}//algebraAdd["LocalVermaLogLower"];


(* ::Subsection:: *)
(*Constant*)


$CFT = <|
    "Index"->{-1,0,1},
    "L"->{L[-1],L[0],L[1]},
    "Casimir"->L[0]**L[0]-L[0]-L[-1]**L[1]
|>;


(* ::Subsection:: *)
(*Function*)


Lmonomial[] :=
    id;

Lmonomial[n_] :=
    L[n];

Lmonomial[n__] :=
    Map[L,NonCommutativeMultiply[n]];


Lpower[k_,n_Integer?NonNegative] :=
    operatorPower[L[k],n];


desc[h_,n_Integer?NonNegative] :=
    operatorPower[L[-1],n]**prim[h];

desc[rank_,a_,h_,n_Integer?NonNegative] :=
    operatorPower[L[-1],n]**prim[rank,a,h];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
