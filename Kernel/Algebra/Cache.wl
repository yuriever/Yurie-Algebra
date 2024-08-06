(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Cache`"];


(*clear the state-dependent definitions.*)
ClearAll["`*"];


(* ::Section:: *)
(*Public*)


$operator::usage =
    "operator cache.";

$operatorPattern::usage =
    "operator pattern cache.";

$relation::usage =
    "relation cache.";

$printing::usage =
    "printing cache.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


$operator = {};

$operatorPattern = _;

$relation = {};

$printing = {};


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
