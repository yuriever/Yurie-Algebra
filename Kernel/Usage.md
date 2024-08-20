<!-- Algebra.wl -->

* `#!wl algebraDefine` - define the algebras.

* `#!wl algebraDefault` - set the default algebras.

* `#!wl algebraReset` - reset the algebras.

* `#!wl algebraUnset` - unset the algebras.

* `#!wl algebraAdd` - add elements to the algebras.

* `#!wl algebraMinus` - delete elements from the algebras.

* `#!wl algebraShow` - show the algebra.


<!-- Check.wl -->

* `#!wl checkLieBracket` - check the Jacobi identity of Lie algebra.

* `#!wl checkLieModule` - check the action on Lie module.

* `#!wl checkCoassociativity` - check the coassociativity of comultiplication.

* `#!wl checkCounitality` - check the counitality of counit.

* `#!wl checkAntipode` - check the antipode of Hopf algebra.


<!-- Conjugate.wl -->

* `#!wl conjugate` - conjugate of the operator.

* `#!wl innerProduct` - inner product of the two operators.


<!-- Core.wl -->

* `#!wl id` - identity operator.

* `#!wl generator` - return the generators of the default/specified algebra.

* `#!wl relation` - return the defining relations of the default/specified algebra.

* `#!wl printing` - return the formatting rules of the default/specified algebra.

* `#!wl generatorQ` - check whether the expression is a generator by the default algebra.

* `#!wl scalarQ` - check whether the expression is a scalar by the default algebra.

* `#!wl operatorQ` - check whether the expression is an operator by the default algebra.

* `#!wl algebraSimplify` - simplify the expression by the default algebra.

* `#!wl algebraPrint` - format the expression by the default algebra.

* `#!wl tensorank` - return the tensor rank of the expression by the default algebra.

* `#!wl tensorankSafe` - check whether the expression is valid and return the tensor rank of by the default algebra.

* `#!wl parity` - return the parity of the expression by the default algebra.

* `#!wl algS` - algebraSimplify.

* `#!wl algFS` - algebraSimplify + FullSimplify.

* `#!wl algP` - algebraPrint.

* `#!wl algSP` - algebraSimplify + algebraPrint.

* `#!wl algFSP` - algebraSimplify + FullSimplify + algebraPrint.

* `#!wl algEqualQ` - x==y for operators.

* `#!wl algSameQ` - x===y for operators.


<!-- Tensor.wl -->

* `#!wl tensor` - tensor product.

* `#!wl comultiply` - comultiplication of coalgebra.

* `#!wl counit` - counit of coalgebra.

* `#!wl antipode` - antipode of Hopf algebra.

* `#!wl tensorCompose` - composite the tensors over multiplication according to tensor rank.

* `#!wl tensorPermute` - permute the arguments of the tensor.


<!-- Utility.wl -->

* `#!wl comm` - commutator.

* `#!wl anticomm` - anti-commutator.

* `#!wl commSim` - simplify the commutator.

* `#!wl anticommSim` - simplify the anti-commutator.

* `#!wl commDefine` - define the (anti-)commutator with the given order and condition.

* `#!wl adjoint` - the adjoint action of Lie algebra.

* `#!wl adjointExp` - the adjoint action of formal Lie group truncated at the given order.

* `#!wl operatorPower` - power of the operator.

* `#!wl operatorExp` - exponential of the operator truncated at the given order.

* `#!wl operatorSeparate` - separate scalars and operators in the given linear expression.