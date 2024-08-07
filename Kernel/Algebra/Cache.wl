(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Cache`"];


(*clear the state-dependent definitions.*)
ClearAll["`*"];


(* ::Section:: *)
(*Public*)


algebraCluster::usage =
    "cluster algebra.";

$operator::usage =
    "operator cache.";

$operatorPattern::usage =
    "operator pattern cache.";

$relation::usage =
    "relation cache.";

$printing::usage =
    "printing cache.";


$tensorRank::usage =
    "tensor-rank of generators.";


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


$tensorRank[_] = 1;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
