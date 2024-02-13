(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`CFT1`"];


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


$algebraList = 
    {"sl2","vacuum","singlet","multiplet","upperMultiplet","lowerMultiplet","staggered","staggered-at-X"};

algebraUnset@$algebraList//Quiet;
algebraDefine@$algebraList;


operator->{L}//algebraAdd[{"sl2"}];
operator->{vac}//algebraAdd[{"vacuum"}];
operator->{primary}//algebraAdd[{"singlet","multiplet","upperMultiplet","lowerMultiplet","staggered","staggered-at-X"}];


printing->{
    L[n_]:>Subsuperscript["L",n,1],
    Subsuperscript[op_,n_,a_]**Subsuperscript[op_,n_,b_]:>Subsuperscript[op,n,a+b]
}//algebraAdd[{"sl2"}];



(* ::Text:: *)
(*highest weight module*)


<|
	operator->{v},
	relation->{
		h**v[h_]:>h v[h],
		x**v[h_]:>0,
		v[h_,n_]:>operatorPower[y,n]**v[h]
	},
	printing->{
		v[h_]:>Subscript[v,h]
	}
|>//algebraAdd["highest-weight"];


(* ::Text:: *)
(*highest weight module extension*)


<|
	operator->{v},
	relation->{
		h**v[1,h_]:>h v[1,h],
		x**v[1,h_]:>0,
		h**v[2,h_]:>(-h-2)v[2,h],
		x**v[2,h_]:>Global`a operatorPower[y,h]**v[1,h],
		v[i_,h_,n_]:>operatorPower[y,n]**v[i,h]
	},
	printing->{
		v[i_,h_]:>Subscript[v,i,h]
	}
|>//algebraAdd["highest-weight-extension"]


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
