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


expectationValue::usage =
	"expectation value of the operator under the states."


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


expectationValue[x_][y_]:=
	conjugate[x]**y**x;

expectationValue[x_,y_][z_]:=
	conjugate[x]**z**y;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
