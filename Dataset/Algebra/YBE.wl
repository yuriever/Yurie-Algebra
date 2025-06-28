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


R::usage =
    "operator: R.";

S::usage =
    "operator: S.";

x::usage =
    "state: x.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Algebra*)


$algebraList = {"YBE"};

$algebraList//algebraUnset//Quiet;

$algebraList//algebraDefine;


<|
    "Generator"->{
        x[_],
        S[],
        R[___]
    },
    "Relation"->{
        S[]**tensor[x_,y_]:>
            tensor[y,x],
        R[i_,j_,u_,v_]**tensor[x_,y_,z_]:>
            (u-v)/(u-v+I)*tensor[x,y,z]+I/(u-v+I)*Permute[tensor[x,y,z],Cycles@{{i,j}}]
    },
    "Printing"->{
        x[i_]:>Subscript[x,i],
        S[]->S,
        R[i_,j_,u_,v_]:>Subscript[R,i,j]
    },
    "Rank"->{
        S[]->2,
        R[___]->3
    }
|>//algebraAdd["YBE"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
