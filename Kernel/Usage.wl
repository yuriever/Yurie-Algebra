

(*Addon.wl*)

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

adjoint::usage =
	"the adjoint action of Lie algebra, ad^order_op expr.";

adjointExp::usage =
	"the adjoint action of Lie group upto the max order, Exp[para op] expr Exp[-para op].";

operatorPower::usage =
	"power of operators, op^order.";

operatorExp::usage =
	"exponential of operators upto the max order, Exp[para op].";

innerProduct::usage =
	"inner product of two vectors, A \[CircleTimes] A -> k.";

scalarSeparate::usage =
	"separate scalars and operators.";

scalarExtract::usage =
	"extract scalars.";

checkLieBracket::usage =
	"check the Jacobi identity of Lie algebras.";

checkLieModule::usage =
	"check the definition of Lie modules.";


(*Algebra.wl*)

algebraCluster::usage =
	"cluster algebra.";

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


(*Simplify.wl*)

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


(*Tensor.wl*)

id::usage =
	"identity of tensor product.";

tensorRankEqualQ::usage =
	"check whether the ranks of two tensors are equal.";

tensorRankSet::usage =
	"set the tensor-rank of generators.";

tensorRankGet::usage =
	"get the tensor-rank of operators.";

tensorCompose::usage =
	"composite tensors over multiplication according to tensor-rank.";