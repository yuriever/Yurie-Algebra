(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`CCFT2`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


L::usage =
    "operator: L.";

M::usage =
    "operator: M.";

vacuum::usage =
    "state: vacuum.";

primary::usage =
    "state: primary.";

descendant::usage =
    "state: descendant.";


CCFT2::usage =
    "index list, generator list and Casimir element of the conformal algebra.";

$centralChargeL::usage =
    "BMS central charge c_L.";

$centralChargeM::usage =
    "BMS central charge c_M.";


Lmonomial::usage =
    "monomial of L.";

Mmonomial::usage =
    "monomial of M.";

Lpower::usage =
    "power of single L generator.";

Mpower::usage =
    "power of single M generator.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {
    "conformal-algebra","conformal-algebra-conjugate",
    "BMS","BMS-conjugate",
    "vacuum","vacuum-conjugate",
    "singlet","singlet-conjugate",
    "multiplet","multiplet-upper","multiplet-lower","multiplet-conjugate"
};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


(* ::Subsubsection:: *)
(*Conformal algebra*)


<|
    "Generator"->{L,M},
    "Relation"->{
        L[n_]**L[m_]:>L[m]**L[n]+(n-m)L[n+m]/;n>m,
        L[n_]**M[m_]:>M[m]**L[n]+(n-m)M[n+m]/;n>m,
        M[n_]**L[m_]:>L[m]**M[n]+(n-m)M[n+m]/;n>=m,
        M[n_]**M[m_]:>M[m]**M[n]/;n>m
    },
    "Printing"->{
        L[n_]:>Subscript["L",n],
        M[n_]:>Subscript["M",n],
        Subscript[op_,n_]**Subscript[op_,n_]:>Subsuperscript[op,n,2],
        Subscript[op_,n_]**Subsuperscript[op_,n_,power_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power_]**Subscript[op_,n_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power1_]**Subsuperscript[op_,n_,power2_]:>Subsuperscript[op,n,power1+power2]
    }
|>//algebraAdd["conformal-algebra"]


(* ::Subsubsection:: *)
(*BMS*)


<|
    "Generator"->{L,M},
    "Relation"->{
        L[n_]**L[m_]:>L[m]**L[n]+(n-m)L[n+m]+$centralChargeL*KroneckerDelta[n+m,0]*(n^3-n)/12*id/;n>m,
        L[n_]**M[m_]:>M[m]**L[n]+(n-m)M[n+m]+$centralChargeM*KroneckerDelta[n+m,0]*(n^3-n)/12*id/;n>m,
        M[n_]**L[m_]:>L[m]**M[n]+(n-m)M[n+m]+$centralChargeM*KroneckerDelta[n+m,0]*(n^3-n)/12*id/;n>=m,
        M[n_]**M[m_]:>M[m]**M[n]/;n>m
    },
    "Printing"->{
        L[n_]:>Subscript["L",n],
        M[n_]:>Subscript["M",n],
        Subscript[op_,n_]**Subscript[op_,n_]:>Subsuperscript[op,n,2],
        Subscript[op_,n_]**Subsuperscript[op_,n_,power_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power_]**Subscript[op_,n_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power1_]**Subsuperscript[op_,n_,power2_]:>Subsuperscript[op,n,power1+power2],
        $centralChargeL->Subscript["c","L"],
        $centralChargeM->Subscript["c","M"]
    }
|>//algebraAdd["BMS"]


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vacuum},
    "Relation"->{
        L[_]**vacuum:>0,
        M[_]**vacuum:>0,
        vacuum**L[_]:>0,
        vacuum**M[_]:>0
    }
|>//algebraAdd["vacuum"]


(* ::Subsubsection:: *)
(*Singlet*)


<|
    "Generator"->{primary},
    "Relation"->{
        (*annihilation rule*)
        L[n_]**primary[delta_,xi_]:>0/;n>=1,
        primary[delta_,xi_]**L[n_]:>0/;n<=-1,
        L[0]**primary[delta_,xi_]:>delta*primary[delta,xi],
        M[n_]**primary[delta_,xi_]:>0/;n>=1,
        primary[delta_,xi_]**M[n_]:>0/;n<=-1,
        M[0]**primary[delta_,xi_]:>xi*primary[delta,xi]
    }
|>//algebraAdd["singlet"]


(* ::Subsubsection:: *)
(*Multiplet*)


<|
    "Generator"->{primary},
    "Relation"->{
        (*boundary conditions*)
        primary[rank_,a_,delta_,xi_]:>0/;a<=0,
        primary[rank_,a_,delta_,xi_]:>0/;a>rank,
        (*annihilation rule*)
        L[n_]**primary[rank_,a_,delta_,xi_]:>0/;n>=1,
        primary[rank_,a_,delta_,xi_]**L[n_]:>0/;n<=-1,
        L[0]**primary[rank_,a_,delta_,xi_]:>delta*primary[rank,a,delta,xi],
        M[n_]**primary[rank_,a_,delta_,xi_]:>0/;n>=1,
        primary[rank_,a_,delta_,xi_]**M[n_]:>0/;n<=-1
    }
|>//algebraAdd["multiplet","multiplet-upper","multiplet-lower"]


(* ::Text:: *)
(*action of M[0]*)


"Relation"->{
    M[0]**primary[rank_,a_,delta_,xi_]:>xi*primary[rank,a,delta,xi]+primary[rank,a+1,delta,xi]
}//algebraAdd["multiplet","multiplet-upper"]

"Relation"->{
    M[0]**primary[rank_,a_,delta_,xi_]:>xi*primary[rank,a,delta,xi]+primary[rank,a-1,delta,xi]
}//algebraAdd["multiplet-lower"]


(* ::Subsubsection:: *)
(*Conjugation*)


"Relation"->{
    conjugate[L[n_]]:>L[-n],
    conjugate[M[n_]]:>M[-n]
}//algebraAdd["conformal-algebra-conjugate"]


"Relation"->{
    vacuum**vacuum->1,
    conjugate[vacuum]->vacuum
}//algebraAdd["vacuum-conjugate"]


"Relation"->{
    primary[delta_,xi_]**primary[delta_,xi_]:>1,
    conjugate[primary[delta_,xi_]]:>primary[delta,xi]
}//algebraAdd["singlet-conjugate"]


"Relation"->{
    primary[rank_,a_,delta_,xi_]**primary[rank_,b_,delta_,xi_]:>KroneckerDelta[a+b,rank+1],
    conjugate[primary[rank_,a_,delta_,xi_]]:>primary[rank,a,delta,xi]
}//algebraAdd["multiplet-conjugate"]


(* ::Subsection:: *)
(*Constant*)


CCFT2 = <|
    "Index"->{-1,0,1},
    "L"->{L[-1],L[0],L[1]},
    "M"->{M[-1],M[0],M[1]},
    "LM"->{L[-1],L[0],L[1],M[-1],M[0],M[1]},
    "Casimir1"->2(L[0]-1)**M[0]-L[-1]**M[1]-M[-1]**L[1],
    "Casimir2"->M[0]**M[0]-M[-1]**M[1]
|>;


(* ::Subsection:: *)
(*Function*)


Lmonomial[] :=
    1;

Lmonomial[n_] :=
    L[n];

Lmonomial[n_,m__] :=
    Lmonomial[n]**Lmonomial[m];


Mmonomial[] :=
    1;

Mmonomial[n_] :=
    L[n];

Mmonomial[n_,m__] :=
    Mmonomial[n]**Mmonomial[m];


Lpower[k_,n_Integer] :=
    operatorPower[L[k],n];


Mpower[k_,n_Integer] :=
    operatorPower[M[k],n];


descendant[delta_,xi_,n_Integer,m_Integer] :=
    operatorPower[L[-1],n]**operatorPower[M[-1],m]**primary[delta,xi];

descendant[rank_,a_,delta_,xi_,n_Integer,m_Integer] :=
    operatorPower[L[-1],n]**operatorPower[M[-1],m]**primary[rank,a,delta,xi];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
