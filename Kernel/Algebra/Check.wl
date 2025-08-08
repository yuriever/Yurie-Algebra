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

checkCoassociativity::usage =
    "check the coassociativity of comultiplication.";

checkCounitality::usage =
    "check the counitality of counit.";

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
        scalarSimplify[
            commSim[x,commSim[y,z]]+
            commSim[y,commSim[z,x]]+
            commSim[z,commSim[x,y]]
        ];


checkLieModule[x_,y_,z_] :=
    {x,y,z}->
        scalarSimplify[
            algebraSimplify[commSim[x,y]**z]-
            algebraSimplify[x**algebraSimplify[y**z]]+
            algebraSimplify[y**algebraSimplify[x**z]]
        ];


checkCoassociativity[x_] :=
    {x}->scalarSimplify[
        comultiplyInTensor["Left"]@algebraSimplify@comultiply[x]-
        comultiplyInTensor["Right"]@algebraSimplify@comultiply[x]
    ];


checkCounitality[x_] :=
    {x}->scalarSimplify[{
        multiplyTensorWithCounit["Left"]@algebraSimplify@comultiply[x]-
            x,
        multiplyTensorWithCounit["Right"]@algebraSimplify@comultiply[x]-
            x
    }];


checkAntipode[x_] :=
    {x}->scalarSimplify[{
        multiplyTensorWithAntipode["Left"]@algebraSimplify@comultiply[x]-
            algebraSimplify[counit[x]*id],
        multiplyTensorWithAntipode["Right"]@algebraSimplify@comultiply[x]-
            algebraSimplify[counit[x]*id]
    }];


(* ::Subsection:: *)
(*Helper*)


multiplyTensor[x_+y_] :=
    multiplyTensor[x]+multiplyTensor[y];

multiplyTensor[k_?scalarQ*x_tensor] :=
    k*multiplyTensor[x];

multiplyTensor[tensor[x_,y_]] :=
    algebraSimplify[x**y];


comultiplyInTensor[side_][x_+y_] :=
    comultiplyInTensor[side][x]+comultiplyInTensor[side][y];

comultiplyInTensor[side_][k_?scalarQ*x_tensor] :=
    k*comultiplyInTensor[side][x];

comultiplyInTensor["Left"][tensor[x_,y_]] :=
    algebraSimplify[
        tensor[algebraSimplify@comultiply[x],y]
    ];

comultiplyInTensor["Right"][tensor[x_,y_]] :=
    algebraSimplify[
        tensor[x,algebraSimplify@comultiply[y]]
    ];


multiplyTensorWithCounit[side_][x_+y_] :=
    multiplyTensorWithCounit[side][x]+multiplyTensorWithCounit[side][y];

multiplyTensorWithCounit[side_][k_?scalarQ*x_tensor] :=
    k*multiplyTensorWithCounit[side][x];

multiplyTensorWithCounit["Left"][tensor[x_,y_]] :=
    algebraSimplify[
        algebraSimplify@counit[x]*y
    ];

multiplyTensorWithCounit["Right"][tensor[x_,y_]] :=
    algebraSimplify[
        x*algebraSimplify@counit[y]
    ];


multiplyTensorWithAntipode[side_][x_+y_] :=
    multiplyTensorWithAntipode[side][x]+multiplyTensorWithAntipode[side][y];

multiplyTensorWithAntipode[side_][k_?scalarQ*x_tensor] :=
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
