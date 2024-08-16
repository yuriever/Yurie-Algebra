(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`TrigHopf`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


c::usage =
    "operator: c.";

s::usage =
    "operator: s.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"TrigHopf"};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


<|
    operator->{c,s},
    relation->{
	    s**s->id-c**c,
	    c**s->s**c,
		comultiply[c]->tensor[c,c]-tensor[s,s],
		comultiply[s]->tensor[c,s]+tensor[s,c],
		counit[c]->1,
		counit[s]->0,
		antipode[c]->c,
		antipode[s]->-s
    },
    printing->{}
|>//algebraAdd["TrigHopf"]


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
