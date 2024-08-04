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
    "Multiplication",
    "Conjugate",
    "TensorProduct",
    "Comultiplication"
};


(* ::Subsubsection:: *)
(*Multiplication*)


NonCommutativeMultiply//Unprotect;

NonCommutativeMultiply//ClearAll;

NonCommutativeMultiply//Attributes = {Flat,OneIdentity};


algebraInternal["Multiplication"] = <|
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


CircleTimes//Unprotect;

CircleTimes//ClearAll;

CircleTimes//Attributes = {Flat,OneIdentity};


algebraInternal["TensorProduct"] = <|
    operator->{id},
    relation->{
        CircleTimes[x_,k_?scalarQ*y_.]:>
            k CircleTimes[x,y],
        CircleTimes[k_?scalarQ*x_.,y_]:>
            k CircleTimes[x,y],
        CircleTimes[x_+y_,z_]:>
            CircleTimes[x,z]+CircleTimes[y,z], 
        CircleTimes[z_,x_+y_]:>
            CircleTimes[z,x]+CircleTimes[z,y],
        x_CircleTimes**y_CircleTimes:>
            tensorCompose[x**y]/;tensorRankEqualQ[x,y],
        id**x_:>x,
        x_**id:>x
    },
    printing->{}
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
(*Comultiplication*)


algebraInternal["Comultiplication"] = <|
    operator->{},
    relation->{},
    printing->{
        comultiply->"\[CapitalDelta]",
        counit->"\[Epsilon]"
    }
|>;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
