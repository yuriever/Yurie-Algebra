(* ::Package:: *)

PacletObject[
  <|
    "Name" -> "Yurie/Algebra",
    "Description" -> "A Mathematica package for implementing and managing finitely presented associative algebras",
    "Creator" -> "Yurie",
    "SourceControlURL" -> "https://github.com/yuriever/Yurie-Algebra",
    "License" -> "MIT",
    "PublisherID" -> "Yurie",
    "Version" -> "2.0.0",
    "WolframVersion" -> "14.1+",
    "PrimaryContext" -> "Yurie`Algebra`",
    "Dependencies" -> {
      "Yurie/Cluster" -> ">=2.0.0"
    },
    "Extensions" -> {
      {
        "Kernel",
        "Root" -> "Kernel",
        "Context" -> {
          "Yurie`Algebra`"
        }
      },
      {
        "Kernel",
        "Root" -> "Utility",
        "Context" -> {
          "Yurie`Algebra`Info`"
        }
      },
      {
        "Kernel",
        "Root" -> "Dataset",
        "Context" -> {
          "Yurie`Algebra`BosonFermion`",
          "Yurie`Algebra`BCGhost`",
          "Yurie`Algebra`CCFT2`",
          "Yurie`Algebra`CFT1`",
          "Yurie`Algebra`CFTd`",
          "Yurie`Algebra`SL2`",
          "Yurie`Algebra`YBE`",
          "Yurie`Algebra`BinomialHopf",
          "Yurie`Algebra`Sweedler",
          "Yurie`Algebra`TrigHopf`"
        }
      },
      {
        "AutoCompletionData",
        "Root" -> "AutoCompletionData"
      },
      {
        "Asset",
        "Root" -> ".",
        "Assets" -> {
          {"License", "LICENSE"},
          {"ReadMe", "README.md"},
          {"Test", "Test"},
          {"TestSource", "TestSource"},
          {"Example", "Example"}
        }
      }
    }
  |>
]
