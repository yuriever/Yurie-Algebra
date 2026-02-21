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
    "algebraDefine[algs]: define the algebras.";

algebraDefault::usage =
    "algebraDefault[algs]: set the default algebras.";

algebraReset::usage =
    "algebraReset[algs]: reset the algebras.";

algebraUnset::usage =
    "algebraUnset[algs]: unset the algebras.";

algebraAdd::usage =
    "algebraAdd[algs][assoc]: add elements to the algebras.";

algebraMinus::usage =
    "algebraMinus[algs][assoc]: delete elements from the algebras.";

algebraShow::usage =
    "algebraShow[]: show the default algebra."<>
    "\n"<>
    "algebraShow[All]: show all the defined algebras."<>
    "\n"<>
    "algebraShow[alg]: show the algebra.";


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Helper*)


$algebraDefine :=
    clusterGet[$algebraCluster,"StarList"];


$algebraDefault :=
    clusterGet[$algebraCluster,"StarDefaultList"];


algebraDefineQ::usage =
    "check whether the algebra is defined."

algebraDefineQ[alg_String] :=
    MemberQ[$algebraDefine,alg];

algebraDefineQ[_] :=
    False;


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
(*Option*)


algebraShow//Options = {
    "HideInternal"->True
};


(* ::Subsubsection:: *)
(*Main*)


algebraShow[alg_String?algebraDefineQ] :=
    algebraShowKernel[alg,False,False,False];

algebraShow[opts:OptionsPattern[]] :=
    algebraShowKernel[Default,False,True,OptionValue["HideInternal"]];

algebraShow[All,opts:OptionsPattern[]] :=
    algebraShowKernel[Default,True,True,OptionValue["HideInternal"]];


(* ::Subsubsection:: *)
(*Helper*)


algebraShowKernel[alg_,ifShowDefine_?BooleanQ,ifShowDefault_?BooleanQ,ifHideInternal_?BooleanQ] :=
    With[{
            size = AbsoluteCurrentValue[EvaluationNotebook[],WindowSize],
            algData =
                If[alg===Default,
                    (* Then *)
                    clusterGet[$algebraCluster,"StarDefaultData"],
                    (* Else *)
                    clusterGet[$algebraCluster,"StarData"][alg]
                ]
        },
        {
            widthNumber = UpTo@Round[size[[1]]/320],
            height = UpTo@Round[size[[2]]/4]
        },
        Panel[
            TableForm[
                {
                    If[ifShowDefine,
                        (* Then *)
                        $algebraDefine//algebraShowUnit["Define",widthNumber,height],
                        (* Else *)
                        Nothing
                    ],

                    If[ifShowDefault,
                        (* Then *)
                        $algebraDefault//algebraShowUnit["Default",widthNumber,height],
                        (* Else *)
                        Nothing
                    ],

                    algData["Generator"]//algebraShowUnit["Generator",widthNumber,height],
                    algData["Relation"]//dropInternalRelation[ifHideInternal]//algebraShowUnit["Relation",widthNumber,height],
                    algData["Rank"]//algebraShowUnit["Rank",widthNumber,height],
                    algData["Parity"]//algebraShowUnit["Parity",widthNumber,height]
                },
                TableSpacing->{5,5},
                TableAlignments->{Left,Top}
            ]
        ]
    ];


algebraShowUnit[planet:"Define"|"Default",widthNumber_,height_][data_] :=
    TableForm[
        Partition[
            Map[coloringInternalAlgebra,data],
            widthNumber
        ]
    ]//algebraShowUnitPane[planet,widthNumber,height];


algebraShowUnit[planet:"Generator",widthNumber_,height_][data_] :=
    TableForm[
        Partition[algebraPrint[data],widthNumber]
    ]//algebraShowUnitPane[planet,widthNumber,height];


algebraShowUnit[planet:"Relation"|"Printing"|"Rank"|"Parity",widthNumber_,height_][data:Except[{}]] :=
    Style[
        Column[
            Map[hideContextMark,algebraPrint[data],{1}],
            Left,1
        ],
        LineBreakWithin->False
    ]//algebraShowUnitPane[planet,widthNumber,height];

algebraShowUnit[planet:"Relation"|"Printing"|"Rank"|"Parity",___][{}] :=
    Nothing;


algebraShowUnitPane[planet_,widthNumber_,height_][data_] :=
    {
        Style[planet,colorOfPlanet[planet]],
        Pane[
            data,
            ImageSize->{Automatic,height},
            Scrollbars->False,
            AppearanceElements->None
        ]
    };


colorOfPlanet["Define"] :=
    StandardBlue;

colorOfPlanet["Default"] :=
    StandardBlue;

colorOfPlanet["Generator"|"Relation"|"Printing"|"Rank"|"Parity"] :=
    StandardCyan;


coloringInternalAlgebra[alg_] :=
    If[MemberQ[$algebraInternal,alg],
        (* Then *)
        Style[alg,Underlined],
        (* Else *)
        alg
    ];


dropInternalRelation[True][data_] :=
    DeleteCases[data,Alternatives@@Map[Verbatim,algebraInternal[All]["Relation"]]];

dropInternalRelation[False][data_] :=
    data;


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
