(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];

Needs["Yurie`Cartesian`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Global`"];


Needs["Yurie`Algebra`"];

Needs["Yurie`Cartesian`"];


(* ::Section:: *)
(*Public*)


genD::usage =
    "operator: dilatation.";

genM::usage =
    "operator: rotation and boost.";

genP::usage =
    "operator: translation.";

genK::usage =
    "operator: SCT.";

vac::usage =
    "state: vacuum.";


$CFT::usage =
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
    "IsometryAlgebra",
    "ConformalAlgebra",
    "Vacuum",
    "EuclideanConjugate",
    "LorentzianConjugate"
};

$algebraList//algebraUnset//Quiet;

$algebraList//algebraDefine;


(* ::Subsubsection:: *)
(*Isometry and conformal algebras*)


"Generator"->{genP,genM}//algebraAdd["IsometryAlgebra"];

"Generator"->{genP,genM,genD,genK}//algebraAdd["ConformalAlgebra"];


"Relation"->{
    genM[i_,i_]:>0,
    genM[i_,j_]:>-genM[j,i]/;coordOrder[j>i],
    commIn[genP[i_],genP[j_]]:>0/;coordOrder[j>i],
    (*[M,P]*)
    commIn[genM[i_,j_],genP[k_]]:>
        genP[i]*metric[j,k]-genP[j]*metric[i,k],
    (*[M,M]*)
    commIn[genM[i_,j_],genM[k_,l_]]:>
        genM[i,l]*metric[j,k]+genM[j,k]*metric[i,l]-genM[j,l]*metric[i,k]-genM[i,k]*metric[j,l]/;
            coordOrder[k>i||(k==i&&l>j)]
}//algebraAdd["IsometryAlgebra","ConformalAlgebra"];


"Relation"->{
    commIn[genK[i_],genK[j_]]:>0/;coordOrder[j>i],
    (*[M,K]*)
    commIn[genM[i_,j_],genK[k_],Reverse]:>
        genK[i]*metric[j,k]-genK[j]*metric[i,k],
    (*[D,P]=P, [D,K]=-K, [D,M]=0*)
    commIn[genD[],genP[i_]]:>genP[i],
    commIn[genD[],genK[i_],Reverse]:>-genK[i],
    commIn[genD[],genM[i_,j_]]:>0,
    (*[K,P]*)
    commIn[genK[i_],genP[j_]]:>2genD[]*metric[i,j]-2*genM[i,j]
}//algebraAdd["ConformalAlgebra"];


"Printing"->{
    genP[i_]:>Subscript[ToExpression["P"],i],
    genM[i_,j_]:>Subscript[ToExpression["M"],i,j]
}//algebraAdd["IsometryAlgebra"];


"Printing"->{
    genD[]:>ToExpression["D"],
    genP[i_]:>Subscript[ToExpression["P"],i],
    genK[i_]:>Subscript[ToExpression["K"],i],
    genM[i_,j_]:>Subscript[ToExpression["M"],i,j]
}//algebraAdd["ConformalAlgebra"];


(* ::Subsubsection:: *)
(*Vacuum*)


<|
    "Generator"->{vac},
    "Relation"->{
        genD[]**vac:>0,
        genP[_]**vac:>0,
        genK[_]**vac:>0,
        genM[_,_]**vac:>0
    },
    "Printing"->{
        vac:>Ket[{0}]
}|>//algebraAdd["Vacuum"];


(* ::Subsubsection:: *)
(*Conjugate*)


"Relation"->{
    conjugate[op_?generatorQ]:>-op
}//algebraAdd["EuclideanConjugate"];


(* ::Subsection:: *)
(*Constant*)


$CFT :=
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
