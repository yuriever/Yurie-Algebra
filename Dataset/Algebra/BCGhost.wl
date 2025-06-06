(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Global`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


b::usage =
    "operator: b ghost.";

c::usage =
    "operator: c ghost.";

vac::usage =
    "state: vacuum.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"BCGhost","Vacuum"};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


(* ::Text:: *)
(*h[b]==h*)
(*h[c]==1-h*)


(* ::Subsubsection:: *)
(*Ghost algebra*)


<|
    "Generator"->{b,c},
    "Relation"->{
        commDefine[b[h_,n_],c[h_,m_],1]:>KroneckerDelta[n+m,0]*id/;n>=1-h,
        commDefine[b[h_,n_],c[h_,m_],1,Reverse]:>KroneckerDelta[n+m,0]*id/;n<1-h,
        commDefine[b[h_,n_],b[h_,m_],1]:>0/;n>m,
        commDefine[c[h_,n_],c[h_,m_],1]:>0/;n>m,
        b[h_,n_]**b[h_,n_]:>0,
        c[h_,n_]**c[h_,n_]:>0,
        conjugate[b[h_,n_]]:>b[h,-n],
        conjugate[c[h_,n_]]:>c[h,-n]
    },
    "Printing"->{
        b[h_,n_]:>Subscript[ToExpression["b"],n],
        c[h_,n_]:>Subscript[ToExpression["c"],n]
    }
|>//algebraAdd["BCGhost"]


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vac},
    "Relation"->{
        b[h_,n_]**vac:>0/;n>=1-h,
        c[h_,n_]**vac:>0/;n>=h,
        vac**b[h_,n_]:>0/;n<=h-1,
        vac**c[h_,n_]:>0/;n<=-h,
        conjugate[vac]:>vac
    },
    "Printing"->{
        vac:>Ket[{0}]
    }
|>//algebraAdd["Vacuum"]


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
