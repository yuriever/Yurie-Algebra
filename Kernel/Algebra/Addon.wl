(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Addon`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


(* ::Subsubsection:: *)
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
    "define commutation relations with condition, order-reversing or anti-commutator.";


(* ::Subsubsection:: *)
(*Adjoint*)


adjoint::usage =
    "the adjoint action of Lie algebra, ad^order_op expr."

adjointExp::usage =
    "the adjoint action of Lie group upto the max order, Exp[para op] expr Exp[-para op].";


(* ::Subsubsection:: *)
(*Power and exp*)


operatorPower::usage =
    "power of operators, op^order.";

operatorExp::usage =
    "exponential of operators upto the max order, Exp[para op].";


(* ::Subsubsection:: *)
(*Inner product*)


innerProduct::usage =
    "inner product of two vectors, A \[CircleTimes] A -> k.";


(* ::Subsubsection:: *)
(*Scalar extraction*)


scalarSeparate::usage =
    "separate scalars and operators.";

scalarExtract::usage =
    "extract scalars.";


(* ::Subsubsection:: *)
(*Definition checking*)


checkLieBracket::usage =
    "check the Jacobi identity of Lie algebras.";

checkLieModule::usage =
    "check the definition of Lie modules.";


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


commDefine/:(
    commDefine[x_,y_,
        OrderlessPatternSequence[
            sign:(0|1):0,
            order:(Normal|Reverse):Normal
        ]
    ]:>result_
) :=
    If[ order===Normal,
        Inactive[RuleDelayed][
            x**y,
            (-1)^sign*stripPattern@y**stripPattern@x+result
        ]//Activate,
        Inactive[RuleDelayed][
            y**x,
            (-1)^sign*stripPattern@x**stripPattern@y-(-1)^sign*result
        ]//Activate
    ];

commDefine/:(
    commDefine[x_,y_,
        OrderlessPatternSequence[
            sign:(0|1):0,
            order:(Normal|Reverse):Normal
        ]
    ]:>Verbatim[Condition][result_,condition_]
) :=
    If[ order===Normal,
        Inactive[RuleDelayed][
            x**y,
            Condition[(-1)^sign*stripPattern@y**stripPattern@x+result,condition]
        ]//Activate,
        Inactive[RuleDelayed][
            y**x,
            Condition[(-1)^sign*stripPattern@x**stripPattern@y-(-1)^sign*result,condition]
        ]//Activate
    ];


stripPattern[pattern_] :=
    pattern//.{
        (
            Verbatim[Pattern]|Verbatim[Optional]|
                Verbatim[PatternTest]|Verbatim[Condition]
        )[$$pattern_,_]:>$$pattern
    };


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
(*Power and exp*)


operatorPower[_,0] =
    1;

operatorPower[op_,1] :=
    op;

operatorPower[op_,order_:1] :=
    NonCommutativeMultiply@@ConstantArray[op,order];


operatorExp[op_,max_,t_:1] :=
    Module[ {order},
        Sum[operatorPower[op,order] t^order/order!,{order,0,max}]
    ];


(* ::Subsection:: *)
(*Inner product*)


innerProduct[x_,y_] :=
    SuperDagger[x]**y;

innerProduct[x_] :=
    SuperDagger[x]**x;


(* ::Subsection:: *)
(*Scalar extraction*)


scalarSeparate[exprs__] :=
    scalarSeparateKernel[exprs];

scalarExtract[exprs__] :=
    scalarSeparateKernel[exprs]/.HoldPattern[x_->y_]:>x//DeleteDuplicates;


scalarSeparateKernel[0] :=
    0->0;

scalarSeparateKernel[c_?scalarQ*op_?generatorQ] :=
    c->op;

scalarSeparateKernel[c_?scalarQ*op_NonCommutativeMultiply] :=
    c->op;

scalarSeparateKernel[term1_+term2_] :=
    {scalarSeparateKernel@term1,scalarSeparateKernel@term2}//Flatten;

scalarSeparateKernel[{exprs__}] :=
    {exprs}//Map[scalarSeparateKernel]//Flatten;


(* ::Subsection:: *)
(*Definition checking*)


checkLieBracket[x_,y_,z_] :=
    {x,y,z}->
        Simplify[
            commSim[x,commSim[y,z]]+
            commSim[y,commSim[z,x]]+
            commSim[z,commSim[x,y]]
        ];


checkLieModule[x_,y_,z_] :=
    {x,y,z}->
        Simplify[
            algebraSimplify[commSim[x,y]**z]-
            algebraSimplify[x**algebraSimplify[y**z]]+
            algebraSimplify[y**algebraSimplify[x**z]]
        ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
