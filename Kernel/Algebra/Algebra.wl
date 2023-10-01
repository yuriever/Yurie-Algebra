(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Algebra`"];


Needs["Yurie`Cluster`"];
Needs["Yurie`Algebra`"];
Needs["Yurie`Algebra`Common`"];
Needs["Yurie`Algebra`Preset`"];


(* ::Section:: *)
(*Public*)


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


(* ::Section:: *)
(*Private*)


algebraPreset::usage = 
    "define the preset algebras.";


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Constants*)


(* ::Subsubsection:: *)
(*Argument patterns*)


patternAlg = _String|_Symbol;
patternAlgs = (_String|_Symbol)..;
patternAlgList = {(_String|_Symbol)..};


(* ::Subsection:: *)
(*Functions*)


(* ::Subsubsection:: *)
(*Cache*)


starPostIntercept[algebraCluster,"starDefaultUpdate",defaultStar_] :=
    (
        $operatorCache = clusterPropGet[algebraCluster,"starDefaultData"][operator];
        $relationCache = clusterPropGet[algebraCluster,"starDefaultData"][relation];
        $printingCache = clusterPropGet[algebraCluster,"starDefaultData"][printing];
    );


(* ::Subsubsection:: *)
(*algebraDefine*)


algebraDefine[algList:patternAlgList] :=
    starDefine[algebraCluster,algList];

algebraDefine[alg:patternAlg] :=
    algebraDefine[{alg}];


(* ::Subsubsection:: *)
(*algebraDefineQ*)


algebraDefineQ[alg:patternAlg] :=
    MemberQ[clusterPropGet[algebraCluster,"starList"],alg];

algebraDefineQ[_] = False;


(* ::Subsubsection:: *)
(*algebraPreset*)


algebraPreset[] :=
    Module[ {alg},
        algebraDefine@algebraInternal[];
        Table[
            algebraAdd[{alg},algebraInternal[alg]],
            {alg,algebraInternal[]}
        ];
    ];


(* ::Subsubsection:: *)
(*algebraDefault*)


algebraDefault[algList:patternAlgList] :=
    (
        starDefault[algebraCluster,algList];
        Print["Default algebras: ",Row[algList,", "],"."];
    );

algebraDefault[alg:patternAlg] :=
    algebraDefault[{alg}];


(* ::Subsubsection:: *)
(*algebraReset*)


algebraReset[algList:patternAlgList] :=
    starReset[algebraCluster,algList];

algebraReset[alg:patternAlg] :=
    algebraReset[{alg}];


(* ::Subsubsection:: *)
(*algebraUnset*)


algebraUnset[algList:patternAlgList] :=
    starUnset[algebraCluster,algList];

algebraUnset[alg:patternAlg] :=
    algebraUnset[{alg}];


(* ::Subsubsection:: *)
(*algebraAdd*)


algebraAdd[algList:patternAlgList,assoc_] :=
    starMerge[algebraCluster,algList,assoc];

algebraAdd[alg:patternAlg,assoc_] :=
    algebraAdd[{alg},assoc];

algebraAdd[algList:patternAlgList][assoc_] :=
    algebraAdd[algList,assoc];

algebraAdd[alg:patternAlg][assoc_] :=
    algebraAdd[{alg},assoc];


(* ::Subsubsection:: *)
(*algebraShow*)


algebraShow[alg:patternAlg]/;algebraDefineQ[alg] :=
    Module[ {algData},
        algData = clusterPropGet[algebraCluster,"starData"][alg];
        algebraShowKernel[algData[operator],algData[relation],algData[printing]]
    ];

algebraShow[] :=
    Module[ {algData},
        algData = clusterPropGet[algebraCluster,"starDefaultData"];
        Print["Default algebras: ",Row[clusterPropGet[algebraCluster,"starDefaultList"],", "],"."];
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


(* ::Subsection:: *)
(*Default arguments*)


algebraDefine[] :=
    clusterPropGet[algebraCluster,"starList"];


algebraDefault[] :=
    clusterPropGet[algebraCluster,"starDefaultList"];


(*reset/unset the default except internal algebras.*)

algebraReset[] :=
    algebraReset@Complement[algebraDefault[],algebraInternal[]];

algebraUnset[] :=
    algebraUnset@Complement[algebraDefault[],algebraInternal[]];


(*reset/unset the defined except internal algebras.*)

algebraReset[All] :=
    algebraReset@Complement[algebraDefine[],algebraInternal[]];

algebraUnset[All] :=
    algebraUnset@Complement[algebraDefine[],algebraInternal[]];


operator[] :=
    clusterPropGet[algebraCluster,"starDefaultData"][operator];

relation[] :=
    clusterPropGet[algebraCluster,"starDefaultData"][relation];

printing[] :=
    clusterPropGet[algebraCluster,"starDefaultData"][printing];


operator[alg:patternAlg] :=
    clusterPropGet[algebraCluster,"starData"][alg,operator];

relation[alg:patternAlg] :=
    clusterPropGet[algebraCluster,"starData"][alg,relation];

printing[alg:patternAlg] :=
    clusterPropGet[algebraCluster,"starData"][alg,printing];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
