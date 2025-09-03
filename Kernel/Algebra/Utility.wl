(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Utility`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


(* ::Subsection:: *)
(*Commutator*)


comm::usage =
    "commutator.";

anticomm::usage =
    "anti-commutator.";

commSim::usage =
    "simplify the commutator.";

anticommSim::usage =
    "simplify the anti-commutator.";

commDefine::usage =
    "define the (anti-)commutator with the given order and condition.";


(* ::Subsection:: *)
(*Adjoint*)


adjoint::usage =
    "the adjoint action of Lie algebra.";

adjointExp::usage =
    "the adjoint action of formal Lie group truncated at the given order.";


(* ::Subsection:: *)
(*Power*)


operatorPower::usage =
    "power of the operator.";

operatorExp::usage =
    "exponential of the operator truncated at the given order.";


(* ::Subsection:: *)
(*Utility*)


operatorSeparate::usage =
    "separate scalars and operators in the given linear expression.";


scalarSimplify::usage =
    "simplify the scalar part of the expression.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Commutator*)


(* ::Text:: *)
(*n-commutator: [x,y,z,...]=[x,[y,[z,...]]]*)


comm[x_,y_] :=
    x**y-y**x;

comm[x_,y__] :=
    x**comm[y]-comm[y]**x;


commSim[x__] :=
    comm[x]//algebraSimplify;


(* ::Text:: *)
(*n-anti-commutator: {x,y,z,...}={x,{y,{z,...}}}*)


anticomm[x_,y_] :=
    x**y+y**x;

anticomm[x_,y__] :=
    x**anticomm[y]+anticomm[y]**x;


anticommSim[x__] :=
    anticomm[x]//algebraSimplify;


(* ::Subsubsection:: *)
(*commDefine*)


commDefine/:rule_[
    commDefine[x_,y_,
        OrderlessPatternSequence[
            sign:(0|1):0,
            order:(Normal|Reverse):Normal
        ]
    ],
    result_
] :=
    If[ order===Normal,
        Inactive[rule][
            x**y,
            (-1)^sign*stripPattern@y**stripPattern@x+result
        ],
        (* Else *)
        Inactive[rule][
            y**x,
            (-1)^sign*stripPattern@x**stripPattern@y-(-1)^sign*result
        ]
    ]//Activate;

commDefine/:rule_[
    commDefine[x_,y_,
        OrderlessPatternSequence[
            sign:(0|1):0,
            order:(Normal|Reverse):Normal
        ]
    ],
    Verbatim[Condition][result_,condition_]
]:=
    If[ order===Normal,
        Inactive[rule][
            x**y,
            Condition[(-1)^sign*stripPattern@y**stripPattern@x+result,condition]
        ],
        Inactive[rule][
            y**x,
            Condition[(-1)^sign*stripPattern@x**stripPattern@y-(-1)^sign*result,condition]
        ]
    ]//Activate;


stripPattern[pattern_] :=
    pattern//ReplaceRepeated[{
        (
            Verbatim[Pattern]|Verbatim[Optional]|
                Verbatim[PatternTest]|Verbatim[Condition]
        )[pattern1_,_]:>pattern1
    }];


(* ::Subsection:: *)
(*Adjoint*)


(* ::Text:: *)
(*adjoint[x,n][y]=[x,[x,[...,y]]]*)


adjoint[op_,0][expr_] :=
    expr;

adjoint[op_,order_:1][expr_] :=
    comm[Sequence@@ConstantArray[op,order],expr];


adjointExp[op_,max_,t_:1][expr_] :=
    Module[ {order},
        Sum[adjoint[op,order][expr]*t^order/order!,{order,0,max}]
    ];


(* ::Subsection:: *)
(*Power*)


operatorPower[op_,0] :=
    id;

operatorPower[op_,1] :=
    op;

operatorPower[op_,order_Integer?Positive] :=
    ConstantArray[op,order]//Apply[NonCommutativeMultiply];


operatorExp[op_,0,t_:1] :=
    id;

operatorExp[op_,max_Integer?Positive,t_:1] :=
    Module[ {i},
        Sum[operatorPower[op,i]*t^i/i!,{i,0,max}]
    ];


(* ::Subsection:: *)
(*Utility: operatorSeparate*)


(* ::Subsubsection:: *)
(*Message*)


operatorSeparate::ExtractionFailed =
    "The extracted operators together with their coefficients cannot recover the original expression.";

operatorSeparate::NotOperator =
    "The expression is not an operator.";


(* ::Subsubsection:: *)
(*Option*)


operatorSeparate//Options = {
    "Scalar"->True,
    "Operator"->False
};


(* ::Subsubsection:: *)
(*Main*)


operatorSeparate[expr_,opts:OptionsPattern[]] :=
    Module[ {result},
        result = expr//operatorSeparateKernel;
        Switch[{OptionValue["Scalar"],OptionValue["Operator"]},
            {True,True},
                result[[1]]->result[[2]]//Thread,
            {True,False},
                result//Last,
            {False,True},
                result//First
        ]
    ]//Catch;

operatorSeparate[exprList_List,opts:OptionsPattern[]] :=
    exprList//Flatten//DeleteCases[0]//Map[operatorSeparate[#,opts]&]//Flatten;


(* ::Subsubsection:: *)
(*Helper*)


operatorSeparateKernel[expr_] :=
    Module[ {opList,coList},
        opList = operatorList[expr];
        coList = Map[Coefficient[expr,#]&,opList];
        If[ scalarSimplify[opList . coList-expr]=!=0,
            Message[operatorSeparate::ExtractionFailed];
            expr//Throw
        ];
        {opList,coList}
    ];


operatorList[expr:_Plus|_Times] :=
    DeleteDuplicates@Cases[
        expr//Expand,
        c_.*Shortest[op_]/;scalarQ[c]&&operatorQ[op]:>op
    ];

operatorList[expr:_NonCommutativeMultiply|_tensor] :=
    {expr};

operatorList[expr_?generatorQ] :=
    {expr};

operatorList[expr_?scalarQ] :=
    (
        Message[operatorSeparate::NotOperator];
        expr//Throw
    );


(* ::Subsection:: *)
(*Utility: scalarSimplify*)


scalarSimplify[expr_] :=
    Activate[
        Inactivate[expr,NonCommutativeMultiply]//Simplify,
        NonCommutativeMultiply
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
