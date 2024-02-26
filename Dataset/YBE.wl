(* ::Package:: *)

(* ::Section:: *)
(*Preload*)


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`YBE`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


R::usage =
    "operator: R.";

x::usage =
	"state.";


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
	operator->{R,x},
	relation->{
		R[i_,j_,u_,v_]**(x_\[CircleTimes] y_\[CircleTimes] z_):>
			(u-v)/(u-v+I) (x\[CircleTimes] y\[CircleTimes] z)+
			I/(u-v+I) Permute[x\[CircleTimes] y\[CircleTimes] z,Cycles@{{i,j}}]
	},
	printing->{
		(op_?generatorQ)[i_]:>Subscript[op,i],
		R[i_,j_,u_,v_]:>Subscript[R,i,j]
	}
|>//algebraAdd["YBE"];


tensorRankSet[R[___],3];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
