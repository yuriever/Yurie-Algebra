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


id::usage =
    "identity operator.";


operator::usage =
    "planet operator.";

relation::usage =
    "planet relation.";

printing::usage =
    "planet printing.";


algebraDefine::usage =
    "define algebras.";

algebraDefineQ::usage =
    "check whether an algebra is defined.";

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
    starDefine[algebraCluster,{algs}];


(* ::Subsection:: *)
(*algebraDefineQ*)


algebraDefineQ[alg_String] :=
    MemberQ[clusterPropGet[algebraCluster,"StarList"],alg];

algebraDefineQ[_] :=
    False;


(* ::Subsection:: *)
(*algebraDefault*)


algebraDefault[algs___String|{algs___String}] :=
    starDefault[algebraCluster,{algs}];


(* ::Subsection:: *)
(*algebraReset*)


algebraReset[algs___String|{algs___String}] :=
    starReset[algebraCluster,{algs}];


(* ::Subsection:: *)
(*algebraUnset*)


algebraUnset[algs___String|{algs___String}] :=
    starUnset[algebraCluster,{algs}];


(* ::Subsection:: *)
(*algebraAdd*)


algebraAdd[algs___String|{algs___String}][assoc_] :=
    starMerge[algebraCluster,{algs},assoc];


(* ::Subsection:: *)
(*algebraMinus*)


(* ::Subsubsection:: *)
(*Main*)


algebraMinus[algs___String|{algs___String}][assoc_] :=
    starChange[algebraCluster,{algs},{assoc},{operator->complementList,relation->complementRuleList,printing->complementRuleList}];


(* ::Subsubsection:: *)
(*Helper*)


complementList[list1_List,list2_List] :=
    DeleteCases[list1,Alternatives@@list2];

complementList[list_List] :=
    list;


complementRuleList[list1_List,rulelist_List] :=
    DeleteCases[list1,Alternatives@@Verbatim/@rulelist];

complementRuleList[list_List] :=
    list

(* ::Subsection:: *)
(*algebraShow*)


(* ::Subsubsection:: *)
(*Main*)


algebraShow[alg_String]/;algebraDefineQ[alg] :=
    Module[ {algData},
        algData = clusterPropGet[algebraCluster,"StarData"][alg];
        algebraShowKernel[algData[operator],algData[relation],algData[printing]]
    ];

algebraShow[] :=
    Module[ {algData},
        algData = clusterPropGet[algebraCluster,"StarDefaultData"];
        Print["Default algebras: ",Row[clusterPropGet[algebraCluster,"StarDefaultList"],", "],"."];
        algebraShowKernel[algData[operator],algData[relation],algData[printing]]
    ];


(* ::Subsubsection:: *)
(*Helper*)


algebraShowKernel[operatorList_,relationList_,printingList_] :=
    TableForm[
        {
            "Operators:",
            operatorList//Row[#,Spacer[4]]&,
            "Relations:",
            relationList//Map[hideContextInRelation,#,{1}]&//TableForm,
            "Printings:",
            printingList//Map[hideContextInRelation,#,{1}]&//TableForm
        },
        TableDepth->1,
        TableSpacing->{2,2},
        TableAlignments->{Left,Top}
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
    clusterPropGet[algebraCluster,"StarList"];


algebraDefault[] :=
    clusterPropGet[algebraCluster,"StarDefaultList"];


(*reset/unset the defined except internal algebras.*)

algebraReset[] :=
    algebraReset@Complement[algebraDefine[],algebraInternal[]];

algebraUnset[] :=
    algebraUnset@Complement[algebraDefine[],algebraInternal[]];


operator[] :=
    clusterPropGet[algebraCluster,"StarDefaultData"][operator];

relation[] :=
    clusterPropGet[algebraCluster,"StarDefaultData"][relation];

printing[] :=
    clusterPropGet[algebraCluster,"StarDefaultData"][printing];


operator[alg_String] :=
    clusterPropGet[algebraCluster,"StarData"][alg,operator];

relation[alg_String] :=
    clusterPropGet[algebraCluster,"StarData"][alg,relation];

printing[alg_String] :=
    clusterPropGet[algebraCluster,"StarData"][alg,printing];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
