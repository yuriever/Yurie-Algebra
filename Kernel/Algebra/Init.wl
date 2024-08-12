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


$operator = {};

$operatorPattern = _;

$relation = {};

$printing = {};


Clear["$tensorRank"];

$tensorRank[_] = 1;


(* ::Text:: *)
(*Cluster initialization*)


clusterInit[
    {"algebraCluster","Yurie`Algebra`Variable`"},
    {operator,relation,printing},
    {{},{},{}},
    Values@algebraInternal["Algebra"],
    {DeleteDuplicates@*Join,DeleteDuplicates@*Join,DeleteDuplicates@*Join}
];


(* ::Text:: *)
(*StarDefaultData caching*)


starPostIntercept[algebraCluster,"starUpdateDefault",defaultStar_] :=
    (
        $operator = clusterPropGet[algebraCluster,"StarDefaultData"][operator];
        $operatorPattern = Alternatives@@$operator;
        $relation = clusterPropGet[algebraCluster,"StarDefaultData"][relation];
        $printing = clusterPropGet[algebraCluster,"StarDefaultData"][printing];
    );


(* ::Text:: *)
(*Internal algebra initialization*)


Module[ {alg},
    algebraDefine@algebraInternal[];
    Table[
        algebraAdd[alg]@algebraInternal[alg],
        {alg,algebraInternal[]}
    ];
];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
