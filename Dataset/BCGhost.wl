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


ghostB::usage =
    "operator: b.";

ghostC::usage =
    "operator: c.";

vacuum::usage =
    "state: vacuum.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"bc","bc-vacuum"};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


(* ::Text:: *)
(*\[CapitalDelta][b]==h*)
(*\[CapitalDelta][c]==1-h*)


(* ::Subsubsection:: *)
(*Ghost algebra*)


<|
    operator->{ghostB,ghostC},
    relation->{
        commDefine[ghostB[h_,n_],ghostC[h_,m_],1]:>KroneckerDelta[n+m,0]*id/;n>=1-h,
        commDefine[ghostB[h_,n_],ghostC[h_,m_],1,Reverse]:>KroneckerDelta[n+m,0]*id/;n<1-h,
        commDefine[ghostB[h_,n_],ghostB[h_,m_],1]:>0/;n>m,
        commDefine[ghostC[h_,n_],ghostC[h_,m_],1]:>0/;n>m,
        ghostB[h_,n_]**ghostB[h_,n_]:>0,
        ghostC[h_,n_]**ghostC[h_,n_]:>0,
        conjugate[ghostB[h_,n_]]:>ghostB[h,-n],
        conjugate[ghostC[h_,n_]]:>ghostC[h,-n]
    },
    printing->{
        ghostB[h_,n_]:>Subscript["b",n],
        ghostC[h_,n_]:>Subscript["c",n]
    }
|>//algebraAdd["bc"]


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    operator->{vacuum},
    relation->{
        ghostB[h_,n_]**vacuum:>0/;n>=1-h,
        ghostC[h_,n_]**vacuum:>0/;n>=h,
        vacuum**ghostB[h_,n_]:>0/;n<=h-1,
        vacuum**ghostC[h_,n_]:>0/;n<=-h,
        conjugate[vacuum]->vacuum
    }
|>//algebraAdd["bc-vacuum"]


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
