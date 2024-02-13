(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`BCGhost`"];


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


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = 
    {"bc","bc-vacuum"};

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
        ghostC[h_,n_]**ghostC[h_,n_]:>0,
        SuperDagger@ghostB[h_,n_]:>ghostB[h,-n],
	    SuperDagger@ghostC[h_,n_]:>ghostC[h,-n]
    },
    printing->{
        ghostB[h_,n_]:>Subscript["b",n],
        ghostC[h_,n_]:>Subscript["c",n]
    }
|>//algebraAdd["bc"];

<|
    operator->{vac},
    relation->{
        ghostB[h_,n_]**vac:>0/;n>=1-h,
        ghostC[h_,n_]**vac:>0/;n>=h,
        vac**ghostB[h_,n_]:>0/;n<=h-1,
        vac**ghostC[h_,n_]:>0/;n<=-h,
        SuperDagger@vac:>vac
    }
|>//algebraAdd["bc-vacuum"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
