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


g::usage =
    "operator: g.";

x::usage =
    "operator: x.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


algebraDefine["Sweedler"];


<|
    "Generator"->{g,x},
    "Relation"->{
        commIn[g,x,Reverse,1]->0,
        x**x:>0,
        g**g:>id,
        comultiply[g]:>tensor[g,g],
        comultiply[x]:>tensor[g,x]+tensor[x,id],
        counit[g]:>1,
        counit[x]:>0,
        antipode[g]:>g,
        antipode[x]:>-g**x
    }
|>//algebraAdd["Sweedler"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
