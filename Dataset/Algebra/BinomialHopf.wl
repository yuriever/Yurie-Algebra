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


x::usage =
    "operator.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"BinomialHopf"};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


(* ::Subsubsection:: *)
(*BinomialHopf*)


<|
    "Generator"->{
        x[_]
    },
    "Relation"->{
        x[0]->id,
        x[n_]**x[m_]:>x[n+m],
        comultiply[x[n_]]:>
            Sum[Binomial[n,i]*tensor[x[i],x[n-i]],{i,0,n}],
        counit[x[n_]]:>KroneckerDelta[n,0],
        antipode[x[n_]]:>(-1)^n*x[n]
    },
    "Printing"->{
        x[n_]:>Power[x,n]
    }
|>//algebraAdd["BinomialHopf"]


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
