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


checkCoassociativity[x_] :=
    {x}->Simplify[
        comultiplyInTensor["Left"]@algebraSimplify@comultiply[x]-
        comultiplyInTensor["Right"]@algebraSimplify@comultiply[x]
    ];


checkAntipode[x_] :=
    {x}->Simplify[{
        multiplyTensorWithAntipode["Left"]@algebraSimplify@comultiply[x]-
            algebraSimplify[counit[x]*id],
        multiplyTensorWithAntipode["Right"]@algebraSimplify@comultiply[x]-
            algebraSimplify[counit[x]*id]
    }];


(* ::Subsection:: *)
(*Helper*)


multiplyTensor[x_+y_] :=
    multiplyTensor[x]+multiplyTensor[y];

multiplyTensor[k_?scalarQ*x_.] :=
    k*multiplyTensor[x];

multiplyTensor[tensor[x_,y_]] :=
    algebraSimplify[x**y];


comultiplyInTensor[side_][x_+y_] :=
    comultiplyInTensor[side][x]+comultiplyInTensor[side][y];

comultiplyInTensor[side_][k_?scalarQ*x_.] :=
    k*comultiplyInTensor[side][x];

comultiplyInTensor["Left"][tensor[x_,y_]] :=
    algebraSimplify[
        tensor[algebraSimplify@comultiply[x],y]
    ];

comultiplyInTensor["Right"][tensor[x_,y_]] :=
    algebraSimplify[
        tensor[x,algebraSimplify@comultiply[y]]
    ];


multiplyTensorWithAntipode[side_][x_+y_] :=
    multiplyTensorWithAntipode[side][x]+multiplyTensorWithAntipode[side][y];

multiplyTensorWithAntipode[side_][k_?scalarQ*x_.] :=
    k*multiplyTensorWithAntipode[side][x];

multiplyTensorWithAntipode["Left"][tensor[x_,y_]] :=
    algebraSimplify[
        algebraSimplify@antipode[x]**y
    ];

multiplyTensorWithAntipode["Right"][tensor[x_,y_]] :=
    algebraSimplify[
        x**algebraSimplify@antipode[y]
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
