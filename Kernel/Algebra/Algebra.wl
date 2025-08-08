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
(*algebraDefine*)


algebraDefine[algs___String|{algs___String}] :=
    starDefine[$algebraCluster,{algs}];


(* ::Subsection:: *)
(*algebraDefineQ*)


algebraDefineQ::usage =
    "check whether the algebra is defined."

algebraDefineQ[alg_String] :=
    MemberQ[clusterPropGet[$algebraCluster,"StarList"],alg];

algebraDefineQ[_] :=
    False;


(* ::Subsection:: *)
(*algebraDefault*)


algebraDefault[algs___String|{algs___String}] :=
    starDefault[$algebraCluster,{algs}];


(* ::Subsection:: *)
(*algebraReset*)


algebraReset[algs___String|{algs___String}] :=
    starReset[$algebraCluster,{algs}];


(* ::Subsection:: *)
(*algebraUnset*)


algebraUnset[algs___String|{algs___String}] :=
    starUnset[$algebraCluster,{algs}];


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
    clusterPropGet[$algebraCluster,"StarData"][alg]//algebraShowKernel;

algebraShow[] :=
    (
        clusterPropGet[$algebraCluster,"StarDefaultList"]//algebraShowUnit["Default"]//Print;
        clusterPropGet[$algebraCluster,"StarDefaultData"]//algebraShowKernel
    );


(* ::Subsubsection:: *)
(*Helper*)


algebraShowKernel[algData_] :=
    TableForm[
        {
            algData["Generator"]//algebraShowUnit["Generator"],
            algData["Relation"]//algebraShowUnit["Relation"],
            algData["Printing"]//algebraShowUnit["Printing"],
            algData["Rank"]//algebraShowUnit["Rank"],
            algData["Parity"]//algebraShowUnit["Parity"]
        },
        TableSpacing->{4,2},
        TableAlignments->{Left,Top}
    ];


algebraShowUnit["Default"][data_] :=
    StringRiffle[
        data,
        {"Default: ",", ","."}
    ];

algebraShowUnit["Generator"][data_] :=
    {
        "Generator",
        Row[data,Spacer[4]]
    }//hideEmptyPlanet[data];

algebraShowUnit[planet:"Relation"|"Printing"|"Rank"|"Parity"][data_] :=
    {
        planet,
        data//Map[hideContextInRelation,#,{1}]&//TableForm
    }//hideEmptyPlanet[data];


hideEmptyPlanet[data_][unit_] :=
    If[ data=!={},
        unit,
        (*Else*)
        Nothing
    ];


hideContextInRelation::usage =
    "hide context in algebra relations.";

hideContextInRelation/:MakeBoxes[hideContextInRelation[expr_],form_] :=
    Block[ {Internal`$ContextMarks = False},
        MakeBoxes[expr,form]
    ];


(* ::Subsection:: *)
(*Default argument*)


algebraDefine[] :=
    clusterPropGet[$algebraCluster,"StarList"];


algebraDefault[] :=
    clusterPropGet[$algebraCluster,"StarDefaultList"];


(*reset/unset the defined except internal algebras.*)

algebraReset[] :=
    algebraReset@Complement[algebraDefine[],algebraInternal[]];

algebraUnset[] :=
    algebraUnset@Complement[algebraDefine[],algebraInternal[]];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
