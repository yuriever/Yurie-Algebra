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
    {x,y,z}->
        Simplify[
            algebraSimplify[algebraSimplify[x**y]**z]-
            algebraSimplify[x**algebraSimplify[y**z]]
        ];



(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
