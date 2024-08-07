(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`SL2`"];


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


$algebraList = {"SL2","Verma-module","Verma-module-extension"};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


(* ::Subsubsection:: *)
(*SL2*)


<|
    operator->{x,y,h},
    relation->{
        commDefine[h,x,Reverse]->2x,
        commDefine[h,y]->-2y,
        commDefine[x,y]->h
    }
|>//algebraAdd["SL2"]


(* ::Subsubsection:: *)
(*Verma module*)


<|
    operator->{v},
    relation->{
        h**v[h_]:>h*v[h],
        x**v[h_]:>0,
        v[h_,n_]:>operatorPower[y,n]**v[h]
    },
    printing->{
        v[h_]:>Subscript[v,h]
    }
|>//algebraAdd["Verma-module"]


(* ::Subsubsection:: *)
(*Verma module extension*)


<|
    operator->{v},
    relation->{
        h**v[1,h_]:>h*v[1,h],
        x**v[1,h_]:>0,
        h**v[2,h_]:>(-h-2)*v[2,h],
        x**v[2,h_]:>ToExpression["a"]*operatorPower[y,h]**v[1,h],
        v[i_,h_,n_]:>operatorPower[y,n]**v[i,h]
    },
    printing->{
        v[i_,h_]:>Subscript[v,i,h]
    }
|>//algebraAdd["Verma-module-extension"]


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
