(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Conjugate`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


conjugate::usage =
    "conjugate of the operator.";


innerProduct::usage =
    "inner product of the states.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


innerProduct[x_] :=
    conjugate[x]**x;

innerProduct[x_,y_] :=
    conjugate[x]**y;

innerProduct[x_,y_,z_] :=
    conjugate[x]**y**z;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
