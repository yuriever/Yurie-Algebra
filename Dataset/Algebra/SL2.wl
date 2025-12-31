(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


BeginPackage["Yurie`Algebra`SL2`"];


EndPackage[];


(* ::Section:: *)
(*Begin*)


BeginPackage["Global`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


h::usage =
    "operator: h.";

x::usage =
    "operator: x.";

y::usage =
    "operator: y.";

v::usage =
    "state.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


(* ::Text:: *)
(*X: annihilation *)
(*Y: creation*)
(*X>H>Y*)


algebraDefine["SL2","VermaModule","VermaModuleExtension"];


(* ::Subsubsection:: *)
(*SL2*)


<|
    "Generator"->{x,y,h},
    "Relation"->{
        commIn[h,x,Reverse]->2x,
        commIn[h,y]->-2y,
        commIn[x,y]->h
    }
|>//algebraAdd["SL2"];


(* ::Subsubsection:: *)
(*Verma module*)


<|
    "Generator"->{v},
    "Relation"->{
        h**v[h_]:>h*v[h],
        x**v[h_]:>0,
        v[h_,n_]:>operatorPower[y,n]**v[h]
    },
    "Printing"->{
        v[h_]:>Subscript[v,h]
    }
|>//algebraAdd["VermaModule"];


(* ::Subsubsection:: *)
(*Verma module extension*)


<|
    "Generator"->{v},
    "Relation"->{
        h**v[1,h_]:>h*v[1,h],
        x**v[1,h_]:>0,
        h**v[2,h_]:>(-h-2)*v[2,h],
        x**v[2,h_]:>ToExpression["a"]*operatorPower[y,h]**v[1,h],
        v[i_,h_,n_]:>operatorPower[y,n]**v[i,h]
    },
    "Printing"->{
        v[i_,h_]:>Subscript[v,i,h]
    }
|>//algebraAdd["VermaModuleExtension"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
