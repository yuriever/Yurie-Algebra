(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Internal`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


algebraInternal::usage =
    "internal algebras.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


algebraInternal[] = {
    "Algebra",
    "Conjugate",
    "Tensor",
    "Coalgebra",
    "Bialgebra",
    "Antipode"
};


NonCommutativeMultiply//Unprotect;

NonCommutativeMultiply//ClearAll;

NonCommutativeMultiply//Attributes =
    {Flat,OneIdentity};


tensor//Attributes =
    {Flat,OneIdentity};


(* ::Subsubsection:: *)
(*Multiplication*)


algebraInternal["Algebra"] = <|
    operator->{id},
    relation->{
        (*linearity*)
        (k_?scalarQ*x_)**y_:>k*x**y,
        x_**(k_?scalarQ*y_):>k*x**y,
        (x_+y_)**z_:>x**z+y**z,
        z_**(x_+y_):>z**x+z**y,
        (*zero*)
        0**_->0,
        _**0->0,
        (*NonCommutativeMultiply[___,0,___]->0,*)
        (*identity*)
        id**x_:>x,
        x_**id:>x
        (*this is the old rule handling scalars without id.*)
        (*x_**y_/;scalarQ[x]||scalarQ[y]:>x*y,*)
    },
    printing->{
        id->1
    }
|>;


(* ::Subsubsection:: *)
(*Tensor product*)


algebraInternal["Tensor"] = <|
    operator->{},
    relation->{
        (*linearity*)
        tensor[x_,k_?scalarQ*y_.]:>
            k*tensor[x,y],
        tensor[k_?scalarQ*x_.,y_]:>
            k*tensor[x,y],
        tensor[x_+y_,z_]:>
            tensor[x,z]+tensor[y,z], 
        tensor[z_,x_+y_]:>
            tensor[z,x]+tensor[z,y],
        (*composition*)
        x_tensor**y_tensor:>
            tensorCompose[x**y]/;tensorRankEqualQ[x,y]
    },
    printing->{
        tensor->CircleTimes
    }
|>;


(* ::Subsubsection:: *)
(*Conjugate*)


algebraInternal["Conjugate"] = <|
    operator->{},
    relation->{
        (*linearity*)
        conjugate[k_?scalarQ*x_.]:>
            Conjugate[k]*conjugate[x],
        conjugate[x_+y_]:>
            conjugate[x]+conjugate[y],
        (*anti-morphism*)
        conjugate[x_**y_]:>
            conjugate[y]**conjugate[x],
        (*identity*)
        conjugate[id]:>id
    },
    printing->{
        conjugate->SuperDagger
    }
|>;


(* ::Subsubsection:: *)
(*Coalgebra*)


algebraInternal["Coalgebra"] = <|
    operator->{},
    relation->{
        (*linearity*)
        comultiply[k_?scalarQ*x_.]:>
            k*comultiply[x],
        comultiply[x_+y_]:>
            comultiply[x]+comultiply[y],
        (*linearity*)
        counit[k_?scalarQ*x_.]:>
            k*counit[x],
        counit[x_+y_]:>
            counit[x]+counit[y]
    },
    printing->{
        comultiply->"\[CapitalDelta]",
        counit->"\[Epsilon]"
    }
|>;


(* ::Subsubsection:: *)
(*Bialgebra*)


algebraInternal["Bialgebra"] = <|
    operator->{},
    relation->{
        (*compatibility between coalgebra and algebra structures*)
        comultiply[x_**y_]:>
            comultiply[x]**comultiply[y],
        comultiply[id]:>
            tensor[id,id],
        counit[x_**y_]:>
            counit[x]*counit[y],
        counit[id]:>
            1
    },
    printing->{}
|>;


(* ::Subsubsection:: *)
(*Antipode*)


algebraInternal["Antipode"] = <|
    operator->{},
    relation->{
        (*linearity*)
        antipode[k_?scalarQ*x_.]:>
            k*antipode[x],
        antipode[x_+y_]:>
            antipode[x]+antipode[y],
        (*anti-morphism*)
        antipode[x_**y_]:>
            antipode[y]**antipode[x],
        (*identity*)
        antipode[id]:>
            id
    },
    printing->{
        antipode->"S"
    }
|>;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
