(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Algebra`Preset`"];


Needs["Yurie`Algebra`"];


(* ::Section:: *)
(*Public*)


algebraInternal::usage = 
    "preset algebras.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Functions*)


algebraInternal[] = {
    "multiplication",
    "conjugate",
    "tensorProduct",
    "comultiplication"
};


(* ::Subsubsection:: *)
(*Multiplication*)


NonCommutativeMultiply//Unprotect;
NonCommutativeMultiply//ClearAll;
NonCommutativeMultiply//Attributes = {Flat,OneIdentity};


algebraInternal["multiplication"] = <|
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


algebraInternal["tensorProduct"] = <|
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
            tensorThread[x**y]/;tensorRankEqualQ[x,y],
        id**x_:>x,
        x_**id:>x            
    },
    printing->{}
|>;


(* ::Subsubsection:: *)
(*Conjugate*)


SuperDagger//Unprotect;
SuperDagger//ClearAll;


algebraInternal["conjugate"] = <|
    operator->{},
    relation->{
        SuperDagger[1]:>1,
        SuperDagger[k_?scalarQ*x_.]:>
            Conjugate[k] SuperDagger[x],
        SuperDagger[x_+y_]:>
            SuperDagger[x]+SuperDagger[y],
        SuperDagger[x_**y_]:>
            SuperDagger[y]**SuperDagger[x]
    },
    printing->{}
|>;


(* ::Subsubsection:: *)
(*Comultiplication*)


algebraInternal["comultiplication"] = <|
    operator->{},
    relation->{},
    printing->{}
|>;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
