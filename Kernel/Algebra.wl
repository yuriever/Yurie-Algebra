(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`"];


Needs["Yurie`Cluster`"];


(* ::Subsection:: *)
(*Usage*)


Get["Yurie`Algebra`Usage`"];


(* ::Subsection:: *)
(*Core*)


Get["Yurie`Algebra`Variable`"];

Get["Yurie`Algebra`Internal`"];

Get["Yurie`Algebra`Algebra`"];

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
    {"algebraCluster","Yurie`Algebra`Variable`"},
    {operator,relation,printing},
    {{},{},{}},
    Values@algebraInternal["Algebra"],
    {DeleteDuplicates@*Join,DeleteDuplicates@*Join,DeleteDuplicates@*Join}
];


(* ::Subsubsection:: *)
(*StarDefaultData caching*)


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
