(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Internal`"];


Needs["Yurie`Algebra`"];

Needs["Yurie`Algebra`Tensor`"];


(* ::Section:: *)
(*Public*)


algebraInternal::usage =
    "internal algebra: data.";

$algebraInternal::usage =
    "internal algebra: name list.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Property*)


tensor//Attributes =
    {Flat,OneIdentity};


(* ::Subsection:: *)
(*Multiplication*)


algebraInternal["Algebra"] = <|
    "Generator"->{id},
    "Relation"->{
        (* Linearity *)
        (k_?scalarQ*x_)**y_:>k*x**y,
        x_**(k_?scalarQ*y_):>k*x**y,
        (x_+y_)**z_:>x**z+y**z,
        z_**(x_+y_):>z**x+z**y,
        (* Zero *)
        0**_->0,
        _**0->0,
        (* Identity *)
        id**x_:>x,
        x_**id:>x
    },
    "Printing"->{
        id->"\[DoubleStruckOne]"
    },
    "Rank"->{},
    "Parity"->{}
|>;


(* ::Subsection:: *)
(*Conjugate*)


algebraInternal["Conjugate"] = <|
    "Relation"->{
        (* Linearity *)
        conjugate[k_?scalarQ*x_.]:>
            Conjugate[k]*conjugate[x],
        conjugate[x_+y_]:>
            conjugate[x]+conjugate[y],
        (* Anti-morphism *)
        conjugate[x_**y_]:>
            conjugate[y]**conjugate[x],
        (* Identity *)
        conjugate[id]:>id
    },
    "Printing"->{
        conjugate->SuperDagger
    }
|>;


(* ::Subsection:: *)
(*Inverse*)


algebraInternal["Inverse"] = <|
    "Relation"->{
        (* Inverse *)
        inverse[k_?scalarQ*x_.]:>
            1/k*inverse[x],
        inverse[x_]**x_:>
            id,
        x_**inverse[x_]:>
            id,
        (* Anti-morphism *)
        inverse[x_**y_]:>
            inverse[y]**inverse[x],
        (* Identity *)
        inverse[id]:>id
    },
    "Printing"->{
        inverse->Inverse
    }
|>;


(* ::Subsection:: *)
(*Tensor product*)


algebraInternal["Tensor"] = <|
    "Relation"->{
        (* Linearity *)
        tensor[x_,k_?scalarQ*y_.]:>
            k*tensor[x,y],
        tensor[k_?scalarQ*x_.,y_]:>
            k*tensor[x,y],
        tensor[x_+y_,z_]:>
            tensor[x,z]+tensor[y,z],
        tensor[z_,x_+y_]:>
            tensor[z,x]+tensor[z,y],
        (* Composition *)
        tensor[x1_,x2__]**tensor[y1_,y2__]:>
            compose[{x1,x2},{y1,y2}]
    },
    "Printing"->{
        tensor->CircleTimes
    }
|>;


(* ::Subsection:: *)
(*Coalgebra*)


algebraInternal["Coalgebra"] = <|
    "Relation"->{
        (* Linearity *)
        comultiply[k_?scalarQ*x_.]:>
            k*comultiply[x],
        comultiply[x_+y_]:>
            comultiply[x]+comultiply[y],
        (* Linearity *)
        counit[k_?scalarQ*x_.]:>
            k*counit[x],
        counit[x_+y_]:>
            counit[x]+counit[y]
    },
    "Printing"->{
        comultiply->ToExpression["\[CapitalDelta]"],
        counit->ToExpression["\[Epsilon]"]
    }
|>;


(* ::Subsection:: *)
(*Bialgebra*)


algebraInternal["Bialgebra"] = <|
    "Relation"->{
        (* Compatibility between coalgebra and algebra structures. *)
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


(* ::Subsection:: *)
(*Antipode*)


algebraInternal["Antipode"] = <|
    "Relation"->{
        (* Linearity *)
        antipode[k_?scalarQ*x_.]:>
            k*antipode[x],
        antipode[x_+y_]:>
            antipode[x]+antipode[y],
        (* Anti-morphism *)
        antipode[x_**y_]:>
            antipode[y]**antipode[x],
        (* Identity *)
        antipode[id]:>
            id
    },
    "Printing"->{
        antipode->ToExpression["S"]
    }
|>;


(* ::Subsection:: *)
(*Summary*)


$algebraInternal = {
    "Algebra",
    "Conjugate",
    "Inverse",
    "Tensor",
    "Coalgebra",
    "Bialgebra",
    "Antipode"
};


algebraInternal[All]["Relation"] =
    Map[algebraInternal[#]["Relation"]&,$algebraInternal]//Flatten;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
