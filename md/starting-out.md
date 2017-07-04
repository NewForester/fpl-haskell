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

## Starting Out

This chapter covers the basics of Haskell `arithmetic`, `lists`, `ranges`, `list comprehensions` and `tuples` as well as introducing functions.

### Ready, set go!

#### Simple Expressions

To enter the interactive environment from the command line:

```bash
    $ ghci
```

If you look carefully at the blurb this produces:

```haskell
    ghci> :?
```

will get you help.
The prompt isn't as shown and may get longer as you load more stuff.

```haskell
    Prelude> :set prompt "ghci> "
```

will put an end to that.

The interpreter will evaluate simple arithmetic expressions written with the 'usual' infix notation.
Parentheses may be used to override the 'usual' operator precedence.

```haskell
    ghci> 2 + 15
    17
    ghci> 49 * 100
    4900
    ghci> 1892 - 1472
    420
    ghci> 5 / 2
    2.5
```

Beware:

```haskell
    ghci> 5 * -3                -- precedence error, d'oh !

    ghci> 5 * (-3)              -- fine, c.f. 'high minus' in APL
    -15
```

Boolean algebra is straightforward and optimisation of expression evaluation to be expected
since there are no side-effect and Haskell is a lazy language:

```haskell
    ghci> True && False
    False
    ghci> True && True
    True
    ghci> False || True
    True
    ghci> not False
    True
    ghci> not (True && True)
    False
```

Comparison operators:

```haskell
    ghci> 5 == 5
    True
    ghci> 5 /= 5                -- NB
    False
    Prelude> 5 < 4
    False
    Prelude> 5 <= 4
    False
    Prelude> 5 > 4
    True
    Prelude> 5 >= 4
    True
```

Comparison has type checking so the following are not valid:

```haskell
    ghci> 5 /= "Bama bama"
    ghci> 1 == True
```

The comparison operators are valid for strings:

```haskell
    ghci> "Hello" > "Goodbye"   -- lexicographical comparison
    True
    ghci> "Carol" >= "Caroline" -- lexicographical comparison
    False
```

since strings are lists with syntactic sugar.

#### Function Invocation

Look Mum, no parentheses !

One parameter:

```haskell
    ghci> succ 8                -- generic increment
    9
    ghci> pred 8                -- generic decrement
    7
```

With a Boolean result are called predicates:

```haskell
    ghci> odd 2
    False
    ghci> even 2
    True
```

Two parameters:

```haskell
    ghci> min 9 10
    9
    ghci> max 9 10
    10
```

Function invocation has the highest operator precedence.

```haskell
    ghci> succ 9 + max 5 4 + 1          -- is the same
    16
    ghci> (succ 9) + (max 5 4) + 1      -- as this
    16
```

Most functions are invoked using the prefix notation.
However some with two operands are invoked with using infix notation:

```haskell
    div 92 10           -- integer division
    9
    92 `div` 10         -- some believe this to be clearer
    9
```

Also:

```haskell
    2 * 2               -- infix notation
    4
    (*) 2 2             -- prefix notation in ghci (*)
    9
```

However, it is not clear what happens to the operator precedence.


### Baby's first functions

Writing function involves compilation so you need a text editor and to load/compile your functions.

In the text editor:

```haskell
    doubleMe x = x + x                      -- no parentheses again
    doubleUs x y = doubleMe x + doubleMe y  -- no comma either
```

```bash
    ghci> :l baby
    [1 of 1] Compiling Main             ( baby.hs, interpreted )
    Ok, modules loaded: Main.
```

```haskell
    ghci> doubleMe 8.3
    16.6
    ghci> doubleUs 4 9
    26
```

Functions may occur in a file in any order:  forward references are fine.

```haskell
    doubleSmallNumber x = if x > 100 then x else x * 2
```

Since there are no side effects, it follows that all expressions have a result.
This includes function invocation.
Therefore the _else_ part is mandatory and _if ... then ... else_ is an expression, not a statement.

It is an expression with low precedence.

Note: ' is a valid in function names.
It is often at the end of a name to indicate a strict (not lazy) function.

Note: function names cannot start with a capital letter.

```haskell
    conanO'Brien = "It's a-me, Conan O'Brien!"
```

Is a function with no parameters.
So it is a constant (aka definition or name).

Note: You cannot have naked expressions in a file.
I suppose that makes sense.


### An intro to lists

In Haskell, lists are homogeneous data structures of arbitrary length:
you cannot mix numbers and strings in a list.

```haskell
    ghci> let lostNumbers = [4,8,15,16,23,42]
    ghci> lostNumbers
    [4,8,15,16,23,42]
```

Note:  in GHCI, use `let` to make definitions (you can't define functions, even those with no parameters).

Common list operations:

```haskell
    ghci> [1,2,3] ++ [4,5,6]                -- list concatenation
    [1,2,3,4,5,6]
    ghci> 7 : [1,2,3,4,5,6]                 -- prepend element
    [7,1,2,3,4,5,6]
    ghci> [1,2,3,4,5,6] ++ [7]              -- append element
    [1,2,3,4,5,6,7]
    ghci> [9.4,33.2,96.2,11.2,23.25] !! 1   -- index (origin 0)
    33.2
```

Concatenation (and append) involve traversing the list whereas prepend does not.
The latter is therefore preferred.

The list syntax is simply syntactic sugar:

```haskell
    gchi > 1:2:3:[]
    [1,2,3]
```

Strings are simply lists with more syntactic sugar:

```haskell
    ghci> 'A':" SMALL CAT"
    "A SMALL CAT"
```

Lists may contain lists.  The contained lists need not be of the same length but must be of the same type.

Lists may be compared if their contents may be compared.
The comparison is lexicographical (even on numbers !).

```haskell
    ghci> [3,4,2] > [3,4]
    True
```

Commonly used list functions:

```haskell
    ghci> head [5,4,3,2,1]
    5
    ghci> tail [5,4,3,2,1]
    [4,3,2,1]
    ghci> last [5,4,3,2,1]
    1
    ghci> init [5,4,3,2,1]
    [5,4,3,2]
    ghci> length [5,4,3,2,1]
    5
    ghci> null [1,2,3]
    False
    ghci> null []
    True
    ghci> reverse [5,4,3,2,1]
    [1,2,3,4,5]
    ghci> take 3 [5,4,3,2,1]
    [5,4,3]
    ghci> drop 3 [8,4,2,1,5,6]
    [1,5,6]
    ghci> minimum [8,4,2,1,5,6]
    1
    ghci> maximum [1,9,2,3,4]
    9
    ghci> sum [5,2,1,6,3,2,5,7]
    31
    ghci> product [6,2,1,2]
    24
    ghci> 4 `elem` [3,4,5,6]
    True
    ghci> 10 `elem` [3,4,5,6]
    False
```


### Texas Ranges

Haskell has a range syntax:

```haskell
    ghci> [11..20]
    [11,12,13,14,15,16,17,18,19,20]
    ghci> ['a'..'z']
    "abcdefghijklmnopqrstuvwxyz"
    ghci> ['K'..'Z']
    "KLMNOPQRSTUVWXYZ"
```

The syntax supports arithmetic progressions but beware the semantics:

```haskell
    ghci> [4,6..20]             -- step 2
    [4,6,8,10,12,14,16,18,20]
    ghci> [6,9..20]             -- step 3
    [6,9,12,15,18]
    ghci> [20,19..15]           -- step -1
    [20,19,18,17,16,15]
```


Ranges on floating points numbers are support but may give surprising results so find another way.

The syntax supports infinite lists:

```haskell
    ghci> [13,26..6*13]         -- limit can be an expression
    [13,26,39,52,65,78]
    ghci> take 6 [13,26..]      -- lazy evaluation to the rescue
    [13,26,39,52,65,78]
```

Functions to generate infinite lists include cycle, repeat but prefer replicate.

```haskell
    ghci> take 10 (cycle [1,2,3])
    [1,2,3,1,2,3,1,2,3,1]
    ghci> take 12 (cycle "LOL ")
    "LOL LOL LOL

    ghci> take 10 (repeat 5)
    [5,5,5,5,5,5,5,5,5,5]
    ghci> replicate  10 5
    [5,5,5,5,5,5,5,5,5,5]
```

### I'm a list comprehension

Mathematics has a notation for set comprehensions.
The Haskell equivalent are list comprehensions.

```haskell
    ghci> [x*2 | x <- [1..10]]
    [2,4,6,8,10,12,14,16,18,20]
```

Is simple to understand:  for x in the range 1 to 10, yield twice x.

Haskell supports a predicate syntax that allows the comprehension to be filtered:

```haskell
    ghci> [x*2 | x <- [1..10], x*2 >= 12]
    [12,14,16,18,20]
    ghci> [ x | x <- [50..100], mod x 7 == 3]
    [52,59,66,73,80,87,94]
```

List comprehensions may have more than one predicate and more than one list (so you can generate permutations):

```haskell
    ghci> [ x | x <- [10..20], x /= 13, x /= 15, x /= 19]
    [10,11,12,14,16,17,18,20]

    ghci> [ x*y | x <- [2,5,10], y <- [8,10,11]]
    [16,20,22,40,50,55,80,100,110]
```

A bonkers calculation of the length of a list:

```haskell
    length' xs = sum [1 | _ <- xs]
```

where _ is a variable whose value is not used

Since strings are lists, string comprehensions are possible:

```haskell
    ghci> let removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]
    ghci> removeNonUppercase "IdontLIKEFROGS"
    "ILIKEFROGS"
```

Note you can define list comprehensions in GHCI and use them like functions.

List comprehensions may be nested:

```haskell
    ghci> let xxs = [[1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6]]
    ghci> [ [ x | x <- xs, even x ] | xs <- xxs]
    [[2,2,4],[2,4,6,8],[2,4,2,6,2,6]]
```

Inside functions, comprehensions may be written over several lines.


### Tuples

Tuples are of fixed size (aka length) and may be heterogeneous.
They are also types.

```haskell
    ghci> (1,2)                 -- a pair
    (1,2)
    ghci> (1,2,3)               -- a triple
    (1,2,3)
    ghci> [(1,2),(8,11),(4,5)]  -- a triangle perhaps
    [(1,2),(8,11),(4,5)]
```

but these are invalid:

```haskell
    [(1,2),(8,11,5),(4,5)]

    [(1,2),("One",2)]
```

It makes no sense in Haskell to have singleton tuples:

```haskell
    ghci> (1) == 1
    True
```

You may compare tuples if their components can be compared but you cannot compare tuples of different sizes.

Functions that operate on pairs:

```haskell
    ghci> fst (8,11)
    8
    ghci> fst ("Wow", False)
    "Wow
    ghci> snd (8,11)
    11
    ghci> snd ("Wow", False)
    False
```

The zip function can take two lists and produce a list of pairs:

```haskell
    ghci> zip [1 .. 5] ["one", "two", "three", "four", "five"]
    [(1,"one"),(2,"two"),(3,"three"),(4,"four"),(5,"five")]

    ghci> zip [1..] ["apple", "orange", "cherry", "mango"]
    [(1,"apple"),(2,"orange"),(3,"cherry"),(4,"mango")]
```

Since the longer list is truncated, zip works well with infinite lists.


### An Exercise

Find all right triangles with a perimeter of 24 that have integers for all sides
and all sides are equal to or smaller than 10.

All triangles with sides equal to or smaller than 10:

```haskell
    ghci> let triangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b] ]
```

All that are right triangles.

```haskell
    ghci> let rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2]
```

All that have a perimeter of 24.

```haskell
    ghci> let rightTriangles' = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24]

    ghci> rightTriangles'
    [(6,8,10)]
```

</body>
</html>
