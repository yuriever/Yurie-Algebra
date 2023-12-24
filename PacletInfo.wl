(* ::Package:: *)

PacletObject[
  <|
    "Name" -> "Yurie/Algebra",
    "Description" -> "A Mathematica package for implementing and managing finitely presented associative algebras",
    "Creator" -> "Yurie",
    "SourceControlURL" -> "https://github.com/yuriever/Yurie-Algebra",
    "License" -> "MIT",
    "PublisherID" -> "Yurie",
    "Version" -> "1.0.0",
    "WolframVersion" -> "13+",
    "PrimaryContext" -> "Yurie`Algebra`",
    "Dependencies" -> {
    	"Yurie/Cluster" -> ">=1.0.0"
    },
    "Extensions" -> {
      {
        "Kernel",
        "Root" -> "Kernel",
        "Context" -> {"Yurie`Algebra`"}
      },
      {
        "Kernel",
        "Root" -> "Utility",
        "Context" -> {"Yurie`Algebra`"}
      },
      {
        "Documentation",
        "Root" -> "Documentation",
        "Language" -> "English"
      },
      (*{
        "AutoCompletionData",
        "Root" -> "AutoCompletionData"
      },*)
      {
        "Asset",
        "Root" -> ".",
        "Assets" -> {
          {"License", "LICENSE"},
          {"ReadMe", "README.md"},
          {"Sample", "Sample"},
          {"Test", "Test"}
        }
      }
    }
  |>
]
