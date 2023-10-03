(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Simplify`"];


Needs["Yurie`Algebra`"];
Needs["Yurie`Algebra`Common`"];


(* ::Section:: *)
(*Public*)


(* ::Subsubsection:: *)
(*Kernel functions*)


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


(* ::Subsubsection:: *)
(*Shortcuts*)


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
    "return a formatted equation with the input at RHS and the simplified one at LHS.";
algFSE::usage =
    "return a formatted equation with the input at RHS and the fully simplified one at LHS.";

algEqualQ::usage =
    "x==y for Q-numbers.";
algSameQ::usage =
    "x==y for Q-numbers.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Kernel functions*)


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
(*Shortcuts*)


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
