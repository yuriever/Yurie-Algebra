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
    "CA","CAIP",
    (*  *)
    "Verma","VermaIP",
    "VermaM0","VermaM0Upper","VermaM0Lower","VermaM0IP",
    (*  *)
    "LocalCA","LocalCAIP",
    "LocalVerma","LocalVermaIP",
    "LocalVermaM0","LocalVermaM0Upper","LocalVermaM0Lower","LocalVermaM0IP",
    (*  *)
    "Vacuum","VacuumIP"
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
|>//algebraAdd["CA"];


"Relation"->{
    conjugate[L[n_]]:>L[-n],
    conjugate[M[n_]]:>M[-n]
}//algebraAdd["CAIP"];


(* ::Subsubsection:: *)
(*Conformal algebra: local*)


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
|>//algebraAdd["LocalCA"];


"Relation"->{
    conjugate[L[n_]]:>L[-n],
    conjugate[M[n_]]:>M[-n]
}//algebraAdd["LocalCAIP"];


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vac},
    "Relation"->{
        L[_]**vac:>0,
        M[_]**vac:>0
    },
    "Printing"->{
        vac:>Ket[{0}]
    }
|>//algebraAdd["Vacuum"];


"Relation"->{
    conjugate[vac]**vac:>1,
    conjugate[vac]**L[_]:>0,
    conjugate[vac]**M[_]:>0
}//algebraAdd["VacuumIP"];


(* ::Subsubsection:: *)
(*Verma*)


<|
    "Generator"->{prim},
    "Relation"->{
        L[0]**prim[h_,ξ_]:>h*prim[h,ξ],
        M[0]**prim[h_,ξ_]:>ξ*prim[h,ξ],
        L[1]**prim[h_,ξ_]:>0,
        M[1]**prim[h_,ξ_]:>0
    }
|>//algebraAdd["Verma"];


"Relation"->{
    conjugate[prim[h_,ξ_]]**prim[h_,ξ_]:>1,
    conjugate[prim[h_,ξ_]]**L[-1]:>0,
    conjugate[prim[h_,ξ_]]**M[-1]:>0
}//algebraAdd["VermaIP"];


(* ::Subsubsection:: *)
(*Verma: ξ-multiplet*)


<|
    "Generator"->{prim},
    "Relation"->{
        (* Boundary condition *)
        prim[rank_,a_,h_,ξ_]:>0/;a<=0,
        prim[rank_,a_,h_,ξ_]:>0/;a>rank,
        (* Annihilation rule *)
        L[0]**prim[rank_,a_,h_,ξ_]:>h*prim[rank,a,h,ξ],
        L[1]**prim[rank_,a_,h_,ξ_]:>0,
        M[1]**prim[rank_,a_,h_,ξ_]:>0
    }
|>//algebraAdd["VermaM0","VermaM0Upper","VermaM0Lower"];


"Relation"->{
    conjugate[prim[rank_,a_,h_,ξ_]]**prim[rank_,b_,h_,ξ_]:>KroneckerDelta[a+b,rank+1],
    conjugate[prim[rank_,a_,h_,ξ_]]**L[-1]:>0,
    conjugate[prim[rank_,a_,h_,ξ_]]**M[-1]:>0
}//algebraAdd["VermaM0IP"];


"Relation"->{
    M[0]**prim[rank_,a_,h_,ξ_]:>ξ*prim[rank,a,h,ξ]+prim[rank,a+1,h,ξ]
}//algebraAdd["VermaM0","VermaM0Upper"];

"Relation"->{
    M[0]**prim[rank_,a_,h_,ξ_]:>ξ*prim[rank,a,h,ξ]+prim[rank,a-1,h,ξ]
}//algebraAdd["VermaM0Lower"];


(* ::Subsubsection:: *)
(*Verma: local*)


<|
    "Generator"->{prim},
    "Relation"->{
        L[0]**prim[h_,ξ_]:>h*prim[h,ξ],
        M[0]**prim[h_,ξ_]:>ξ*prim[h,ξ],
        L[n_]**prim[h_,ξ_]:>0/;n>=1,
        M[n_]**prim[h_,ξ_]:>0/;n>=1
    }
|>//algebraAdd["LocalVerma"];


"Relation"->{
    conjugate[prim[h_,ξ_]]**prim[h_,ξ_]:>1,
    conjugate[prim[h_,ξ_]]**L[n_]:>0/;n<=-1,
    conjugate[prim[h_,ξ_]]**M[n_]:>0/;n<=-1
}//algebraAdd["LocalVermaIP"];


(* ::Subsubsection:: *)
(*Verma: local, ξ-multiplet*)


<|
    "Generator"->{prim},
    "Relation"->{
        (* Boundary condition *)
        prim[rank_,a_,h_,ξ_]:>0/;a<=0,
        prim[rank_,a_,h_,ξ_]:>0/;a>rank,
        (* Annihilation rule *)
        L[0]**prim[rank_,a_,h_,ξ_]:>h*prim[rank,a,h,ξ],
        L[n_]**prim[rank_,a_,h_,ξ_]:>0/;n>=1,
        M[n_]**prim[rank_,a_,h_,ξ_]:>0/;n>=1
    }
|>//algebraAdd["LocalVermaM0","LocalVermaM0Upper","LocalVermaM0Lower"];


"Relation"->{
    conjugate[prim[rank_,a_,h_,ξ_]]**prim[rank_,b_,h_,ξ_]:>KroneckerDelta[a+b,rank+1],
    conjugate[prim[rank_,a_,h_,ξ_]]**L[n_]:>0/;n<=-1,
    conjugate[prim[rank_,a_,h_,ξ_]]**M[n_]:>0/;n<=-1
}//algebraAdd["LocalVermaM0IP"];


"Relation"->{
    M[0]**prim[rank_,a_,h_,ξ_]:>ξ*prim[rank,a,h,ξ]+prim[rank,a+1,h,ξ]
}//algebraAdd["LocalVermaM0","LocalVermaM0Upper"];

"Relation"->{
    M[0]**prim[rank_,a_,h_,ξ_]:>ξ*prim[rank,a,h,ξ]+prim[rank,a-1,h,ξ]
}//algebraAdd["LocalVermaM0Lower"];


(* ::Subsection:: *)
(*Constant*)


$CarCFT = <|
    "Index"->{-1,0,1},
    "L"->{L[-1],L[0],L[1]},
    "M"->{M[-1],M[0],M[1]},
    "LM"->{L[-1],L[0],L[1],M[-1],M[0],M[1]},
    "Casimir1"->2(L[0]-id)**M[0]-L[-1]**M[1]-M[-1]**L[1],
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


Lpower[k_,n_Integer?NonNegative] :=
    operatorPower[L[k],n];


Mpower[k_,n_Integer?NonNegative] :=
    operatorPower[M[k],n];


desc[h_,ξ_,n_Integer?NonNegative,m_Integer?NonNegative] :=
    operatorPower[L[-1],n]**operatorPower[M[-1],m]**prim[h,ξ];

desc[rank_,a_,h_,ξ_,n_Integer?NonNegative,m_Integer?NonNegative] :=
    operatorPower[L[-1],n]**operatorPower[M[-1],m]**prim[rank,a,h,ξ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
