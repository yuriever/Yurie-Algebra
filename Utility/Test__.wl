(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Test`"];


Needs["Yurie`Algebra`Info`"];


(* ::Section:: *)
(*Public*)


getReport;


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Functions*)


getReport[] :=
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


getReport[];
