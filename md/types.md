<!DOCTYPE html>
<html lang="en-GB">
    <!-- haskell notes by NewForester is licensed under a Creative Commons Attribution-ShareAlike 4.0 International Licence. -->
<head>
    <title>Learn You A Haskell Notes: Types and Typeclasses</title>
    <meta charset="UTF-8" />
    <meta name="description" content="Notes on the Haskell programming language made while learning a bit about Functional Programming" />
    <meta name="keywords" content="Haskell" />
    <meta name="author" content="NewForester" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" href="../styles/style-sheet.css" />
</head>

<body>

# Learn You A Haskell

## Types and Typeclasses

This chapter introduces Haskell `types`, `type variables` and `typeclasses`.

The first will be familiar from statically types imperative languages but are largely optional because of Haskell's type inference.

The second are very useful for generic programming.

The third are not objects but something altogether more intriguing.


### Types

Haskell has a static type system that means the compiler knows the type of every expression and
will reject expressions with type errors avoiding a very common class of run time error associated with dynamic type systems.

Haskell has type interference:  you write a number and Haskell can tell it is a number and take it from there.
It does not need to programmer to tell it that 1 is a number.

Use `:t` to view the type of an expression:

```haskell
    ghci> :t 'a'
    'a' :: Char                         -- note the capital letter denotes a type
    ghci> :t True
    True :: Bool
    ghci> :t "HELLO!"
    "HELLO!" :: [Char]                  -- list of Char (or String)
    ghci> :t (True, 'a')
    (True, 'a') :: (Bool, Char)         -- tuples are types
    ghci> :t 4 == 5
    4 == 5 :: Bool                      -- expressions have a type
```

Functions have types.
Giving functions (except for very short ones) explicit types (not quite what you think) is generally considered good form.

```haskell
    removeNonUppercase :: [Char] -> [Char]      -- takes a list of Char and returns a list of Char
    removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

    addThree :: Int -> Int -> Int -> Int        -- takes three Ints and returns and Int
    addThree x y z = x + y + z
```

Some common types are:

  * Int         - fixed width integer, usually 32 bits
  * Integer     - integer of unlimited range
  * Float       - single precision real number
  * Double      - double precision real number
  * Bool        - True or False
  * Char        - a character (enclosed in single quotes)
  * String      - a list of characters (enclosed in double quotes)

### Type Variables

What is the type of the head function ?

```haskell
    ghci> :t head
    head :: [a] -> a
```

Ah !
The function takes a list of type `a` and return a value of type `a`.
Irrespective of what type `a` is.

Another example:

```haskell
    ghci> :t fst
    fst :: (a, b) -> a
```

Ah !
It takes a pair of goodness knows what and returns a value which the same type as the first element of the pair.

Not only is it possible to infer the type of a function, for really short function it is possible to infer
the function from its type definition!


### Typeclass 101

A types class is (a sort of) interface that defines some behaviour.
For a type to belong to a typeclass, it must implement the behaviour defined by the typeclass.

Waddayamean ?

```haskell
    ghci> :t (==)
    (==) :: (Eq a) => a -> a -> Bool
```

What this is saying is that the type of `a` must belong to the typeclass `Eq`.
This is, type `a` must support the equals and not equals functions.

```haskell
    ghci> :t elem
    elem :: Eq a => a -> [a] -> Bool
```

This says pretty much the same thing but in a machine readable form
(equivalent to the documentation in C++ that says a class must implement the operator==).

Some common typeclasses:

 * Eq           - for types that support equality (they support = and /=)
 * Ord          - for types with an ordering (they support <, <=, >=, > and compare)
 * Enum         - for types with a sequential ordering (they support succ and pred)
 * Bounded      - for types have have and upper and lower bound (they support minBound and maxBound)
 * Num          - for numeric types
 * Integral     - for integer number types (Int and Integer)
 * Floating     - for real numbers (Float and Double)
 * Show         - for types that can be presented as strings (printable - they support show)
 * Read         - for types that can convert from a string to their internal representation (they support read)

Some simple examples:

```haskell
    ghci> "Ho Ho" == "Ho Ho"
    True
    ghci> 5 `compare` 3             -- enum LT,EQ,GT
    GT
    ghci> succ 'B'
    'C'
    ghci> maxBound :: Bool          -- maxBound appears to be a polymorphic constant
    True
    ghci> 20 :: Float               -- numbers also appear to be polymorphic constants
    20.0
    ghci> show 5.334
    "5.334"
    ghci> read "[1,2,3,4]" ++ [3]   -- its a girl no sorry, its a list
    [1,2,3,4,3]
```

How is this of any use ?

Well consider ...

```haskell
    ghci> :t read
    read :: Read a => String -> a
```

is nice and generic and in the example above the compiler could deduce what type `a` needed to be.

```haskell
    ghci> (read "5" :: Float)       -- type annotation to say its Float
    5.0
```

Type annotations are a bit like casts in C/C++ (but are not used to suppress warning messages indiscriminately).

On the other hand:

```haskell
    ghci> :t length
    length :: [a] -> Int
```

Is not generic (possible for histerical reasons).
To avoid type errors, look to fromInteger:

```haskell
    ghci> fromIntegral (length [1,2,3,4]) + 3.2
    7.2
```

</body>
</html>
