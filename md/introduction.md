<!DOCTYPE html>
<html lang="en-GB">
    <!-- haskell notes by NewForester is licensed under a Creative Commons Attribution-ShareAlike 4.0 International Licence. -->
<head>
    <title>Learn You A Haskell Notes: Introduction</title>
    <meta charset="UTF-8" />
    <meta name="description" content="Notes on the Haskell programming language made while learning a bit about Functional Programming" />
    <meta name="keywords" content="Haskell" />
    <meta name="author" content="NewForester" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" href="../styles/style-sheet.css" />
</head>

<body>

# Learn You A Haskell

## Introduction

### About This Tutorial

The author intends to describe Haskell from this point of view after reading and
studying various Internet resources each of which provided a slightly different perspective.

The tutorial is aimed at people who have experience of programming `imperative` but not `functional` programming languages.
The author claims that programming in Haskell forces you to think differently and
learning Haskell is a bit like learning to program for the first time.
However, once it has 'clicked', it is straight forward.


### So What's Haskell

Haskell is a `purely functional programming language`:

Rather than tell the computer how to do stuff, the language tells the computer what stuff is:
the factorial of a number is the product of all numbers from 1 to that number.

You cannot set a variable to something and then set it to something else later:
`variables are invariant`.

Functions calculate something using their parameters and return a result.
They have no side-effects.
Given the same input they always return the same result (aka `referential integrity`).

Haskell is `lazy`:  it does not execute a function until the result is required.
It helps to think of a program as a series of `transformations` of data.

One interesting consequence that:

```haskell
    xs = [1,2,3,4,5,6,7,8]
    doubleMe(doubleMe(doubleMe(xs)))
```

traverses the list xs only once whereas most languages will traverse the list thrice.

Another interesting consequence is that you can have infinite lists.
The result of an expression on an infinite list typically only requires the first so many elements.
With lazy evaluation, you only evaluate those elements you need so the list itself may be infinite without
requiring either infinite memory or infinite processing.

Haskell is `statically` typed.
It uses `type inference` so you do not need to label every peice of code with a type.
Code without types is more general (no need for C++ ugly templates).

Hasell is `elegant` and `concise`.
The first may be a matter of opinion but the later implies shorter programs and so fewer bugs.

Work on Haskell began in academia in `1987`.
The Haskell Report that defined the stable version of the language was publised in `2003`.


### What you need to dive in

You need a `text editor` and a `Haskell compiler`.
It is recommended you install the `Haskell Platform` which includes the GHC (Glasgow Haskell Compiler).

Haskell scripts (with functions) are created using the text editor and saved into files with the `.hs` extension.

The compiler has an interactive mode (invoke `ghci`) that allows you to compile and load your script file and
then invoke the function defined within it.

```haskell
    $ ghci
    GHCi, version 7.4.1: http://www.haskell.org/ghc/  :? for help
    Loading package ghc-prim ... linking ... done.
    Loading package integer-gmp ... linking ... done.
    Loading package base ... linking ... done.
    ghci> :l myScript
    [1 of 1] Compiling Main             ( myScript.hs, interpreted )
    Ok, modules loaded: Main.
    ghci> doubleMe 8.3
    16.6
```

The script may be edited, saved and reloaded without leaving the interactive environment:

```haskell
    Prelude> :l myScript        -- load the module again
    Prelude> :r                 -- load the last module loaded again
```

</body>
</html>
