(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Info`"];


(* ::Section:: *)
(*Public*)


$thisPacletDir;
$thisKernelDir;
$thisTestDir;


(* ::Section:: *)
(*Private*)


(* ::Subsection::Closed:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


$thisPaclet = 
    PacletObject["Yurie/Algebra"];
    
$thisPacletDir = 
    $thisPaclet["Location"];

$thisKernelDir = 
    FileNameJoin@{$thisPacletDir,"Kernel"};

$thisTestDir = 
    $thisPaclet["AssetLocation","Test"];


(* ::Subsection::Closed:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
