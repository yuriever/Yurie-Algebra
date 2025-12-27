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

M::usage =
    "operator: M.";

vac::usage =
    "state: vacuum.";

prim::usage =
    "state: primary.";

desc::usage =
    "state: descendant.";


$CarCFT::usage =
    "index list, generator list and Casimir element of the conformal algebra.";

$centralChargeL::usage =
    "central charge: c_L.";

$centralChargeM::usage =
    "central charge: c_M.";


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
    "ConformalAlgebra","ConformalAlgebraConjugate",
    "CALocal","CALocalConjugate",
    "Vacuum","VacuumConjugate",
    "Singlet","SingletConjugate",
    "Multiplet","MultipletUpper","MultipletLower","MultipletConjugate"
};

$algebraList//algebraUnset//Quiet;

$algebraList//algebraDefine;


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
        L[n_]:>Subscript[L,n],
        M[n_]:>Subscript[M,n],
        Subscript[op_,n_]**Subscript[op_,n_]:>Subsuperscript[op,n,2],
        Subscript[op_,n_]**Subsuperscript[op_,n_,power_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power_]**Subscript[op_,n_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power1_]**Subsuperscript[op_,n_,power2_]:>Subsuperscript[op,n,power1+power2]
    }
|>//algebraAdd["ConformalAlgebra"];


"Relation"->{
    conjugate[L[n_]]:>L[-n],
    conjugate[M[n_]]:>M[-n]
}//algebraAdd["ConformalAlgebraConjugate"];


(* ::Subsubsection:: *)
(*CALocal*)


<|
    "Generator"->{L,M},
    "Relation"->{
        L[n_]**L[m_]:>L[m]**L[n]+(n-m)L[n+m]+$centralChargeL*KroneckerDelta[n+m,0]*(n^3-n)/12*id/;n>m,
        L[n_]**M[m_]:>M[m]**L[n]+(n-m)M[n+m]+$centralChargeM*KroneckerDelta[n+m,0]*(n^3-n)/12*id/;n>m,
        M[n_]**L[m_]:>L[m]**M[n]+(n-m)M[n+m]+$centralChargeM*KroneckerDelta[n+m,0]*(n^3-n)/12*id/;n>=m,
        M[n_]**M[m_]:>M[m]**M[n]/;n>m
    },
    "Printing"->{
        L[n_]:>Subscript[L,n],
        M[n_]:>Subscript[M,n],
        Subscript[op_,n_]**Subscript[op_,n_]:>Subsuperscript[op,n,2],
        Subscript[op_,n_]**Subsuperscript[op_,n_,power_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power_]**Subscript[op_,n_]:>Subsuperscript[op,n,power+1],
        Subsuperscript[op_,n_,power1_]**Subsuperscript[op_,n_,power2_]:>Subsuperscript[op,n,power1+power2],
        $centralChargeL->Subscript[c,L],
        $centralChargeM->Subscript[c,M]
    }
|>//algebraAdd["CALocal"];


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vac},
    "Relation"->{
        L[_]**vac:>0,
        M[_]**vac:>0,
        vac**L[_]:>0,
        vac**M[_]:>0
    },
    "Printing"->{
        vac:>Ket[{0}]
    }
|>//algebraAdd["Vacuum"];


(* ::Subsubsection:: *)
(*Singlet*)


<|
    "Generator"->{prim},
    "Relation"->{
        (*annihilation rule*)
        L[n_]**prim[h_,ξ_]:>0/;n>=1,
        M[n_]**prim[h_,ξ_]:>0/;n>=1,
        L[0]**prim[h_,ξ_]:>h*prim[h,ξ],
        M[0]**prim[h_,ξ_]:>ξ*prim[h,ξ],
        prim[h_,ξ_]**L[n_]:>0/;n<=-1,
        prim[h_,ξ_]**M[n_]:>0/;n<=-1
    },
    "Printing"->{
        prim[h_,ξ_]:>Ket[{h,ξ}]
    }
|>//algebraAdd["Singlet"];


(* ::Subsubsection:: *)
(*Multiplet*)


<|
    "Generator"->{prim},
    "Relation"->{
        (*boundary conditions*)
        prim[rank_,a_][h_,ξ_]:>0/;a<=0,
        prim[rank_,a_][h_,ξ_]:>0/;a>rank,
        (*annihilation rule*)
        L[n_]**prim[rank_,a_][h_,ξ_]:>0/;n>=1,
        prim[rank_,a_][h_,ξ_]**L[n_]:>0/;n<=-1,
        L[0]**prim[rank_,a_][h_,ξ_]:>h*prim[rank,a][h,ξ],
        M[n_]**prim[rank_,a_][h_,ξ_]:>0/;n>=1,
        prim[rank_,a_][h_,ξ_]**M[n_]:>0/;n<=-1
    },
    "Printing"->{
        prim[rank_,a_][h_,ξ_]:>Subsuperscript[Ket[{h,ξ}],rank,a]
    }
|>//algebraAdd["Multiplet","MultipletUpper","MultipletLower"];


(* ::Text:: *)
(*action of M[0]*)


"Relation"->{
    M[0]**prim[rank_,a_][h_,ξ_]:>ξ*prim[rank,a][h,ξ]+prim[rank,a+1][h,ξ]
}//algebraAdd["Multiplet","MultipletUpper"];

"Relation"->{
    M[0]**prim[rank_,a_][h_,ξ_]:>ξ*prim[rank,a][h,ξ]+prim[rank,a-1][h,ξ]
}//algebraAdd["MultipletLower"];


(* ::Subsubsection:: *)
(*Conjugate*)


"Relation"->{
    vac**vac:>1,
    conjugate[vac]:>vac
}//algebraAdd["VacuumConjugate"];


"Relation"->{
    prim[h_,ξ_]**prim[h_,ξ_]:>1,
    conjugate[prim[h_,ξ_]]:>prim[h,ξ]
}//algebraAdd["SingletConjugate"];


"Relation"->{
    prim[rank_,a_][h_,ξ_]**prim[rank_,b_][h_,ξ_]:>KroneckerDelta[a+b,rank+1],
    conjugate[prim[rank_,a_][h_,ξ_]]:>prim[rank,a][h,ξ]
}//algebraAdd["MultipletConjugate"];


(* ::Subsection:: *)
(*Constant*)


$CarCFT = <|
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
    id;

Lmonomial[n_] :=
    L[n];

Lmonomial[n__] :=
    Map[L,NonCommutativeMultiply[n]];


Mmonomial[] :=
    1;

Mmonomial[n_] :=
    M[n];

Mmonomial[n__] :=
    Map[M,NonCommutativeMultiply[n]];


Lpower[k_,n_Integer] :=
    operatorPower[L[k],n];


Mpower[k_,n_Integer] :=
    operatorPower[M[k],n];


desc[h_,ξ_,n_Integer,m_Integer] :=
    operatorPower[L[-1],n]**operatorPower[M[-1],m]**prim[h,ξ];

desc[rank_,a_,h_,ξ_,n_Integer,m_Integer] :=
    operatorPower[L[-1],n]**operatorPower[M[-1],m]**prim[rank,a,h,ξ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
