(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Tensor`"];


Needs["Yurie`Algebra`"];

Needs["Yurie`Algebra`Cache`"];


(* ::Section:: *)
(*Public*)


tensor::usage =
    "tensor product.";

comultiply::usage =
    "comultiplication of coalgebra.";

counit::usage =
    "counit of coalgebra.";

antipode::usage =
    "antipode of Hopf algebra.";


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


dummyHead::usage =
    "head placeholder used by tensorCompose.";

dummySlot::usage =
    "slot placeholder used by tensorCompose.";


(* ::Subsection:: *)
(*Tensor product*)


(* ::Subsubsection:: *)
(*tensorRankEqualQ*)


tensorRankEqualQ[op1_?generatorQ,op2_?generatorQ] :=
    $tensorRank[op1]==$tensorRank[op2];

tensorRankEqualQ[op1_?generatorQ,op2_tensor] :=
    $tensorRank[op1]==Total[$tensorRank/@op2,AllowedHeads->tensor];

tensorRankEqualQ[op1_tensor,op2_?generatorQ] :=
    Total[$tensorRank/@op1,AllowedHeads->tensor]==$tensorRank[op2];

tensorRankEqualQ[op1_tensor,op2_tensor] :=
    Total[$tensorRank/@op1,AllowedHeads->tensor]==Total[$tensorRank/@op2,AllowedHeads->tensor];


(* ::Subsubsection:: *)
(*tensorRankSet*)


tensorRankSet[op_,rank_] :=
    (
        $tensorRank[op] = rank;
    );


(* ::Subsubsection:: *)
(*tensorRankGet*)


tensorRankGet[k_?scalarQ] :=
    0;

tensorRankGet[op_?generatorQ] :=
    $tensorRank[op];

tensorRankGet[k_?scalarQ*op_?generatorQ] :=
    $tensorRank[op];

tensorRankGet[op_tensor] :=
    Total[tensorRankGet/@op,AllowedHeads->tensor];

tensorRankGet[k_?scalarQ*op_tensor] :=
    tensorRankGet[op];


(* ::Subsubsection:: *)
(*tensorCompose*)


tensorCompose[op1_**op2_] :=
    dummyHead[tensorPadRight[List@@op1],tensorPadRight[List@@op2]]//Thread//
    	Split[#,MemberQ[#2,dummySlot]&]&//Map[Thread[#,dummyHead]&]//
			ReplaceAll[dummySlot->Sequence[]]//ReplaceAll[List[op_]:>op]//ReplaceAll[{dummyHead->NonCommutativeMultiply,List->tensor}];


tensorPadRight[opList_] :=
    Flatten@Riffle[
        opList,
        ConstantArray[dummySlot,#]&/@($tensorRank/@opList-1)
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
