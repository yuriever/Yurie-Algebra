(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Internal`"];


Needs["Yurie`Algebra`"];

Needs["Yurie`Algebra`Tensor`"];


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


tensor//Attributes =
    {Flat,OneIdentity};


(* ::Subsubsection:: *)
(*Multiplication*)


algebraInternal["Algebra"] = <|
    "Generator"->{id},
    "Relation"->{
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
    },
    "Printing"->{
        id->1
    },
    "Rank"->{},
    "Parity"->{}
|>;


(* ::Subsubsection:: *)
(*Conjugate*)


algebraInternal["Conjugate"] = <|
    "Relation"->{
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
    "Printing"->{
        conjugate->SuperDagger
    }
|>;


(* ::Subsubsection:: *)
(*Tensor product*)


algebraInternal["Tensor"] = <|
    "Relation"->{
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
        tensor[x1_,x2__]**tensor[y1_,y2__]:>
            compose[{x1,x2},{y1,y2}]
    },
    "Printing"->{
        tensor->CircleTimes
    }
|>;


(* ::Subsubsection:: *)
(*Coalgebra*)


algebraInternal["Coalgebra"] = <|
    "Relation"->{
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
    "Printing"->{
        comultiply->ToExpression["Δ"],
        counit->ToExpression["ϵ"]
    }
|>;


(* ::Subsubsection:: *)
(*Bialgebra*)


algebraInternal["Bialgebra"] = <|
    "Relation"->{
        (*compatibility between coalgebra and algebra structures*)
        comultiply[x_**y_]:>
            comultiply[x]**comultiply[y],
        comultiply[id]:>
            tensor[id,id],
        counit[x_**y_]:>
            counit[x]*counit[y],
        counit[id]:>
            1
    }
|>;


(* ::Subsubsection:: *)
(*Antipode*)


algebraInternal["Antipode"] = <|
    "Relation"->{
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
    "Printing"->{
        antipode->ToExpression["S"]
    }
|>;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
