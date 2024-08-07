(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Algebra`"];


Needs["Yurie`Cluster`"];

Needs["Yurie`Algebra`"];

Needs["Yurie`Algebra`Cache`"];

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

algebraShow::usage =
    "show the algebra.";


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Constant*)


patternAlg = _String;

patternAlgs = ___String;

patternAlgList = {___String};


(* ::Subsection:: *)
(*Main*)


(* ::Subsubsection:: *)
(*algebraDefine*)


algebraDefine[algList:patternAlgList] :=
    starDefine[algebraCluster,algList];

algebraDefine[algs:patternAlgs] :=
    starDefine[algebraCluster,{algs}];


(* ::Subsubsection:: *)
(*algebraDefineQ*)


algebraDefineQ[alg:patternAlg] :=
    MemberQ[clusterPropGet[algebraCluster,"StarList"],alg];

algebraDefineQ[_] :=
    False;


(* ::Subsubsection:: *)
(*algebraDefault*)


algebraDefault[algList:patternAlgList] :=
    starDefault[algebraCluster,algList];

algebraDefault[algs:patternAlgs] :=
    starDefault[algebraCluster,{algs}];


(* ::Subsubsection:: *)
(*algebraReset*)


algebraReset[algList:patternAlgList] :=
    starReset[algebraCluster,algList];

algebraReset[algs:patternAlgs] :=
    starReset[algebraCluster,{algs}];


(* ::Subsubsection:: *)
(*algebraUnset*)


algebraUnset[algList:patternAlgList] :=
    starUnset[algebraCluster,algList];

algebraUnset[algs:patternAlgs] :=
    starUnset[algebraCluster,{algs}];


(* ::Subsubsection:: *)
(*algebraAdd*)


algebraAdd[algList:patternAlgList][assoc_] :=
    starMerge[algebraCluster,algList,assoc];

algebraAdd[algs:patternAlgs][assoc_] :=
    starMerge[algebraCluster,{algs},assoc];


(* ::Subsubsection:: *)
(*algebraShow*)


algebraShow[alg:patternAlg]/;algebraDefineQ[alg] :=
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


operator[alg:patternAlg] :=
    clusterPropGet[algebraCluster,"StarData"][alg,operator];

relation[alg:patternAlg] :=
    clusterPropGet[algebraCluster,"StarData"][alg,relation];

printing[alg:patternAlg] :=
    clusterPropGet[algebraCluster,"StarData"][alg,printing];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
