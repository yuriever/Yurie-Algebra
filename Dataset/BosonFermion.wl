(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`BosonFermion`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


vac::usage =
    "state: vacuum.";

boson::usage =
	"operator: boson.";

fermion::usage =
	"operator: fermion.";

an::usage =
	"tag: annihilation.";

cr::usage =
	"tag: creation.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"boson","fermion","boson-fermion","vacuum","boson-vacuum","fermion-vacuum"};

$algebraList//algebraUnset//Quiet;

$algebraList//algebraDefine;


(* ::Text:: *)
(*boson and fermion*)


<|
	operator->{boson},
	relation->{
		commDefine[boson[i_,an],boson[j_,cr]]:>KroneckerDelta[i,j],
		commDefine[boson[i_,an],boson[j_,an]]:>0/;i>j,
		commDefine[boson[i_,cr],boson[j_,cr]]:>0/;i<j,
		SuperDagger@boson[i_,cr]:>boson[i,an],
		SuperDagger@boson[i_,an]:>boson[i,cr]
	},
	printing->{
		boson[i_,cr]:>Subscript[SuperDagger@"a",i],
		boson[i_,an]:>Subscript["a",i]
	}
|>//algebraAdd["boson"];


<|
	operator->{fermion},
	relation->{
		commDefine[fermion[i_,an],fermion[j_,cr],1]:>KroneckerDelta[i,j],
		commDefine[fermion[i_,an],fermion[j_,an],1]:>0/;i>j,
		commDefine[fermion[i_,cr],fermion[j_,cr],1]:>0/;i<j,
		fermion[i_,tag_]**fermion[i_,tag_]:>0,
		SuperDagger@fermion[i_,cr]:>fermion[i,an],
		SuperDagger@fermion[i_,an]:>fermion[i,cr]
	},
	printing->{
		fermion[i_,cr]:>Subscript[SuperDagger@"b",i],
		fermion[i_,an]:>Subscript["b",i]
	}
|>//algebraAdd["fermion"];


relation->{
	(*move annihilation operators to the right.*)
	commDefine[op1_[i_,an],op2_[j_,cr]]:>0/;op1=!=op2,
	(*move boson operators to the right if the tags are the same.*)
	commDefine[boson[i_,tag_],fermion[j_,tag_]]:>0
}//algebraAdd["boson-fermion"];


(* ::Text:: *)
(*vacuum*)


<|
	operator->{vac},
	relation->{
		SuperDagger@vac**vac:>1
	}
|>//algebraAdd["vacuum"];


relation->{
	boson[i_,an]**vac:>0,
	SuperDagger@vac**boson[i_,cr]:>0
}//algebraAdd["boson-vacuum"];


relation->{
	fermion[i_,an]**vac:>0,
	SuperDagger@vac**fermion[i_,cr]:>0
}//algebraAdd["fermion-vacuum"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
