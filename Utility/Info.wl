(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Info`"];


(* ::Section:: *)
(*Public*)


(* ::Subsection:: *)
(*Symbols*)


$thisPacletDir;
$thisSampleDir;
$thisTestDir;

$thisLibraryName;
$thisLibrary;
$thisLibrarySourceDir;
$thisLibraryDir;


(* ::Section:: *)
(*Private*)


(* ::Subsection::Closed:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Symbols*)


$thisPaclet = 
    PacletObject["Yurie/Algebra"];
    
$thisPacletDir = 
    $thisPaclet["Location"];

$thisSampleDir = 
    $thisPaclet["AssetLocation","Sample"];

$thisTestDir = 
    $thisPaclet["AssetLocation","Test"];


$thisLibraryName = 
    "Library";

$thisLibrarySourceDir = 
    $thisPaclet["AssetLocation","LibrarySource"];

$thisLibraryDir = 
    FileNameJoin@{$thisPaclet["AssetLocation","Library"],$SystemID};

$thisLibrary = 
    FileNameJoin@{$thisLibraryDir,$thisLibraryName<>"."<>Internal`DynamicLibraryExtension[]}


(* ::Subsection::Closed:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
