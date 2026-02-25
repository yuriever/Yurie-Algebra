(* ::Package:: *)

<<Yurie`Algebra`
<<Yurie`Algebra`Info`
<<Yurie`Autocode`


(* ::Text:: *)
(*State*)


reportSuspiciousSet[
    FileNameJoin[$thisKernelDir,"Algebra"],
    "ExcludedFile"->{"Variable.wl","Internal.wl","Init.wl"}
]


reportSuspiciousSet[
    $thisDatasetDir,
    "ExcludedSymbol"->{"$algebraList"}
]
