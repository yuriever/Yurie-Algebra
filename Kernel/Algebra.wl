(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`"];


ClearAll["`*"];
ClearAll["`*`*"];


Needs["Yurie`Cluster`"];


Get["Yurie`Algebra`Usage`"];


Get["Yurie`Algebra`Cache`"];

Get["Yurie`Algebra`Algebra`"];

Get["Yurie`Algebra`Internal`"];

Get["Yurie`Algebra`Simplify`"];

Get["Yurie`Algebra`Addon`"];

Get["Yurie`Algebra`Tensor`"];


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Cluster initiation*)


clusterInit[
    {"algebraCluster","Yurie`Algebra`"},
    {operator,relation,printing},
    {{},{},{}},
    Values@algebraInternal["Multiplication"],
    {DeleteDuplicates@*Join,DeleteDuplicates@*Join,DeleteDuplicates@*Join}
];


(* ::Subsubsection:: *)
(*Cache*)


starPostIntercept[algebraCluster,"starUpdateDefault",defaultStar_] :=
    (
        $operatorCache = clusterPropGet[algebraCluster,"StarDefaultData"][operator];
        $operatorPatternCache = Alternatives@@$operatorCache;
        $relationCache = clusterPropGet[algebraCluster,"StarDefaultData"][relation];
        $printingCache = clusterPropGet[algebraCluster,"StarDefaultData"][printing];
    );


(* ::Subsubsection:: *)
(*Preset*)


Module[ {alg},
    algebraDefine@algebraInternal[];
    Table[
        algebraAdd[{alg}]@algebraInternal[alg],
        {alg,algebraInternal[]}
    ];
];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
