(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Core`"];


Needs["Yurie`Algebra`"];

Needs["Yurie`Algebra`Variable`"];


(* ::Section:: *)
(*Public*)


(* ::Subsection:: *)
(*Core*)


id::usage =
    "identity operator.";


generator::usage =
    "return the generators of the default/specified algebra.";

relation::usage =
    "return the defining relations of the default/specified algebra.";

printing::usage =
    "return the formatting rules of the default/specified algebra.";


generatorQ::usage =
    "check whether the expression is a generator by the default algebra.";

scalarQ::usage =
    "check whether the expression is a scalar by the default algebra.";

operatorQ::usage =
    "check whether the expression is an operator by the default algebra.";


algebraSimplify::usage =
    "simplify the expression by the default algebra.";

algebraPrint::usage =
    "format the expression by the default algebra.";


tensorank::usage =
    "return the tensor rank of the expression by the default algebra.";

tensorankUnsafe::usage =
    "return the tensor rank of the expression by the default algebra without validating the expression.";


parity::usage =
    "return the parity of the expression by the default algebra.";

parityUnsafe::usage =
    "return the parity of the expression by the default algebra without validating the expression.";


(* ::Subsection:: *)
(*Shortcut*)


algS::usage =
    "algebraSimplify.";

algP::usage =
    "algebraPrint.";

algSP::usage =
    "algebraSimplify + algebraPrint.";


algEqualQ::usage =
    "x==y for operators.";

algSameQ::usage =
    "x===y for operators.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*generator*)


generator[] :=
    $generator;

generator[alg_String] :=
    $algebraData[alg,"Generator"];


(* ::Subsection:: *)
(*relation*)


relation[] :=
    $relation//Normal;

relation[alg_String] :=
    $algebraData[alg,"Relation"];


(* ::Subsection:: *)
(*printing*)


printing[] :=
    $printing//Normal;

printing[alg_String] :=
    $algebraData[alg,"Printing"];


(* ::Subsection:: *)
(*generatorQ*)


generatorQ[expr_] :=
    MatchQ[expr,$generatorP];


(* ::Subsection:: *)
(*scalarQ*)


scalarQ[expr_] :=
    FreeQ[expr,$generatorP];


(* ::Subsection:: *)
(*operatorQ*)


operatorQ[expr__] :=
    Not@FreeQ[expr,$generatorP];


(* ::Subsection:: *)
(*algebraSimplify*)


(* ::Subsubsection:: *)
(*Option*)


algebraSimplify//Options = {
    "Post"->scalarSimplify
};


(* ::Subsubsection:: *)
(*Main*)


algebraSimplify[expr_,opts:OptionsPattern[]] :=
    expr//ReplaceRepeated[$relation]//OptionValue["Post"];


(* ::Subsection:: *)
(*algebraPrint*)


(* ::Subsubsection:: *)
(*Main*)


algebraPrint[expr_] :=
    expr//ReplaceRepeated[$printing]//printNC;


(* ::Subsubsection:: *)
(*Helper*)


printNC[expr_] :=
    expr//ReplaceRepeated[{
        co_.*NonCommutativeMultiply[args__]:>HoldForm[Times[co,args]]
    }];


(* ::Subsection:: *)
(*tensorankSafe*)


(* ::Subsubsection:: *)
(*Message*)


tensorank::rankNotMatch =
    "the tensor ranks in `` do not match.";


(* ::Subsubsection:: *)
(*Main*)


tensorank[expr_] :=
    expr//tensorankKernel//Catch//ReplaceAll[tensorankKernel->tensorank];


tensorankKernel[x_+y_] :=
    With[{rank = tensorankKernel[x]},
        If[rank===tensorankKernel[y],
            rank,
            (* Else *)
            Throw@Indeterminate
        ]
    ];

tensorankKernel[Optional[k_?scalarQ]*x_tensor] :=
    Total[Map[tensorankKernel,x],AllowedHeads->tensor];

tensorankKernel[Optional[k_?scalarQ]*x_NonCommutativeMultiply] :=
    (
        If[AllSameBy[x,tensorankKernel]===False,
            Message[tensorank::rankNotMatch,x];
            Throw@Defer@tensorankKernel[x]
        ];
        tensorankKernel@First@x
    );

tensorankKernel[Optional[k_?scalarQ]*x_?generatorQ] :=
    $tensorank[x];

tensorankKernel[k_?scalarQ] :=
    0;


(* ::Subsection:: *)
(*tensorankUnsafe*)


tensorankUnsafe[k_.*x_tensor] :=
    Total[Map[tensorankUnsafe,x],AllowedHeads->tensor];

tensorankUnsafe[k_.*x_NonCommutativeMultiply] :=
    tensorankUnsafe@First@x;

tensorankUnsafe[k_.*Shortest[x_?generatorQ]] :=
    $tensorank[x];

tensorankUnsafe[k_?scalarQ] :=
    0;


(* ::Subsection:: *)
(*parity*)


parity[Optional[k_?scalarQ]*x_NonCommutativeMultiply] :=
    Mod[
        Total[Map[parity,x],AllowedHeads->NonCommutativeMultiply],
        2
    ];


(* ::Subsection:: *)
(*parityUnsafe*)


(* ::Subsection:: *)
(*Shortcut*)


algS :=
    algebraSimplify;

algP :=
    algebraPrint;

algSP :=
    algebraSimplify/*algebraPrint;


algEqualQ[x_,y_] :=
    algebraSimplify[x-y]==0;

algSameQ[x_,y_] :=
    algebraSimplify[x-y]===0;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
