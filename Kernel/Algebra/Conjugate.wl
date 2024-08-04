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
    "inner product of two operators.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


innerProduct[x_,y_] :=
    conjugate[x]**y;

innerProduct[x_] :=
    conjugate[x]**x;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
