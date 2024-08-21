(* Algebra.wl *)

algebraDefine::usage =
	"define the algebras.";

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


(* Check.wl *)

checkLieBracket::usage =
	"check the Jacobi identity of Lie algebra.";

checkLieModule::usage =
	"check the action on Lie module.";

checkCoassociativity::usage =
	"check the coassociativity of comultiplication.";

checkCounitality::usage =
	"check the counitality of counit.";

checkAntipode::usage =
	"check the antipode of Hopf algebra.";


(* Conjugate.wl *)

conjugate::usage =
	"conjugate of the operator.";

innerProduct::usage =
	"inner product of the two operators.";


(* Core.wl *)

id::usage =
	"identity operator.";

generator::usage =
	"return the generators of the default/specified algebra.";

relation::usage =
	"return the defining relations of the default/specified algebra.";

printing::usage =
	"return the formatting rules of the default/specified algebra.";

generatorQ::usage =
	"check whether the expression is a generator by the default algebra.";

scalarQ::usage =
	"check whether the expression is a scalar by the default algebra.";

operatorQ::usage =
	"check whether the expression is an operator by the default algebra.";

algebraSimplify::usage =
	"simplify the expression by the default algebra.";

algebraPrint::usage =
	"format the expression by the default algebra.";

tensorank::usage =
	"return the tensor rank of the expression by the default algebra.";

tensorankUnsafe::usage =
	"return the tensor rank of the expression by the default algebra without validating the expression.";

parity::usage =
	"return the parity of the expression by the default algebra.";

parityUnsafe::usage =
	"return the parity of the expression by the default algebra without validating the expression.";

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

algEqualQ::usage =
	"x==y for operators.";

algSameQ::usage =
	"x===y for operators.";


(* Tensor.wl *)

tensor::usage =
	"tensor product.";

comultiply::usage =
	"comultiplication of coalgebra.";

counit::usage =
	"counit of coalgebra.";

antipode::usage =
	"antipode of Hopf algebra.";

tensorCompose::usage =
	"composite the tensors over multiplication according to tensor rank.";

tensorPermute::usage =
	"permute the arguments of the tensor.";


(* Utility.wl *)

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

adjoint::usage =
	"the adjoint action of Lie algebra.";

adjointExp::usage =
	"the adjoint action of formal Lie group truncated at the given order.";

operatorPower::usage =
	"power of the operator.";

operatorExp::usage =
	"exponential of the operator truncated at the given order.";

operatorSeparate::usage =
	"separate scalars and operators in the given linear expression.";