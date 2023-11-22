(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Common`"];


(*clear the state-dependent definitions.*)
ClearAll["`*"];


(* ::Section:: *)
(*Public*)


(* ::Subsection:: *)
(*Symbols*)


algebraCluster::usage = 
    "cluster algebra.";


$operatorCache::usage = 
    "operator cache.";
$operatorPatternCache::usage = 
    "operator pattern cache.";
$relationCache::usage = 
    "relation cache.";
$printingCache::usage = 
    "printing cache.";


(* ::Subsection:: *)
(*Utilities*)


stripPatternToExpr;
hideContextInRelation;


(* ::Section:: *)
(*Private*)


(* ::Subsection::Closed:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Symbols*)


$operatorCache = {};

$operatorPatternCache = _;

$relationCache = {};

$printingCache = {};


(* ::Subsection:: *)
(*Utilities*)


stripPatternToExpr[pattern_] :=
    pattern//.{
        (
            Verbatim[Pattern]|Verbatim[Optional]|
                Verbatim[PatternTest]|Verbatim[Condition]
        )[$$pattern_,_]:>$$pattern
    };

hideContextInRelation/:MakeBoxes[hideContextInRelation[expr_],form_] := 
    Block[ {Internal`$ContextMarks = False},
        MakeBoxes[expr,form]
    ];


(* ::Subsection::Closed:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
