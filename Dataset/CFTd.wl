(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`CFTd`"];


Needs["Yurie`Algebra`"];

Needs["Yurie`CFT`Cartesian`"];


(* ::Section:: *)
(*Public*)


genCA::usage =
    "list of generators.";

genD::usage =
    "operator: dilatation.";

genM::usage =
    "operator: rotation.";

genP::usage =
    "operator: translation.";

genK::usage =
    "operator: SCT.";

vac::usage =
    "state: vacuum.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


(* ::Text:: *)
(*Construct the association of generators.*)


genCA :=
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


(* ::Text:: *)
(*Definition*)


$algebraList = {"IA","CA","conjugateE","conjugateL","vacuum"};

$algebraList//algebraUnset//Quiet;

$algebraList//algebraDefine;


(* ::Text:: *)
(*Operator*)


operator->{genP,genM}//algebraAdd["IA"];


operator->{genP,genM,genD,genK}//algebraAdd["CA"];


operator->{vac}//algebraAdd["vacuum"];


(* ::Text:: *)
(*Isometry algebra and conformal algebra*)


(* ::Text:: *)
(*P < M < D < K*)
(*M[i, j] < M[k, l] if k > i or k = i && l > j*)


(* ::Text:: *)
(*[D, P] = P*)
(*[D, K] = -K*)
(*[K, P] = 2 g D - 2 M*)
(*[M12, P3] = P1 g23 - P2 g13*)


relation->{
    genM[i_,i_]:>0,
    genM[i_,j_]:>-genM[j,i]/;coordOrder[j>i],
    commDefine[genP[i_],genP[j_]]:>0/;coordOrder[j>i],
    (*[M,P]*)
    commDefine[genM[i_,j_],genP[k_]]:>
        genP[i]metric[j,k]-genP[j]metric[i,k],
    (*[M,M]*)
    commDefine[genM[i_,j_],genM[k_,l_]]:>
        genM[i,l]metric[j,k]+genM[j,k]metric[i,l]-genM[j,l]metric[i,k]-genM[i,k]metric[j,l]/;
            coordOrder[k>i||(k==i&&l>j)]
}//algebraAdd[{"IA","CA"}];


relation->{
    commDefine[genK[i_],genK[j_]]:>0/;coordOrder[j>i],
    (*[M,K]*)
    commDefine[genM[i_,j_],genK[k_],Reverse]:>
        genK[i]metric[j,k]-genK[j]metric[i,k],
    (*[D,P]=P, [D,K]=-K, [D,M]=0*)
    commDefine[genD[],genP[i_]]:>genP[i],
    commDefine[genD[],genK[i_],Reverse]:>-genK[i],
    commDefine[genD[],genM[i_,j_]]:>0,
    (*[K,P]*)
    commDefine[genK[i_],genP[j_]]:>2genD[]metric[i,j]-2genM[i,j]
}//algebraAdd["CA"];


printing->{
    genP[i_]:>Subscript["P",i],
    genM[i_,j_]:>Subscript["M",i,j]
}//algebraAdd["IA"];


printing->{
    genD[]:>"D",
    genP[i_]:>Subscript["P",i],
    genK[i_]:>Subscript["K",i],
    genM[i_,j_]:>Subscript["M",i,j]
}//algebraAdd["CA"];


(* ::Text:: *)
(*Vacuum*)


relation->{
    genD[]**vac:>0,
    genP[_]**vac:>0,
    genK[_]**vac:>0,
    genM[_,_]**vac:>0
}//algebraAdd["vacuum"];


(* ::Text:: *)
(*Conjugation*)


relation->{
    SuperDagger@op_?generatorQ:>-op
}//algebraAdd["conjugateE"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
