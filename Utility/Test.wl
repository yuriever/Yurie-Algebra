(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Test`"];


Needs["Yurie`Algebra`Info`"];


(* ::Section:: *)
(*Public*)


testReport::usage = 
    "get the report of unit test.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


testReport[] :=
    Module[ {report},
        report = 
            TestReport@FileNames["*.wlt",$thisTestDir];
        CellPrint@{
            ExpressionCell[report["ResultsByOutcome"]//Map[Column]//TabView,"Output"]
        };
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
