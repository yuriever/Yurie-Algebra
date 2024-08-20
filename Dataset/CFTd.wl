(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`CFTd`"];


Needs["Yurie`Algebra`"];

Needs["Yurie`Cartesian`"];


(* ::Section:: *)
(*Public*)


genD::usage =
    "operator: dilatation.";

genM::usage =
    "operator: rotation.";

genP::usage =
    "operator: translation.";

genK::usage =
    "operator: SCT.";

vacuum::usage =
    "state: vacuum.";


CFTd::usage =
    "generator list of the conformal algebra.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


(* ::Text:: *)
(*P < M < D < K*)
(*M[i, j] < M[k, l] if k > i or k = i && l > j*)


(* ::Text:: *)
(*[D, P] = P*)
(*[D, K] = -K*)
(*[K, P] = 2 g D - 2 M*)
(*[M12, P3] = P1 g23 - P2 g13*)


$algebraList = {
    "isometry-algebra",
    "conformal-algebra",
    "vacuum",
    "conjugateE",
    "conjugateL"
};

$algebraList//algebraUnset//Quiet

$algebraList//algebraDefine


(* ::Subsubsection:: *)
(*Isometry and conformal algebras*)


"Generator"->{genP,genM}//algebraAdd["isometry-algebra"]

"Generator"->{genP,genM,genD,genK}//algebraAdd["conformal-algebra"]


"Relation"->{
    genM[i_,i_]:>0,
    genM[i_,j_]:>-genM[j,i]/;coordOrder[j>i],
    commDefine[genP[i_],genP[j_]]:>0/;coordOrder[j>i],
    (*[M,P]*)
    commDefine[genM[i_,j_],genP[k_]]:>
        genP[i]*metric[j,k]-genP[j]*metric[i,k],
    (*[M,M]*)
    commDefine[genM[i_,j_],genM[k_,l_]]:>
        genM[i,l]*metric[j,k]+genM[j,k]*metric[i,l]-genM[j,l]*metric[i,k]-genM[i,k]*metric[j,l]/;
            coordOrder[k>i||(k==i&&l>j)]
}//algebraAdd["isometry-algebra","conformal-algebra"]


"Relation"->{
    commDefine[genK[i_],genK[j_]]:>0/;coordOrder[j>i],
    (*[M,K]*)
    commDefine[genM[i_,j_],genK[k_],Reverse]:>
        genK[i]*metric[j,k]-genK[j]*metric[i,k],
    (*[D,P]=P, [D,K]=-K, [D,M]=0*)
    commDefine[genD[],genP[i_]]:>genP[i],
    commDefine[genD[],genK[i_],Reverse]:>-genK[i],
    commDefine[genD[],genM[i_,j_]]:>0,
    (*[K,P]*)
    commDefine[genK[i_],genP[j_]]:>2genD[]*metric[i,j]-2*genM[i,j]
}//algebraAdd["conformal-algebra"]


"Printing"->{
    genP[i_]:>Subscript["P",i],
    genM[i_,j_]:>Subscript["M",i,j]
}//algebraAdd["isometry-algebra"]


"Printing"->{
    genD[]:>"D",
    genP[i_]:>Subscript["P",i],
    genK[i_]:>Subscript["K",i],
    genM[i_,j_]:>Subscript["M",i,j]
}//algebraAdd["conformal-algebra"]


(* ::Subsubsection:: *)
(*Vacuum*)


"Generator"->{vacuum}//algebraAdd["vacuum"]


"Relation"->{
    genD[]**vacuum:>0,
    genP[_]**vacuum:>0,
    genK[_]**vacuum:>0,
    genM[_,_]**vacuum:>0
}//algebraAdd["vacuum"]


(* ::Subsubsection:: *)
(*Conjugation*)


"Relation"->{
    conjugate[op_?generatorQ]:>-op
}//algebraAdd["conjugateE"]


(* ::Subsection:: *)
(*Constant*)


CFTd :=
    Module[ {i,j,assoc},
        assoc = <|
            "D"->
                {genD[]},
            "P"->
                Table[genP[i],{i,coord}],
            "K"->
                Table[genK[i],{i,coord}],
            "M"->
                DeleteCases[0]@Flatten@LowerTriangularize[
                    Table[genM[i,j],{i,coord},{j,coord}],
                    -1
                ]
        |>;
        <|
            assoc,
            "MDK"->Join[assoc["M"],assoc["D"],assoc["K"]],
            "PMDK"->Join[assoc["P"],assoc["M"],assoc["D"],assoc["K"]],
            "PM"->Join[assoc["P"],assoc["M"]],
            "P2"->Sum[metricInv[i,j]*genP[i]**genP[j],{i,coord},{j,coord}]
        |>
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
