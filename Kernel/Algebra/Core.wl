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

tensorankSafe::usage =
    "check whether the expression is valid and return the tensor rank of by the default algebra.";


parity::usage =
    "return the parity of the expression by the default algebra.";


(* ::Subsection:: *)
(*Shortcut*)


algS::usage =
    "algebraSimplify.";

algFS::usage =
    "algebraSimplify + FullSimplify.";


algP::usage =
    "algebraPrint.";

algSP::usage =
    "algebraSimplify + algebraPrint.";

algFSP::usage =
    "algebraSimplify + FullSimplify + algebraPrint.";


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


algebraSimplify[expr_] :=
    ReplaceRepeated[expr,$relation]//Simplify;


(* ::Subsection:: *)
(*algebraPrint*)


algebraPrint[expr_] :=
    ReplaceRepeated[expr,$printing];


(* ::Subsection:: *)
(*tensorank*)


tensorank[k_.*x_tensor] :=
    Total[Map[tensorank,x],AllowedHeads->tensor];

tensorank[k_.*x_NonCommutativeMultiply] :=
    tensorank@First@x;

tensorank[k_.*Shortest[x_?generatorQ]] :=
    $tensorank[x];

tensorank[k_?scalarQ] :=
    0;


(* ::Subsection:: *)
(*tensorankSafe*)


(* ::Subsubsection:: *)
(*Message*)


tensorankSafe::rankNotMatch =
    "the tensor ranks in `` do not match.";


(* ::Subsubsection:: *)
(*Main*)


tensorankSafe[Optional[k_?scalarQ]*x_tensor] :=
    Total[Map[tensorankSafe,x],AllowedHeads->tensor];

tensorankSafe[Optional[k_?scalarQ]*x_NonCommutativeMultiply] :=
    Catch[
        If[ AllSameBy[x,tensorankSafe]===False,
            Message[tensorankSafe::rankNotMatch,x];
            Throw@Defer@tensorankSafe[x]
        ];
        tensorankSafe@First@x
    ];

tensorankSafe[Optional[k_?scalarQ]*x_?generatorQ] :=
    $tensorank[x];

tensorankSafe[k_?scalarQ] :=
    0;


(* ::Subsection:: *)
(*parity*)


parity[Optional[k_?scalarQ]*x_NonCommutativeMultiply] :=
    Mod[
        Total[Map[parity,x],AllowedHeads->NonCommutativeMultiply],
        2
    ];


(* ::Subsection:: *)
(*Shortcut*)


algS :=
    algebraSimplify;

algFS :=
    algebraSimplify/*FullSimplify;


algP :=
    algebraPrint;

algSP :=
    algebraSimplify/*algebraPrint;

algFSP :=
    algebraSimplify/*FullSimplify/*algebraPrint;


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
