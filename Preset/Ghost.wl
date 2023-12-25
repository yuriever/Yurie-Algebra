(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Ghost`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


vac::usage = 
    "state: vacuum.";

ghostB::usage = 
	"operator: b.";

ghostC::usage = 
	"operator: c.";


(* ::Section:: *)
(*Private*)


(* ::Subsection::Closed:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebras*)


$algebraList = 
    {"bc","bc-vacuum","bc-conjugate"};

algebraUnset@$algebraList//Quiet;
algebraDefine@$algebraList;


(* ::Text:: *)
(*\[CapitalDelta][b]==h*)
(*\[CapitalDelta][c]==1-h*)


(* ::Text:: *)
(*bc-ghost algebra*)


<|
	operator->{ghostB,ghostC},
	relation->{
		commDefine[ghostB[h_,n_],ghostC[h_,m_],1]:>KroneckerDelta[n+m,0]/;n>=1-h,
		commDefine[ghostB[h_,n_],ghostC[h_,m_],1,Reverse]:>KroneckerDelta[n+m,0]/;n<1-h,
		commDefine[ghostB[h_,n_],ghostB[h_,m_],1]:>0/;n>m,
		commDefine[ghostC[h_,n_],ghostC[h_,m_],1]:>0/;n>m,
		ghostB[h_,n_]**ghostB[h_,n_]:>0,
		ghostC[h_,n_]**ghostC[h_,n_]:>0
	},
	printing->{
		ghostB[h_,n_]:>Subscript["b",n],
		ghostC[h_,n_]:>Subscript["c",n]
	}
|>//algebraAdd["bc"];

<|
	operator->{vac(*,up,down*)},
	relation->{
		(*b[h_,0]**down:>0,
		b[h_,0]**up:>down,
		c[h_,0]**down:>up,
		c[h_,0]**up:>0,
		(op:(b|c))[n_]**(state:(up|down)):>0/;n>=1,*)
		ghostB[h_,n_]**vac:>0/;n>=1-h,
		ghostC[h_,n_]**vac:>0/;n>=h,
		vac**ghostB[h_,n_]:>0/;n<=h-1,
		vac**ghostC[h_,n_]:>0/;n<=-h
	}
|>//algebraAdd["bc-vacuum"]

relation->{
	SuperDagger@vac:>vac,
	SuperDagger@ghostB[h_,n_]:>ghostB[h,-n],
	SuperDagger@ghostC[h_,n_]:>ghostC[h,-n]
}//algebraAdd["bc-conjugate"]


(* ::Subsection::Closed:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
