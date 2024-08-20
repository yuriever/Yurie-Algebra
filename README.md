# Yurie/Algebra

A Mathematica paclet for implementing and managing finitely presented associative algebras.

## Install

Install from this repository:

1. download the built paclet `build/*.paclet`;

2. install the paclet:

    ``` wl
    PacletInstall@File["the/path/of/paclet"]
    ```

Install manually:

1. download this repository, and move it to the paclet directory `$UserBasePacletsDirectory`;

2. rebuild the internal paclet data:

    ``` wl
    PacletDataRebuild[]
    ```

## Load

``` wl
Needs["Yurie`Algebra`"]
```

## Upgrade

``` wl
PacletInstall["Yurie/Algebra"]
```

## Uninstall

``` wl
PacletUninstall["Yurie/Algebra"]
```

## Documentation

<https://yuriever.github.io/symbolic/package/Algebra/>
