(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Cache`"];


(*clear the state-dependent definitions.*)
ClearAll["`*"];


(* ::Section:: *)
(*Public*)


$operatorCache::usage = 
    "operator cache.";
$operatorPatternCache::usage = 
    "operator pattern cache.";
$relationCache::usage = 
    "relation cache.";
$printingCache::usage = 
    "printing cache.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Symbols*)


$operatorCache = {};

$operatorPatternCache = _;

$relationCache = {};

$printingCache = {};


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
