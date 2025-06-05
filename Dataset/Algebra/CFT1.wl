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

vacuum::usage =
    "state: vacuum.";

primary::usage =
    "state: primary.";

descendant::usage =
    "state: descendant.";


CFT1::usage =
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


$algebraList = {
    "ConformalAlgebra","ConformalAlgebraConjugate",
    "Virasoro","VirasoroConjugate",
    "Vacuum","VacuumConjugate",
    "Singlet","SingletConjugate",
    "Multiplet","MultipletUpper","MultipletLower","MultipletConjugate"
};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


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
|>//algebraAdd["ConformalAlgebra"]


(* ::Subsubsection:: *)
(*Virasoro*)


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
|>//algebraAdd["Virasoro"]


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vacuum},
    "Relation"->{
        L[_]**vacuum:>0,
        vacuum**L[_]:>0
    }
|>//algebraAdd["Vacuum"]


(* ::Subsubsection:: *)
(*Singlet*)


<|
    "Generator"->{primary},
    "Relation"->{
        (*annihilation rule*)
        L[n_]**primary[h_]:>0/;n>=1,
        primary[h_]**L[n_]:>0/;n<=-1,
        L[0]**primary[h_]:>h*primary[h]
    }
|>//algebraAdd["Singlet"]


(* ::Subsubsection:: *)
(*Multiplet*)


<|
    "Generator"->{primary},
    "Relation"->{
        (*boundary condition*)
        primary[rank_,a_,h_]:>0/;a<=0,
        primary[rank_,a_,h_]:>0/;a>rank,
        (*annihilation rule*)
        L[n_]**primary[rank_,a_,h_]:>0/;n>=1,
        primary[rank_,a_,h_]**L[n_]:>0/;n<=-1
    }
|>//algebraAdd["Multiplet","MultipletUpper","MultipletLower"]


(* ::Text:: *)
(*action of L[0]*)


"Relation"->{
    L[0]**primary[rank_,a_,h_]:>h*primary[rank,a,h]+primary[rank,a+1,h]
}//algebraAdd["Multiplet","MultipletUpper"]

"Relation"->{
    L[0]**primary[rank_,a_,h_]:>h*primary[rank,a,h]+primary[rank,a-1,h]
}//algebraAdd["MultipletLower"]


(* ::Subsubsection:: *)
(*Conjugation*)


"Relation"->{
    conjugate[L[n_]]:>L[-n]
}//algebraAdd["ConformalAlgebraConjugate","VirasoroConjugate"]


"Relation"->{
    vacuum**vacuum->1,
    conjugate[vacuum]->vacuum
}//algebraAdd["VacuumConjugate"]


"Relation"->{
    primary[h_]**primary[h_]:>1,
    conjugate[primary[h_]]:>primary[h]
}//algebraAdd["SingletConjugate"]


"Relation"->{
    primary[rank_,a_,h_]**primary[rank_,b_,h_]:>KroneckerDelta[a+b,rank+1],
    conjugate[primary[rank_,a_,h_]]:>primary[rank,a,h]
}//algebraAdd["MultipletConjugate"]


(* ::Subsection:: *)
(*Constant*)


CFT1 = <|
    "Index"->{-1,0,1},
    "L"->{L[-1],L[0],L[1]},
    "Casimir"->(L[0]**L[0]-L[0]-L[-1]**L[1])
|>;


(* ::Subsection:: *)
(*Function*)


Lmonomial[] :=
    1;

Lmonomial[n_] :=
    L[n];

Lmonomial[n_,m__] :=
    Lmonomial[n]**Lmonomial[m];


Lpower[k_,n_Integer] :=
    operatorPower[L[k],n];


descendant[h_,n_Integer] :=
    operatorPower[L[-1],n]**primary[h];

descendant[rank_,a_,h_,n_Integer] :=
    operatorPower[L[-1],n]**primary[rank,a,h];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
