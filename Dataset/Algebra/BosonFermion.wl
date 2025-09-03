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


boson::usage =
    "operator: boson.";

fermion::usage =
    "operator: fermion.";

vac::usage =
    "state: vacuum.";

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


$algebraList = {
    "Boson","Fermion","BosonFermion",
    "Vacuum","BosonVacuum","FermionVacuum"
};

$algebraList//algebraUnset//Quiet;

$algebraList//algebraDefine;


(* ::Subsubsection:: *)
(*Boson and fermion*)


<|
    "Generator"->{boson},
    "Relation"->{
        commIn[boson[i_,an],boson[j_,cr]]:>KroneckerDelta[i,j]*id,
        commIn[boson[i_,an],boson[j_,an]]:>0/;i>j,
        commIn[boson[i_,cr],boson[j_,cr]]:>0/;i<j,
        conjugate[boson[i_,cr]]:>boson[i,an],
        conjugate[boson[i_,an]]:>boson[i,cr]
    },
    "Printing"->{
        boson[i_,cr]:>Subscript[SuperDagger[ToExpression["a"]],i],
        boson[i_,an]:>Subscript[ToExpression["a"],i]
    }
|>//algebraAdd["Boson"];


<|
    "Generator"->{fermion},
    "Relation"->{
        commIn[fermion[i_,an],fermion[j_,cr],1]:>KroneckerDelta[i,j]*id,
        commIn[fermion[i_,an],fermion[j_,an],1]:>0/;i>j,
        commIn[fermion[i_,cr],fermion[j_,cr],1]:>0/;i<j,
        fermion[i_,tag_]**fermion[i_,tag_]:>0,
        conjugate[fermion[i_,cr]]:>fermion[i,an],
        conjugate[fermion[i_,an]]:>fermion[i,cr]
    },
    "Printing"->{
        fermion[i_,cr]:>Subscript[SuperDagger[ToExpression["b"]],i],
        fermion[i_,an]:>Subscript[ToExpression["b"],i]
    }
|>//algebraAdd["Fermion"];


"Relation"->{
    (*move annihilation operators to the right.*)
    commIn[op1_[i_,an],op2_[j_,cr]]:>0/;op1=!=op2,
    (*move boson operators to the right if the tags are the same.*)
    commIn[boson[i_,tag_],fermion[j_,tag_]]:>0
}//algebraAdd["BosonFermion"];


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vac},
    "Relation"->{
        vac**vac:>1,
        conjugate[vac]:>vac
    },
    "Printing"->{
        vac:>Ket[{0}]
    }
|>//algebraAdd["Vacuum"];


"Relation"->{
    boson[i_,an]**vac:>0,
    vac**boson[i_,cr]:>0
}//algebraAdd["BosonVacuum"];


"Relation"->{
    fermion[i_,an]**vac:>0,
    vac**fermion[i_,cr]:>0
}//algebraAdd["FermionVacuum"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
