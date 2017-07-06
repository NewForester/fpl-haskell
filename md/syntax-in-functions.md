<!DOCTYPE html>
<html lang="en-GB">
    <!-- haskell notes by NewForester is licensed under a Creative Commons Attribution-ShareAlike 4.0 International Licence. -->
<head>
    <title>Learn You A Haskell Notes: Syntax In Functions</title>
    <meta charset="UTF-8" />
    <meta name="description" content="Notes on the Haskell programming language made while learning a bit about Functional Programming" />
    <meta name="keywords" content="Haskell" />
    <meta name="author" content="NewForester" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" href="../styles/style-sheet.css" />
</head>

<body>

# Learn You A Haskell

## Syntax In Functions

This chapter covers the same ground as its homologue in the Erlang course but does not seem to do it so well.
There are differences: Haskell functions are a little more sohisticated and more ground is covered.

The code examples are all in [Function Syntax Examples](../learn-you-a-haskell/function-syntax.hs).

The chapter introduces function definition using `pattern matching` and `guards`.
It covers the `where` clause that allow for pattern local bindings and then the
`let ... in` and `case ... of` expressions.

The whole thing begins to look like programming as it should have been.

There are couple of suggestions that Haskell accepts definitions lined up vertically instead of separated by
semi-colons.  Cool.


### Pattern matching

Pattern matching allows functions to be defined with different bodies for different patterns.
This avoids a lot of the if ... elif ... else constructs of imperative languages.

```haskell
name pattern1 = body1
name pattern2 = body2
       ...
name patternN = bodyN
```

The patterns are evaluated from pattern 1 through N until one matches.
The result is that obtained by evaluating the corresponding body.

Pattern matching can fail (even if the parameter(s) are of the right type.
This tutorial recommends having a catch all `otherwise` clause.

See the `lucky` and `sayMe` code examples.

Pattern matching is handy with recursion:  see the `factorial` code example.

Pattern matching is good with tuples:  see the `addVectors` code example.

Pattern matching can be used to define accessors for tuples: see the `first`, `second` and `third` code examples.

For wildcard elements of a pattern, use `_`, just as in list comprehensions.

List comprehensions can also use pattern matching:

```hashell
    ghci> let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]
    ghci > [a+b | (a,b) <- xs]
    [4,7,6,8,11,4]
```

Should the pattern (a,b) fail to match an element of xs, execution will simply pass to the next element that does
(although I cannot see in this example how that could happen).

Lists can be used in pattern matching.
The empty list `[]` and the form `x:xs` are used a lot in recursion.
See the `head'`, `length'` and `sum'` code examples.

The structures of such functions have a form similar to that of the factorial function.
The first pattern is the edge case (here the empty list pattern) that stops the recursion and
returns a known result.
The second pattern splits the list into its head and tail and returns a result.
Often calculating the result involves calling the function recursively passing itself the tail and
combining that result with the head somehow.

A final note on `as patterns`.
These are a handy way of breaking something up using pattern matching and being able to refer to the whole thing.
Thus:

```haskell
    xs@(x:y:ys)
```

in a sense splits a list into three: head (x), next (y) and the tail (ys).
The original list can be referred to as x:y:ys but also as xs.
Thus:

```haskell
    capital :: String -> String
    capital "" = "Empty string, whoops!"
    capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

    ghci> capital "Dracula"
    "The first letter of Dracula is D"
```

### Guards, guards!

Guards are a syntatic convenience that work well with pattern matching.
They allow predicates to be applied to the values in a matched pattern to decide whether to evaluate the
matched body.

An example:

```haskell
    bmiTell :: (RealFloat a) => a -> String
    bmiTell bmi
        | bmi <= 18.5 = "You're underweight, you emo, you!"
        | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
        | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
        | otherwise   = "You're a whale, congratulations!"
```

There are no patterns here.
The parameter is bound to the symbol `bmi` provided it is a real floating point number.
The first guard is evaluated and if true, its body is evaluated to determine the result.
If false, the second guard is evaluated and so on.

The construct is very similar to if ... elif ... else trees in imperative languages but,
it is argued, is superior and more readable.

Note the use of the otherwise clause.
It is optional - evaluation will fall through to the next pattern.
Only when you run out of guards and patterns is an error raised.

Guards work with functions with more than one parameter:

```haskell
    myCompare :: (Ord a) => a -> a -> Ordering
    a `myCompare` b
        | a > b     = GT
        | a == b    = EQ
        | otherwise = LT
```

Note here the use of the backticks to define a function with infix notation.

It is normal to write the guards indented and one to a line but it is not required.


### Where!?

The function `bmi` can be modified to calculate the BMI too but this involves repetition ...

```haskell
    bmiTell :: (RealFloat a) => a -> a -> String
    bmiTell weight height
        | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
        | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
        | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
        | otherwise   = "You're a whale, congratulations!"
```

... unless you use the where clause:

```haskell
    bmiTell :: (RealFloat a) => a -> a -> String
    bmiTell weight height
        | bmi <= 18.5 = "You're underweight, you emo, you!"
        | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
        | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
        | otherwise   = "You're a whale, congratulations!"
        where bmi = weight / height ^ 2
```

It is possible to bind several values to names in the where clause but you have to line them up nicely
else the compiler may be confused.

Names bound in a where clause have the scope of all guards of the same pattern but
not all patterns of the same function definition.

It is also possible to use pattern matching in the where clause:

```haskell
    bmiTell :: (RealFloat a) => a -> a -> String
    bmiTell weight height
        | bmi <= skinny = "You're underweight, you emo, you!"
        | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
        | bmi <= fat    = "You're fat! Lose some weight, fatty!"
        | otherwise     = "You're a whale, congratulations!"
        where bmi = weight / height ^ 2
              (skinny, normal, fat) = (18.5, 25.0, 30.0)
```

Functions may be defined in a where clause:

```haskell
    calcBmis :: (RealFloat a) => [(a, a)] -> [a]
    calcBmis xs = [bmi w h | (w, h) <- xs]
        where bmi weight height = weight / height ^ 2
```

and where clauses may be nested in that the top-level where clause may define one or more functions
each of which may have its own where clause.


### Let it be

The `let <bindings> in <expression>` is another construct that allows programmes to be expressed with greater ease,
with less repetition and fewer parenetheses.
See the cylinder code example.

It is similar to the `where` clause discussed above but it is an expression, not a syntactic construct:
it can be used practically anywhere to bind local names for local use.

It can and is also used without the `in <expression>` to bind names in the GHCI shell and in list comprehensions:

```haskell
    ghci> [let square x = x * x in (square 5, square 3, square 2)]
    [(25,9,4)]
```

To bind several variables inline separate them with semicolons:

```haskell
    ghci> (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)
    (6000000,"Hey there!")
```

And, at last, in a list comprehension:

```haskell
    calcBmis :: (RealFloat a) => [(a, a)] -> [a]
    calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]
```

The `let` expression appears as just another predicate.
Without the `in` clause, the `let` binding is known everywhere in the list comprehension.
A `let` used within a predicate is only known within the predicate.


### Case expressions

Haskell supports powerful case expressions with pattern matching case labels.

The general form is simply:

```haskell
    case expression of
        pattern1 -> result1
        pattern2 -> result2
                ...
        patternN -> patternN
```

Pattern matching in function definitions is simply syntatic sugar for a case expression:

The familiar:

```haskell
    head' :: [a] -> a
    head' [] = error "No head for empty lists!"
    head' (x:_) = x
```

is the same as:

```haskell
    head' :: [a] -> a
    head' xs = case xs of
        [] -> error "No head for empty lists!"
        (x:_) -> x
```

</body>
</html>
