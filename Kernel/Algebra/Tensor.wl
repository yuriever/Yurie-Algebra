(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Tensor`"];


Needs["Yurie`Algebra`"];
Needs["Yurie`Algebra`Simplify`"];


(* ::Section:: *)
(*Public*)


id::usage = 
    "identity of tensor product.";

tensorRankEqualQ::usage = 
    "check whether the ranks of two tensors are equal.";
tensorRankSet::usage =
    "set the tensor-rank of generators.";
tensorRankGet::usage =
    "get the tensor-rank of operators.";

tensorCompose::usage = 
    "composite tensors over multiplication according to tensor-rank.";


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Message*)


tensorRank::usage =
    "tensor-rank of generators.";
dummyHead::usage = 
    "head placeholder used by tensorCompose.";
dummySlot::usage = 
    "slot placeholder used by tensorCompose.";


(* ::Subsection:: *)
(*Tensor product*)


tensorRank[_] = 1;


(* ::Subsubsection:: *)
(*tensorRankEqualQ*)


tensorRankEqualQ[op1_,op2_] :=
    Total[tensorRank/@op1,AllowedHeads->CircleTimes]==Total[tensorRank/@op2,AllowedHeads->CircleTimes];


(* ::Subsubsection:: *)
(*tensorRankSet*)


tensorRankSet[op_,rank_] :=
    tensorRank[op] = rank;    


(* ::Subsubsection:: *)
(*tensorRankGet*)


tensorRankGet[_?scalarQ] =
    0;

tensorRankGet[op_?generatorQ] :=
    tensorRank[op];

tensorRankGet[op:_CircleTimes|_Times] :=
    tensorRankGet/@List@@op//Total;

tensorRankGet[op:_NonCommutativeMultiply|_Plus] :=
    tensorRankGet/@List@@op//Max;


(* ::Subsubsection:: *)
(*tensorCompose*)


tensorCompose[op1_**op2_] :=
    dummyHead[`tensorCompose`padRight[List@@op1],`tensorCompose`padRight[List@@op2]]//Thread//
    	Split[#,MemberQ[#2,dummySlot]&]&//Map[Thread[#,dummyHead]&]//
			ReplaceAll[dummySlot->Sequence[]]//ReplaceAll[List[op_]:>op]//
				ReplaceAll[{dummyHead->NonCommutativeMultiply,List->CircleTimes}];


`tensorCompose`padRight[opList_] :=
    Flatten@Riffle[opList,ConstantArray[dummySlot,#]&/@(tensorRank/@opList-1)];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
