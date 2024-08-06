(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Sweedler`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


g::usage =
    "operator: g.";

x::usage =
	"operator: x.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"Sweedler"};

$algebraList//algebraUnset//Quiet;

$algebraList//algebraDefine;


<|
	operator->{g,x},
	relation->{
		commDefine[g,x,Reverse,1]:>0,
		x**x:>0,
		g**g:>1,
		comultiply[g]:>tensor[g,g],
		comultiply[x]:>tensor[g,x]+tensor[x,1]
	},
	printing->{}
|>//algebraAdd["Sweedler"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
