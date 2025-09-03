(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Init`"];


Needs["Yurie`Cluster`"];

Needs["Yurie`Algebra`"];

Needs["Yurie`Algebra`Variable`"];

Needs["Yurie`Algebra`Internal`"];


(* ::Section:: *)
(*Public*)


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


(* ::Text:: *)
(*Variable cleanup*)


$algebraData = <||>;

$algebraP = _;


$generator = {};

$generatorP = _;

$relation = {};

$printing = {};

$tensorank[_] :=
    1;

$parity[_] :=
    0;


(* ::Text:: *)
(*Cluster initialization*)


$algebraCluster =
    clusterInit[
        "AlgebraCluster",
        {"Generator","Relation","Printing","Rank","Parity"},
        Table[{},5],
        Values@algebraInternal["Algebra"],
        Table[DeleteDuplicates@*Join,5]
    ];


(* ::Text:: *)
(*Cache*)


starPostIntercept[$algebraCluster,"starDefine"|"starUnset",___] :=
    (
        $algebraP =
            Alternatives@@clusterGet[$algebraCluster,"StarList"];
    );


starPostIntercept[$algebraCluster,"starDefine"|"starReset"|"starUnset"|"starMerge"|"starChange",___] :=
    (
        $algebraData =
            clusterGet[$algebraCluster,"StarData"];
    );


starPostIntercept[$algebraCluster,"starUpdateDefault",_] :=
    (
        $generator =
            clusterGet[$algebraCluster,"StarDefaultData"]["Generator"];
        $generatorP =
            Alternatives@@$generator;
        (*  *)
        $relation =
            clusterGet[$algebraCluster,"StarDefaultData"]["Relation"]//Dispatch;
        (*  *)
        $printing =
            clusterGet[$algebraCluster,"StarDefaultData"]["Printing"]//Dispatch;
        (*  *)
        $tensorank//Clear;
        $tensorank[_] :=
            1;
        ReplaceAll[
            clusterGet[$algebraCluster,"StarDefaultData"]["Rank"],
            {
                Verbatim[Rule][lhs_,rhs_]:>(
                    $tensorank[lhs] =
                        rhs
                ),
                Verbatim[RuleDelayed][lhs_,rhs_]:>(
                    $tensorank[lhs] :=
                        rhs
                )
            }
        ];
        (*  *)
        $parity//Clear;
        $parity[_] :=
            0;
        ReplaceAll[
            clusterGet[$algebraCluster,"StarDefaultData"]["Parity"],
            {
                Verbatim[Rule][lhs_,rhs_]:>(
                    $parity[lhs] =
                        rhs
                ),
                Verbatim[RuleDelayed][lhs_,rhs_]:>(
                    $parity[lhs] :=
                        rhs
                )
            }
        ];
    );


(* ::Text:: *)
(*Internal algebra initialization*)


algebraDefine@algebraInternal[];

Table[
    algebraAdd[alg]@algebraInternal[alg],
    {alg,algebraInternal[]}
];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
