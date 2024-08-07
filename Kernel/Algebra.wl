(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`"];


(*ClearAll["`*"];
ClearAll["`*`*"];*)


Needs["Yurie`Cluster`"];


(* ::Subsection:: *)
(*Usage*)


Get["Yurie`Algebra`Usage`"];


(* ::Subsection:: *)
(*Core*)


Get["Yurie`Algebra`Cache`"];

Needs["Yurie`Algebra`Internal`"];

Needs["Yurie`Algebra`Algebra`"];

Needs["Yurie`Algebra`Simplify`"];


(* ::Subsection:: *)
(*Extension*)


Needs["Yurie`Algebra`Conjugate`"];

Needs["Yurie`Algebra`Tensor`"];


Needs["Yurie`Algebra`Utility`"];

Needs["Yurie`Algebra`Check`"];


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Cluster initiation*)


clusterInit[
    {"algebraCluster","Yurie`Algebra`Cache`"},
    {operator,relation,printing},
    {{},{},{}},
    Values@algebraInternal["Algebra"],
    {DeleteDuplicates@*Join,DeleteDuplicates@*Join,DeleteDuplicates@*Join}
];


(* ::Subsubsection:: *)
(*Cache*)


starPostIntercept[algebraCluster,"starUpdateDefault",defaultStar_] :=
    (
        $operator = clusterPropGet[algebraCluster,"StarDefaultData"][operator];
        $operatorPattern = Alternatives@@$operator;
        $relation = clusterPropGet[algebraCluster,"StarDefaultData"][relation];
        $printing = clusterPropGet[algebraCluster,"StarDefaultData"][printing];
    );


(* ::Subsubsection:: *)
(*Preset*)


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
