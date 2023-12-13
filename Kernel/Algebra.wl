(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`"];


(*clear the definitions when developing.*)
ClearAll["`*"];
ClearAll["`*`*"];


Needs["Yurie`Cluster`"];


(* ::Section:: *)
(*Public*)


(* ::Subsection:: *)
(*Algebra*)


(*algebraCluster::usage = 
    "cluster algebra.";*)

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
(*Simplify*)


(* ::Subsubsection:: *)
(*Kernel functions*)


algebraSimplify::usage = 
    "simplify the expression by the default algebra.";
algebraPrint::usage = 
    "format the expression by the default algebra.";
    
scalarQ::usage =
    "check whether the expression is C-number by the default algebra.";
operatorQ::usage =
    "check whether the expression is Q-number by the default algebra.";
generatorQ::usage =
    "check whether the symbol is a generator the default algebra.";    


(* ::Subsubsection:: *)
(*Shortcuts*)


algS::usage = 
    "algebraSimplify.";
algFS::usage =
    "algebraSimplify + FullSimplify.";

algP::usage = 
    "algebraPrint.";
algSP::usage =
    "algebraSimplify + algebraPrint.";
algFSP::usage =
    "algebraSimplify + FullSimplify + algebraPrint.";

algSE::usage =
    "return an equation with the input at right side and the simplified one at left side.";
algFSE::usage =
    "return an equation with the input at right side and the fully simplified one at left side.";

algEqualQ::usage =
    "x==y for Q-numbers.";
algSameQ::usage =
    "x===y for Q-numbers.";


(* ::Subsection:: *)
(*Tensor*)


id::usage = 
    "identity of tensor product.";

tensorThread::usage = 
    "composite tensors over multiplication according to tensorRank.";

tensorRankSet::usage =
    "set the tensor-rank of generators.";
tensorRankGet::usage =
    "get the tensor-rank of operators.";


(* ::Subsection:: *)
(*Addon*)


(* ::Subsubsection:: *)
(*Commutator*)


comm::usage = 
    "commutator.";
commEven::usage = 
    "commutator.";
commOdd::usage = 
    "anti-commutator.";    
commSim::usage = 
    "simplify the commutator.";
commEvenSim::usage = 
    "simplify the commutator.";
commOddSim::usage = 
    "simplify the anti-commutator.";

commDefine::usage = 
    "define commutation relations.";


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
(*Subpackages*)


Get["Yurie`Algebra`Common`"];
Get["Yurie`Algebra`Algebra`"];
Get["Yurie`Algebra`Preset`"];
Get["Yurie`Algebra`Simplify`"];
Get["Yurie`Algebra`Addon`"];
Get["Yurie`Algebra`Tensor`"];


(* ::Subsection:: *)
(*Cluster initiation*)


clusterInit[
    {"algebraCluster","Yurie`Algebra`Common`"},
    {operator,relation,printing},
    {{},{},{}},
    Values@algebraInternal["multiplication"],
    {DeleteDuplicates@*Join,DeleteDuplicates@*Join,DeleteDuplicates@*Join}
];


(* ::Subsubsection:: *)
(*Cache*)


starPostIntercept[algebraCluster,"starUpdateDefault",defaultStar_] :=
    (
        $operatorCache = clusterPropGet[algebraCluster,"starDefaultData"][operator];
        $operatorPatternCache = Alternatives@@$operatorCache;
        $relationCache = clusterPropGet[algebraCluster,"starDefaultData"][relation];
        $printingCache = clusterPropGet[algebraCluster,"starDefaultData"][printing];
    );


(* ::Subsubsection:: *)
(*Preset*)


Module[ {alg},
    algebraDefine@algebraInternal[];
    Table[
        algebraAdd[{alg},algebraInternal[alg]],
        {alg,algebraInternal[]}
    ];
];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
