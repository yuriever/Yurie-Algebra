(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Harmonic`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


cr::usage =
    "operator: creation.";

an::usage =
    "operator: annihilation.";

ket::usage =
    "state: vacuum.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"HO","vacuum"};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


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
        cr:>SuperDagger["a"],
        an:>"a"
    }
|>//algebraAdd["HO"]


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{ket},
    "Relation"->{
        conjugate[ket[n_]]:>ket[n],
        an**ket[n_]:>Sqrt[n]*ket[n-1],
        cr**ket[n_]:>Sqrt[n+1]*ket[n+1],
        ket[n_]**an:>Sqrt[n+1]*ket[n+1],
        ket[n_]**cr:>Sqrt[n]*ket[n-1],
        ket[n_]**ket[m_]:>KroneckerDelta[n,m]
    },
    "Printing"->{
        ket[n_]:>Ket[{n}]
    }
|>//algebraAdd["vacuum"]


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
