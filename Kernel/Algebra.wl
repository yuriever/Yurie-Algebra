(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`"];


ClearAll["`*"];
ClearAll["`*`*"];


Needs["Yurie`Cluster`"];


(* ::Subsection:: *)
(*Usage*)


Get["Yurie`Algebra`Usage`"];


(* ::Subsection:: *)
(*Core*)


Get["Yurie`Algebra`Cache`"];

Get["Yurie`Algebra`Algebra`"];

Get["Yurie`Algebra`Internal`"];

Get["Yurie`Algebra`Simplify`"];


(* ::Subsection:: *)
(*Extension*)


Get["Yurie`Algebra`Conjugate`"];

Get["Yurie`Algebra`Tensor`"];


Get["Yurie`Algebra`Utility`"];

Get["Yurie`Algebra`Check`"];


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
