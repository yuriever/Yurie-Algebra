(* ::Package:: *)

PacletObject[
  <|
    "Name" -> "Yurie/Algebra",
    "Description" -> "A Mathematica package for implementing and managing finitely presented associative algebras",
    "Creator" -> "Yurie",
    "SourceControlURL" -> "https://github.com/yuriever/Yurie-Algebra",
    "License" -> "MIT",
    "PublisherID" -> "Yurie",
    "Version" -> "5.1",
    "WolframVersion" -> "14.2+",
    "PrimaryContext" -> "Yurie`Algebra`",
    "Dependencies" -> {
      "Yurie/Cluster" -> ">=3.0.0"
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
          "Yurie`Algebra`BCGhost`",
          "Yurie`Algebra`BinomialHopf",
          "Yurie`Algebra`BosonFermion`",
          "Yurie`Algebra`CarCFT2`",
          "Yurie`Algebra`CFT1`",
          "Yurie`Algebra`CFT2`",
          "Yurie`Algebra`CFTd`",
          "Yurie`Algebra`Harmonic`",
          "Yurie`Algebra`SL2`",
          "Yurie`Algebra`Sweedler",
          "Yurie`Algebra`TrigHopf`",
          "Yurie`Algebra`YBE`"
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
