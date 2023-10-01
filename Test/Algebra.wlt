VerificationTest[
    Get["Yurie`Template`"],
    Null,
    TestID->"initialization"
]

VerificationTest[
    addOne@1,
    2,
    TestID->"addOne1"
]

VerificationTest[
    addOne[x],
    addOne[x],
    TestID->"addOneNonInteger"
]

VerificationTest[
    addOne[2^64],
    HoldPattern[LibraryFunction][___][2^64],
    {LibraryFunction::cfsa},
    SameTest->MatchQ,
    TestID->"addOneIntegerOverflow"
]