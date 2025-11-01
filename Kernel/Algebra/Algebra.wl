(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Algebra`"];


Needs["Yurie`Cluster`"];

Needs["Yurie`Algebra`"];

Needs["Yurie`Algebra`Variable`"];

Needs["Yurie`Algebra`Internal`"];


(* ::Section:: *)
(*Public*)


$algebraDefine::usage =
    "list of the defined algebras.";

$algebraDefault::usage =
    "list of the default algebras.";


algebraDefine::usage =
    "define the algebras.";

algebraDefault::usage =
    "set the default algebras.";

algebraReset::usage =
    "reset the algebras.";

algebraUnset::usage =
    "unset the algebras.";

algebraAdd::usage =
    "add elements to the algebras.";

algebraMinus::usage =
    "delete elements from the algebras.";

algebraShow::usage =
    "show the algebra.";


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*$algebraDefine*)


$algebraDefine :=
    clusterGet[$algebraCluster,"StarList"];


(* ::Subsection:: *)
(*$algebraDefault*)


$algebraDefault :=
    clusterGet[$algebraCluster,"StarDefaultList"];


(* ::Subsection:: *)
(*algebraDefine*)


algebraDefine//Options = {
    "ForceReset"->True
};

algebraDefine[algs___String|{algs___String},opts:OptionsPattern[]] :=
    If[OptionValue["ForceReset"]===True,
        starDefineReset[$algebraCluster,{algs}],
        (* Else *)
        starDefine[$algebraCluster,{algs}]
    ];


(* ::Subsection:: *)
(*algebraDefineQ*)


algebraDefineQ::usage =
    "check whether the algebra is defined."

algebraDefineQ[alg_String] :=
    MemberQ[$algebraDefine,alg];

algebraDefineQ[_] :=
    False;


(* ::Subsection:: *)
(*algebraDefault*)


algebraDefault[algs___String|{algs___String}] :=
    starDefault[$algebraCluster,{algs}];


(* ::Subsection:: *)
(*algebraReset*)


algebraReset[algs__String|{algs___String}] :=
    starReset[$algebraCluster,{algs}];


algebraReset[All|PatternSequence[]] :=
    algebraReset@Complement[$algebraDefine,$algebraInternal];

algebraReset[Default] :=
    algebraReset@Complement[$algebraDefault,$algebraInternal];


(* ::Subsection:: *)
(*algebraUnset*)


algebraUnset[algs__String|{algs___String}] :=
    starUnset[$algebraCluster,{algs}];


algebraUnset[All|PatternSequence[]] :=
    algebraUnset@Complement[$algebraDefine,$algebraInternal];

algebraUnset[Default] :=
    algebraUnset@Complement[$algebraDefault,$algebraInternal];


(* ::Subsection:: *)
(*algebraAdd*)


algebraAdd[algs___String|{algs___String}][assoc_] :=
    starMerge[$algebraCluster,{algs},assoc];


(* ::Subsection:: *)
(*algebraMinus*)


(* ::Subsubsection:: *)
(*Main*)


algebraMinus[algs___String|{algs___String}][assoc_] :=
    starChange[$algebraCluster,{algs},{assoc},{
        "Generator"->complementList,
        "Relation"->complementRuleList,
        "Printing"->complementRuleList,
        "Rank"->complementRuleList
    }];


(* ::Subsubsection:: *)
(*Helper*)


complementList[list1_List,list2_List] :=
    DeleteCases[list1,Alternatives@@list2];

complementList[list_List] :=
    list;


complementRuleList[list1_List,rulelist_List] :=
    DeleteCases[list1,Alternatives@@Verbatim/@rulelist];

complementRuleList[list_List] :=
    list;


(* ::Subsection:: *)
(*algebraShow*)


(* ::Subsubsection:: *)
(*Main*)


algebraShow[alg_String?algebraDefineQ] :=
    clusterGet[$algebraCluster,"StarData"][alg]//algebraShowKernel;

algebraShow[] :=
    (
        clusterGet[$algebraCluster,"StarDefaultList"]//algebraShowUnit["Default"]//Print;
        clusterGet[$algebraCluster,"StarDefaultData"]//algebraShowKernel
    );


(* ::Subsubsection:: *)
(*Helper*)


algebraShowKernel[algData_] :=
    TableForm[
        {
            algData["Generator"]//algebraShowUnit["Generator"],
            algData["Relation"]//dropInternalRelation//algebraShowUnit["Relation"],
            (* algData["Printing"]//algebraShowUnit["Printing"], *)
            algData["Rank"]//algebraShowUnit["Rank"],
            algData["Parity"]//algebraShowUnit["Parity"]
        },
        TableSpacing->{4,2},
        TableAlignments->{Left,Top}
    ];


algebraShowUnit["Default"][data_] :=
    Style[
        StringRiffle[data,{"Default: ",", ","."}],
        StandardBlue
    ];

algebraShowUnit["Generator"][data_] :=
    {
        "Generator",
        Row[data,Spacer[4]]
    }//hideEmptyPlanet[data];

algebraShowUnit[planet:"Relation"|"Printing"|"Rank"|"Parity"][data_] :=
    {
        planet,
        data//Map[hideContextMark,#,{1}]&//TableForm
    }//hideEmptyPlanet[data];


hideEmptyPlanet[data_][unit_] :=
    If[data=!={},
        unit,
        (* Else *)
        Nothing
    ];


dropInternalRelation[data_] :=
    DeleteCases[data,Alternatives@@Map[Verbatim,algebraInternal[All]["Relation"]]];


hideContextMark::usage =
    "hide context mark in algebra data.";

hideContextMark/:MakeBoxes[hideContextMark[expr_],form_] :=
    Block[{Internal`$ContextMarks = False},
        MakeBoxes[expr,form]
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
