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


SL2Index::usage =
    "indices of global symmetry.";

SL2Generator::usage =
    "set of generators.";

SL2Casimir::usage =
    "Casimir element.";


L::usage =
    "L generator.";

vac::usage =
    "vacuum state.";

primary::usage =
    "primary state.";

descendant::usage =
    "descendant state.";


Lmonomial::usage =
    "monomial of L.";

Lpower::usage =
    "power of single L generator.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"SL2","SL2-conjugate","vacuum","singlet","singlet-conjugate","multiplet","multiplet-upper","multiplet-lower","multiplet-conjugate"};

$algebraList//algebraUnset//Quiet;

$algebraList//algebraDefine;


(* ::Subsubsection:: *)
(*SL2*)


<|
	operator->{L},
	relation->{
	    L[n_]**L[m_]:>L[m]**L[n]+(n-m)L[n+m]/;n>m
	},
	printing->{
	    L[n_]:>Subsuperscript["L",n,1],
	    Subsuperscript[op_,n_,a_]**Subsuperscript[op_,n_,b_]:>Subsuperscript[op,n,a+b]
	}
|>//algebraAdd["SL2"];


(* ::Subsubsection:: *)
(*Vacuum*)


<|
	operator->{vac},
	relation->{
	    L[_]**vac:>0,
	    vac**L[_]:>0
	}
|>//algebraAdd["vacuum"];


(* ::Subsubsection:: *)
(*Singlet*)


<|
	operator->{primary},
	relation->{
	    (*annihilation rule*)
	    L[n_]**primary[delta_]:>0/;n>=1,
	    primary[delta_]**L[n_]:>0/;n<=-1,
	    L[0]**primary[delta_]:>delta primary[delta]
	}
|>//algebraAdd["singlet"];


(* ::Subsubsection:: *)
(*Multiplet*)


<|
	operator->{primary},
	relation->{
	    (*boundary condition*)
	    primary[rank_,a_,delta_]:>0/;a<=0,
	    primary[rank_,a_,delta_]:>0/;a>rank,
	    (*annihilation rule*)
	    L[n_]**primary[rank_,a_,delta_]:>0/;n>=1,
	    primary[rank_,a_,delta_]**L[n_]:>0/;n<=-1
	}
|>//algebraAdd[{"multiplet","multiplet-upper","multiplet-lower"}];


(* ::Text:: *)
(*action of L[0]*)


relation->{
    L[0]**primary[rank_,a_,delta_]:>delta primary[rank,a,delta]+primary[rank,a+1,delta]
}//algebraAdd[{"multiplet","multiplet-upper"}];

relation->{
    L[0]**primary[rank_,a_,delta_]:>delta primary[rank,a,delta]+primary[rank,a-1,delta]
}//algebraAdd["multiplet-lower"];


(* ::Subsubsection:: *)
(*Conjugation*)


relation->{
    SuperDagger[L[n_]]:>L[-n]
}//algebraAdd["SL2-conjugate"];


relation->{
    primary[delta_]**primary[delta_]:>1,
    SuperDagger[primary[delta_]]:>primary[delta]
}//algebraAdd["singlet-conjugate"];


relation->{
    primary[rank_,a_,delta_]**primary[rank_,b_,delta_]:>KroneckerDelta[a+b,rank+1],
    SuperDagger[primary[rank_,a_,delta_]]:>primary[rank,a,delta]
}//algebraAdd["multiplet-conjugate"];


(* ::Subsubsection:: *)
(*Function*)


SL2Index =
    {-1,0,1};

SL2Generator =
    {L[-1],L[0],L[1]};

SL2Casimir =
    L[0]**L[0]-L[0]-L[-1]**L[1];


Lmonomial[] = 1;

Lmonomial[n_] :=
    L[n];

Lmonomial[n_,m__] :=
    Lmonomial[n]**Lmonomial[m];


Lpower[k_,n_Integer] :=
    operatorPower[L[k],n];


descendant[delta_,n_Integer] :=
    operatorPower[L[-1],n]**primary[delta];

descendant[rank_,a_,delta_,n_Integer] :=
    operatorPower[L[-1],n]**primary[rank,a,delta];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
