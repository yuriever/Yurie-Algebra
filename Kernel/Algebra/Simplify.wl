(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Simplify`"];


Needs["Yurie`Algebra`"];

Needs["Yurie`Algebra`Cache`"];


(* ::Section:: *)
(*Public*)


(* ::Subsection:: *)
(*Kernel function*)


(*algebraReduce::usage =
    "reduce the expression by the default algebra.";*)

algebraSimplify::usage =
    "simplify the expression by the default algebra.";

algebraPrint::usage =
    "format the expression by the default algebra.";


scalarQ::usage =
    "check whether the expression is C-number by the default algebra.";

operatorQ::usage =
    "check whether the expression is Q-number by the default algebra.";

generatorQ::usage =
    "check whether the symbol is a generator the default algebra.";    


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


algSE::usage =
    "return an equation with the input at right side and the simplified one at left side.";

algFSE::usage =
    "return an equation with the input at right side and the fully simplified one at left side.";


algEqualQ::usage =
    "x==y for Q-numbers.";

algSameQ::usage =
    "x===y for Q-numbers.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Kernel function*)


algebraReduce[expr_] :=
    ReplaceRepeated[expr,$relationCache];


algebraSimplify[expr_] :=
    ReplaceRepeated[expr,$relationCache]//Simplify;


algebraPrint[expr_] :=
    ReplaceRepeated[expr,$printingCache];


scalarQ[expr_] :=
    FreeQ[expr,$operatorPatternCache];


operatorQ[expr__] :=
    Not@FreeQ[expr,$operatorPatternCache];


generatorQ[expr_Symbol] :=
    MemberQ[$operatorCache,expr];

generatorQ[expr_] :=
    MemberQ[$operatorCache,Head@expr];


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


algSE//Attributes =
    {HoldFirst};

algSE[expr_] :=
    expr==algebraSimplify[expr];

algFSE//Attributes =
    {HoldFirst};

algFSE[expr_] :=
    expr==FullSimplify@algebraSimplify[expr];


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
