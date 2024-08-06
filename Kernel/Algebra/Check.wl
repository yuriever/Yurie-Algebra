(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Check`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


checkLieBracket::usage =
    "check the Jacobi identity of Lie algebra.";

checkLieModule::usage =
    "check the action on Lie module.";

checkAssociativity::usage =
    "check the associativity of multiplication.";

checkCoassociativity::usage =
    "check the coassociativity of comultiplication.";

checkAntipode::usage =
    "check the antipode of Hopf algebra.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


checkLieBracket[x_,y_,z_] :=
    {x,y,z}->
        Simplify[
            commSim[x,commSim[y,z]]+
            commSim[y,commSim[z,x]]+
            commSim[z,commSim[x,y]]
        ];


checkLieModule[x_,y_,z_] :=
    {x,y,z}->
        Simplify[
            algebraSimplify[commSim[x,y]**z]-
            algebraSimplify[x**algebraSimplify[y**z]]+
            algebraSimplify[y**algebraSimplify[x**z]]
        ];


checkAssociativity[x_,y_,z_] :=
    {x,y,z}->
        Simplify[
            algebraSimplify[algebraSimplify[x**y]**z]-
            algebraSimplify[x**algebraSimplify[y**z]]
        ];


checkCoassociativity[x_,y_,z_] :=
    pass;


checkAntipode[x_] :=
    Simplify[{
        multiplyWithAntipode["Left"]@algebraSimplify[comultiply[x]]-
            algebraSimplify@counit[x]*id,
        multiplyWithAntipode["Right"]@algebraSimplify[comultiply[x]]-
            algebraSimplify@counit[x]*id
    }];


(* ::Subsection:: *)
(*Helper*)


multiplyWithAntipode["Left"][expr_] :=
    algebraSimplify@Replace[
        expr,
        tensor[op1_,op2_]:>antipode[op1]**op2,
        {0,2}
    ];

multiplyWithAntipode["Right"][expr_] :=
    algebraSimplify@Replace[
        expr,
        tensor[op1_,op2_]:>op1**antipode[op2],
        {0,2}
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
