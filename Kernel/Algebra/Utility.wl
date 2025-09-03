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

commSim::usage =
    "simplify the commutator.";

commIn::usage =
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
(*n-anti-commutator: {x,y,z,...}={x,{y,{z,...}}}*)


(* ::Subsubsection:: *)
(*Main*)


comm[x:Except[_List],y:Except[_List],sign:0|1:0] :=
    commKernel[{x,y},sign];

comm[{x___},sign:0|1:0] :=
    commKernel[{x},sign];


commSim[x___] :=
    comm[x]//algebraSimplify;


commIn/:(rule:Rule|RuleDelayed)[
    commIn[x_,y_,
        OrderlessPatternSequence[
            sign:(0|1):0,
            order:(Normal|Reverse):Normal
        ]
    ],
    result_
] :=
    commInKernel[{x,y,result},order,sign,rule]//Activate;

commIn/:(rule:Rule|RuleDelayed)[
    commIn[x_,y_,
        OrderlessPatternSequence[
            sign:(0|1):0,
            order:(Normal|Reverse):Normal
        ]
    ],
    Verbatim[Condition][result_,condition_]
]:=
    commInKernel[{x,y,result,condition},order,sign,rule]//Activate;


(* ::Subsubsection:: *)
(*Helper*)


commKernel[{},_] :=
    id;

commKernel[{x_},_] :=
    x;

commKernel[{x_,y_},0] :=
    x**y-y**x;

commKernel[{x_,y_},1] :=
    x**y+y**x;

commKernel[{x_,y__},0] :=
    x**commKernel[{y},0]-commKernel[{y},0]**x;

commKernel[{x_,y__},1] :=
    x**commKernel[{y},1]+commKernel[{y},1]**x;


commInKernel//Attributes = {
    HoldFirst
};

commInKernel[{x_,y_,res_},Normal,sign_,rule_] :=
    Inactive[rule][
        x**y,
        (-1)^sign*stripPattern@y**stripPattern@x+res
    ];

commInKernel[{x_,y_,res_,condition_},Normal,sign_,rule_] :=
    Inactive[rule][
        x**y,
        Condition[(-1)^sign*stripPattern@y**stripPattern@x+res,condition]
    ];

commInKernel[{x_,y_,res_},Reverse,sign_,rule_] :=
    Inactive[rule][
        y**x,
        (-1)^sign*stripPattern@x**stripPattern@y-(-1)^sign*res
    ];

commInKernel[{x_,y_,res_,condition_},Reverse,sign_,rule_] :=
    Inactive[rule][
        y**x,
        Condition[(-1)^sign*stripPattern@x**stripPattern@y-(-1)^sign*res,condition]
    ];


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
