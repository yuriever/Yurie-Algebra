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


cr::usage =
    "operator: creation.";

an::usage =
    "operator: annihilation.";

bra::usage =
    "state: out.";

ket::usage =
    "state: in.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"HarmonicOscillator","Vacuum"};

$algebraList//algebraUnset//Quiet;

$algebraList//algebraDefine;


(* ::Subsubsection:: *)
(*Boson and fermion*)


<|
    "Generator"->{an,cr},
    "Relation"->{
        commDefine[an,cr]:>id,
        conjugate[cr]:>an,
        conjugate[an]:>cr
    },
    "Printing"->{
        cr:>SuperDagger[ToExpression["a"]],
        an:>ToExpression["a"]
    }
|>//algebraAdd["HarmonicOscillator"];


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{ket},
    "Relation"->{
        an**ket[n_]:>Sqrt[n]*ket[n-1],
        cr**ket[n_]:>Sqrt[n+1]*ket[n+1],
        bra[n_]**an:>Sqrt[n+1]*ket[n+1],
        bra[n_]**cr:>Sqrt[n]*ket[n-1],
        bra[n_]**ket[m_]:>KroneckerDelta[n,m],
        conjugate[bra[n_]]:>ket[n],
        conjugate[ket[n_]]:>bra[n]
    },
    "Printing"->{
        bra[n_]:>Bra[{n}],
        ket[n_]:>Ket[{n}]
    }
|>//algebraAdd["Vacuum"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
