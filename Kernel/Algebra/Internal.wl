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
    "Bialgebra"
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
    operator->{},
    relation->{
        x_**y_/;scalarQ[x]||scalarQ[y]:>x*y,
        (k_?scalarQ*x_)**y_:>k*x**y,
        x_**(k_?scalarQ*y_):>k*x**y,
        (x_+y_)**z_:>x**z+y**z,
        z_**(x_+y_):>z**x+z**y
    },
    printing->{}
|>;


(* ::Subsubsection:: *)
(*Tensor product*)


algebraInternal["Tensor"] = <|
    operator->{id},
    relation->{
        tensor[x_,k_?scalarQ*y_.]:>
            k tensor[x,y],
        tensor[k_?scalarQ*x_.,y_]:>
            k tensor[x,y],
        tensor[x_+y_,z_]:>
            tensor[x,z]+tensor[y,z], 
        tensor[z_,x_+y_]:>
            tensor[z,x]+tensor[z,y],
        x_tensor**y_tensor:>
            tensorCompose[x**y]/;tensorRankEqualQ[x,y],
        id**x_:>x,
        x_**id:>x
    },
    printing->{
        tensor->CircleTimes,
        id->1
    }
|>;


(* ::Subsubsection:: *)
(*Conjugate*)


algebraInternal["Conjugate"] = <|
    operator->{},
    relation->{
        conjugate[1]:>1,
        conjugate[k_?scalarQ*x_.]:>
            Conjugate[k] conjugate[x],
        conjugate[x_+y_]:>
            conjugate[x]+conjugate[y],
        conjugate[x_**y_]:>
            conjugate[y]**conjugate[x]
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
        comultiply[k_?scalarQ*x_.]:>
            k comultiply[x],
        comultiply[x_+y_]:>
            comultiply[x]+comultiply[y],
        counit[k_?scalarQ*x_.]:>
            k counit[x],
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


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
