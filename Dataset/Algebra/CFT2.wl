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


$algebraList = {
    "ConformalAlgebra","ConformalAlgebraConjugate",
    "Virasoro","VirasoroConjugate",
    "Vacuum","VacuumConjugate",
    "Singlet","SingletConjugate"
};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


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
|>//algebraAdd["ConformalAlgebra"]


(* ::Subsubsection:: *)
(*Virasoro*)


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
|>//algebraAdd["Virasoro"]


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vac},
    "Relation"->{
        L[_]**vac:>0,
        Lb[_]**vac:>0,
        vac**L[_]:>0,
        vac**Lb[_]:>0
    },
    "Printing"->{
        vac:>Ket[{0}]
    }
|>//algebraAdd["Vacuum"]


(* ::Subsubsection:: *)
(*Singlet*)


<|
    "Generator"->{prim},
    "Relation"->{
        (*annihilation rule*)
        L[n_]**prim[h_,hb_]:>0/;n>=1,
        Lb[n_]**prim[h_,hb_]:>0/;n>=1,
        L[0]**prim[h_,hb_]:>h*prim[h,hb],
        Lb[0]**prim[h_,hb_]:>hb*prim[h,hb],
        prim[h_,hb_]**L[n_]:>0/;n<=-1,
        prim[h_,hb_]**Lb[n_]:>0/;n<=-1
    },
    "Printing"->{
        prim[h_,hb_]:>Ket[{h,hb}]
    }
|>//algebraAdd["Singlet"]


(* ::Subsubsection:: *)
(*Conjugate*)


"Relation"->{
    conjugate[L[n_]]:>L[-n],
    conjugate[Lb[n_]]:>Lb[-n]
}//algebraAdd["ConformalAlgebraConjugate","VirasoroConjugate"]


"Relation"->{
    vac**vac:>1,
    conjugate[vac]:>vac
}//algebraAdd["VacuumConjugate"]


"Relation"->{
    prim[h_,hb_]**prim[h_,hb_]:>1,
    conjugate[prim[h_,hb_]]:>prim[h,hb]
}//algebraAdd["SingletConjugate"]


(* ::Subsection:: *)
(*Constant*)


$CFT = <|
    "Index"->{-1,0,1},
    "L"->{L[-1],L[0],L[1]},
    "Lb"->{Lb[-1],Lb[0],Lb[1]},
    "LLb"->{L[-1],L[0],L[1],Lb[-1],Lb[0],Lb[1]},
    "Casimir"->(L[0]**L[0]-L[0]-L[-1]**L[1]),
    "Casimirb"->(Lb[0]**Lb[0]-Lb[0]-Lb[-1]**Lb[1])
|>;


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


Lpower[k_,n_Integer] :=
    operatorPower[L[k],n];


Lbpower[k_,n_Integer] :=
    operatorPower[Lb[k],n];


desc[h_,hb_,n_Integer,m_Integer] :=
    operatorPower[L[-1],n]**operatorPower[Lb[-1],m]**prim[h,hb];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
