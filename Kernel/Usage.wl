

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


(*Check.wl*)

checkLieBracket::usage =
	"check the Jacobi identity of Lie algebra.";

checkLieModule::usage =
	"check the action on Lie module.";

checkAssociativity::usage =
	"check the associativity of multiplication.";

checkCoassociativity::usage =
	"check the coassociativity of comultiplication.";


(*Conjugate.wl*)

conjugate::usage =
	"conjugate of the operator.";

innerProduct::usage =
	"inner product of two operators.";


(*Simplify.wl*)

algebraSimplify::usage =
	"simplify the expression by the default algebra.";

algebraPrint::usage =
	"format the expression by the default algebra.";

scalarQ::usage =
	"check whether the expression is a scalar by the default algebra.";

operatorQ::usage =
	"check whether the expression is an operator by the default algebra.";

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

tensor::usage =
	"tensor product.";

comultiply::usage =
	"comultiplication of coalgebra.";

counit::usage =
	"counit of coalgebra.";

antipode::usage =
	"antipode of Hopf algebra.";

tensorRankEqualQ::usage =
	"check whether the ranks of two tensors are equal.";

tensorRankSet::usage =
	"set the tensor-rank of generators.";

tensorRankGet::usage =
	"get the tensor-rank of operators.";

tensorCompose::usage =
	"composite tensors over multiplication according to tensor-rank.";


(*Utility.wl*)

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
	"power of the operator, op^order.";

operatorExp::usage =
	"exponential of the operator upto the max order, Exp[para op].";

scalarSeparate::usage =
	"separate scalars and operators.";

scalarExtract::usage =
	"extract scalars.";