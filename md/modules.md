<!DOCTYPE html>
<html lang="en-GB">
    <!-- haskell notes by NewForester is licensed under a Creative Commons Attribution-ShareAlike 4.0 International Licence. -->
<head>
    <title>Learn You A Haskell Notes: Modules</title>
    <meta charset="UTF-8" />
    <meta name="description" content="Notes on the Haskell programming language made while learning a bit about Functional Programming" />
    <meta name="keywords" content="Haskell" />
    <meta name="author" content="NewForester" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" href="../styles/style-sheet.css" />
</head>

<body>

# Learn You A Haskell

## Modules

Haskell `modules` are not very complex.
The chapter is long because it introduces the most commonly used functions from
several commonly used standard modules.


### Modules

In Haskell, a `module` is like a C compilation unit.
It is a file that contains a collection of related functions, type and typeclasses.

In Haskell, a `program` is an assembly of modules that the main module loads in order to use the functions
they contain.

Splitting a program into modules has the same advantages in Haskell as it does on other languages.

A module may itself import other modules.
Within a module or program, modules must be imported before defining any functions so, by convention,
modules are imported at the top of the file.

The import statement has two forms.
The simpler is simply:

```haskell
    import <module name>
```

The equivalent in GHCI is:

```haskell
    ghci> :m + <module name> [...]
```

The simple form imports all exported definitions.
It can be restricted to a subset by naming them:

```haskell
    import <module name> (name1, ...)
```

Qualified imports are the other form and enable name clashes to be avoided:

```haskell
    import qualified <module name>
    import qualified <module name> as <module alias>
```

This allow functions in the module to be referred to unambiguous as:

```haskell
    <module name>.function
    <module alias>.function
```

A module alias is usually an abbreviation of the module name.
Modules names are cover later.

To read up on the functions you use see
[standard library reference](http://www.haskell.org/ghc/docs/latest/html/libraries/).

To search for functions and find out where they are located,
try the [Hoogle](http://haskell.org/hoogle) search engine.


### Data.List


The Data.List module provides useful functions to deal with lists.
Both `map` and `filter` comes from Data.List but are imported as standard.
A qualified import is not needed to avoid name clashes.

Below are examples of some (fifty plus) functions from Data.List that have not appeared yet in this tutorial.

```haskell
    ghci> intersperse '.' "UNCLE"
    "U.N.C.L.E"
    ghci> intercalate "-" ["tic", "tac", "toe"]
    "tic-tac-toe"
    ghci> concat ["fee","fi","fo","fum"]
    "feefifofum"
    ghci> concatMap (replicate 3) [4,5,6]
    [4,4,4,5,5,5,6,6,6]
```

```haskell
    ghci> transpose [[1,2,3],[4,5,6],[7,8,9]]
    [[1,4,7],[2,5,8],[3,6,9]]
```
  * foldl' and foldl1'  - non-lazy versions of foldl and foldl1

```haskell
    ghci> all (>4) [5,6,7,8]
    True
    ghci> any (==4) [2,3,4,5,6,1]
    True
```

```haskell
    ghci> take 12 $ iterate (+2) 1
    [1,3,5,7,9,11,13,15,17,19,21,23]
```

```haskell
    *Main Data.List> splitAt 5 "sleepwalk"
    ("sleep","walk")

    *Main Data.List> takeWhile (/=' ') "Good morning all"
    "Good"
    *Main Data.List> dropWhile (/=' ') "Good morning all"
    " morning all"

    *Main Data.List> break (==7) [1..12]
    ([1,2,3,4,5,6],[7,8,9,10,11,12])
    *Main Data.List> span (/=7) [1..12]
    ([1,2,3,4,5,6],[7,8,9,10,11,12])
```

```haskell
    *Main Data.List> partition (>2) [0,2,3,8,0,2,8,2,2,0,8]
    ([3,8,8,8],[0,2,0,2,2,2,0])
    *Main Data.List> sort [0,2,3,8,0,2,8,2,2,0,8]
    [0,0,0,2,2,2,2,3,8,8,8]
    *Main Data.List> group $ sort [0,2,3,8,0,2,8,2,2,0,8]
    [[0,0,0],[2,2,2,2],[3],[8,8,8]]
```

```haskell
    *Main Data.List> inits "abcd"
    ["","a","ab","abc","abcd"]
    *Main Data.List> tails "abcd"
    ["abcd","bcd","cd","d",""]
```

  * elem
  * notElem

```haskell
*Main Data.List> find (>3) [0,2,3,8,0,2,8,2,2,0,8]
Just 8
*Main Data.List> find (==4) [0,2,3,8,0,2,8,2,2,0,8]
Nothing
```

ghci> :t find
find :: (a -> Bool) -> [a] -> Maybe a

```haskell
    *Main Data.List> elemIndex 8 [0,2,3,8,0,2,8,2,2,0,8]
    Just 3
    *Main Data.List> findIndex (>3) [0,2,3,8,0,2,8,2,2,0,8]
    Just 3

    *Main Data.List> elemIndices ' ' "Spot the Capital Letters"
    [4,8,16]
    *Main Data.List> findIndices (`elem` ['A'..'Z']) "Spot the Capital Letters"
    [0,9,17]
    *Main Data.List> findIndices (flip elem ['A'..'Z']) "Spot the Capital Letters"
    [0,9,17]
```

All the way to zip7

```haskell
    *Main Data.List> zipWith3 (\a b x -> a + b * x) [1,2,3] [4,5,6] [7,8,9]
    [29,42,57]
    ghci> zip4 [2,3,3] [2,2,2] [5,5,3] [2,2,2]
    [(2,2,5,2),(3,2,5,2),(3,2,3,2)]
```

```haskell
    *Main Data.List> lines "One, two\nBuckle my shoe\nThree, Four\nClose the door"
    ["One, two","Buckle my shoe","Three, Four","Close the door"]
    *Main Data.List> unlines $ reverse $ lines "One, two\nBuckle my shoe\nThree, Four\nClose the door"
    "Close the door\nThree, Four\nBuckle my shoe\nOne, two\n"

    *Main Data.List> words "Mary had a little lamb"
    ["Mary","had","a","little","lamb"]
    *Main Data.List> unwords $ reverse $ words "Mary had a little lamb"
    "lamb little a had Mary"
```

Remove duplicates:

```haskell
    *Main Data.List> nub [0,2,3,8,0,2,8,2,2,0,8]
    [0,2,3,8]
```

```haskell
    *Main Data.List> [1..10] \\ [0,2,3,8,0,2,8,2,2,0,8]
    [1,4,5,6,7,9,10]
    *Main Data.List> union [1..10] [0,2,3,8,0,2,8,2,2,0,8]
    [1,2,3,4,5,6,7,8,9,10,0]
    *Main Data.List> intersect [1..10] [0,2,3,8,0,2,8,2,2,0,8]
    [2,3,8]
```

```haskell
    *Main Data.List> delete 'a' "Mary had a little lamb"
    "Mry had a little lamb"
    *Main Data.List> insert 'b' "Mary had a little lamb"
    "Mabry had a little lamb"
```

Change of type ...

  * genericLength
  * genericTake
  * genericDrop
  * genericSplitAt
  * genericIndex
  * genericReplicate

Take a predicate to test for equality

  * nubBy
  * deleteBy
  * unionBy
  * intersectBy
  * groupBy

Take a predicate to test for ordering

  * sortBy
  * insertBy
  * maximumBy
  * minimumBy

  Data.Function.on


### Maps and Filters

The bread and butter of functional programming are map and filter (and alternatives to list comprehensions).

A `map` takes a function and applies it to every element in a list producing a new list.

Note: it is not just lists - other recursive data structures such as trees have an analogous function.

```haskell
    map :: (a -> b) -> [a] -> [b]
    map _ [] = []
    map f (x:xs) = f x : map f xs
```

Watch the magic:

```haskell
    ghci> map (+3) [1,5,3,1,6]
    [4,8,6,4,9]
    ghci> map (map (^2)) [[1,2],[3,4,5,6],[7,8]]
    [[1,4],[9,16,25,36],[49,64]]
    ghci> map fst [(1,2),(3,5),(6,3),(2,6),(2,5)]
    [1,3,6,2,2]
```

A `filter` takes a predicate and a list and returns a new list containing the elements of the first list
for which the predicate is true.

```haskell
    filter :: (a -> Bool) -> [a] -> [a]
    filter _ [] = []
    filter p (x:xs)
        | p x           = x : filter p xs
        | otherwise     = filter p xs
```

Watch the magic:

```haskell
    ghci> filter (>3) [1,5,3,2,1,6,4,3,2,1]
    [5,6,4]
    ghci> filter even [1..10]
    [2,4,6,8,10]
    ghci> let notNull x = not (null x) in filter notNull [[1,2,3],[],[3,4,5],[2,2],[],[],[]]
    [[1,2,3],[3,4,5],[2,2]]
```

A list comprehension may be used as an alternative to both map and filter:

```haskell
    ghci> map (+3) [1,5,3,1,6]
    [4,8,6,4,9]
    ghci> [x+3 | x <- [1,5,3,1,6]]
    [4,8,6,4,9]

    ghci> filter (>3) [1,5,3,2,1,6,4,3,2,1]
    [5,6,4]
    ghci> [x | x <- [1,5,3,2,1,6,4,3,2,1], x > 3]
    [5,6,4]
```

The filter equivalent of several predicates is
applying several filters in series or joining the predicates with &&
but the predicates may be easier to read.

A map+filter may be easier to read as a list comprehension.
Nested list comprehensions may be easier to read as nested maps.

You can even combine the two:

```haskell
    ghci> [x | x <- map (*2) [1,5,3,2,1,6,4,3,2,1], x > 3]
    [10,6,4,12,8,6,4]
```*)

The choice is yours.


The old quicksort chestnut can be expressed using filters:

```haskell
    quicksort :: (Ord a) => [a] -> [a]
    quicksort [] = []
    quicksort (x:xs) = quicksort (filter (<=x) xs) ++ [x] ++ quicksort (filter (>x) xs)
```

but once again this illustrates clarity is not necessary efficiency.

This section wraps up with an illustration of applying a function partially using map to produce a list of functions:

```haskell
    map (*) [0 ...]
```*)

I thought this would lead to an illustration of how map can be used to map a function that takes two parameters
over a list but I don't think it did.

[ed:  Now I am lost again.]


#### Collatz Sequences

Collatz sequences are generated from a seed
by dividing even numbers by 2 and
by multiplying odd numbers by 3 and adding 1.
The chain finish with 1.
The theory is that all sequences finish (there are no infinite series)

```haskell
    chain :: (Integral a) => a -> [a]
    chain 1 = [1]
    chain n
        | even n    = n : chain (div n 2)
        | odd n     = n : chain (n * 3 + 1)
```

So, the question is ... for all starting numbers between 1 and 100, how many chains have a length greater that 15 ?

```haskell
    ghci> let isLong xs = length xs > 15 in length (filter isLong (map chain [1..100]))
```

### Lamdas


Lambdas are anonymous functions.
They are expressions and so can be used anywhere but are usually parameters to a higher order function.

They are usually about the same length as function named in let ... in expression or where ... clauses.
Here they are alternatives and you are free to use whichever you find the more readable.

The final expression from the previous section may be expressed as:

```haskell
    ghci> length (filter (\xs -> length xs > 15) (map chain [1..100]))
```

A lambda function is introduced by \ (standing in for λ).
This is followed by a list of parameters then -> followed by the body of the function.
The whole thing is enclosed in parentheses in order to make it clear (to the compiler) where it ends.

Lamdas do not have type declaration.
They can take any number of parameters.
They may take one guard pattern but they can only have one pattern:
if the pattern is not matched, an exception is thrown.

Do not over use lambdas:  `(+3)` and `(\x -> x + 3)` are equivalent but the first form is the more readable
(tell that to Python).


Lambdas can be used to illustrate currying:

```haskell
    addThree :: (Num a) => a -> a -> a -> a
    addThree x y z = x + y + z

    addThree' :: (Num a) => a -> a -> a -> a
    addThree' = \x -> \y -> \z -> x + y + z
```

are equivalent.

The tutorial also suggests that:

```haskell
    flip' :: (a -> b -> c) -> b -> a -> c
    flip' f = \x y -> f y x
```

is the most readable form of the flip function.
This is apparently because `flip` is usually bound with some other functions and the result passed to
map or filter, which is odd because these last two take only one parameter.
Anyway , it suggest lambdas should be used in this way to suggest explicitly the function is meant to be
partially applied and then passed to some other higher order function.

[ed:  Now I am lost yet again.]


### Only folds and horses

The tutorial claims that if you need to traverse a list once and return some result based on all elements,
the chances are you want a fold.
I think that you can always use a fold but
there may exist some other function whose use will make your intent clearer.

Haskell has four `fold` functions (whose effects are equivalent to the APL reduce operator) and
four `scan` functions (whose effects are equivalent to the APL scan operator).

The signatures of the four fold functions are:

```haskell
    ghci> :t foldl
    foldl :: (a -> b -> a) -> a -> [b] -> a
    ghci> :t foldl1
    foldl1 :: (a -> a -> a) -> [a] -> a

    ghci> :t foldr
    foldr :: (a -> b -> b) -> b -> [a] -> b
    ghci> :t foldr1
    foldr1 :: (a -> a -> a) -> [a] -> a
```

All return an accumulated result.
The difference between the `fold[lr]` and `fold[lr]1` variants is
the first take an initial value for the accumulated results while
the second take the first element of the list as an accumulated result.

Note, in the second form, the accumulator has the same type as the elements of the list
whereas, in the first form, this need not be the case.
Further more, the second form cannot take an empty list, whereas the first can.

The difference between `foldl?` and `foldr?` is the former fold from left-to-right (head-to-tail)
while the latter fold from right-to-left (tail-to-head).

Note the signature of the function passed to the fold function.
For the left fold it is `acc x -> acc` whereas from the right it is `x acc -> acc`.

Two implementations of sum using folds:

```haskell
    sum' :: (Num a) => [a] -> a
    sum' xs = foldl (\acc x -> acc + x) 0 xs

    sum'' :: (Num a) => [a] -> a
    sum'' = foldl1 (+)
```

And one for map:

```haskell
    map' :: (a -> b) -> [a] -> [b]
    map' f xs = foldr (\x acc -> f x : acc) [] xs
```

When the accumulator is a list, the right fold is much more efficient:
prepending values to a list is cheaper than appending them.

This is interesting because other functional programming languages have only the left fold.
They also prepend to the accumulator but must then reverse the result before return.
This arrangement would seem to be incompatible with lazy evaluation and
so may explain why Haskell has a right as well as a left fold.

Note:  you cannot fold from the left on infinite series but you can fold from the right on infinite series.
Do not ask why.

To illustrate the use of fold (and not necessary good Haskell programming practice),
here are some more examples of alternative implementations of standard library functions.

```haskell
    maximum' :: (Ord a) => [a] -> [a]
    maximum' = foldr1 (\x acc -> if x > acc then x else acc)

    reverse' :: [a] -> [a]
    reverse' = foldl (\acc x -> x : acc) []

    product' :: (Num a) => [a] -> a
    product' = foldr1 (*)

    filter' :: (a -> Bool) -> [a] -> [a]
    filter' p = foldr  (\x acc -> if p x then x : acc else acc) []

    head' :: [a] -> a
    head' = foldr (\x _ -> x)

    last' :: [a] ->
    last' = foldl (\_ x -> x)
```

The implement of reverse makes it very clear what is going on.
Contrast that with:

```haskell
    reverse' :: [a] -> [a]
    foldl' (flip (:)) []
```

Now some things begin to look a little clearer.
The `flip` function is about reordering another functions parameters to meet the function's requirements,
it is not about achieving a complementary result with non-commutative parameters.

And, naturally, other things become less clear.
What is the problem with:

```haskell
    reverse' :: [a] -> [a]
    foldr' (:) []
```

Here are a few examples of using scan:

```haskell
    ghci> scanl (+) 0 [3,5,2,1]
    [0,3,8,10,11]
    ghci> scanr (+) 0 [3,5,2,1]
    [11,10,8,3,0]

    ghci> scanl1 (\acc x -> if x > acc then x else acc) [3,4,5,3,7,9,2,1]
    [[],[3],[2,3],[1,2,3]]
```

The surprise here is the order of the result for `scanr`.

A slightly less trivial use:
how many elements does it take for the sums of the roots of all natural numbers to exceed 1000 ?

```haskell
    ghci> length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1
```


### Function application with $

Believe it or not, `$` is a function with the following definition:

```haskell
    ($) :: (a -> b) -> a -> b
    f $ x = f x
```

and before you spend too long wondering what is so special about this, it must be pointed out that what is
special is that is has the lowest precedence of all operator and is right associative.

One use (misuse ?) of this is simply to avoid parentheses:

```haskell
    >ghci sqrt (3 + 4 + 5)      -- is the same as
    >ghci sqrt $ 3 + 4 + 5
                                -- whereas

    >ghci sqrt 3 + 4 + 5        -- is the same as
    >ghci (sqrt 3) + 4 + 5
```

Because it is right associative it is handy when parentheses begin to nest themselves:

```haskell
    ghci> sum(filter (> 10) (map (* 2) [2..10))
    ghci> sum $ filter  (> 10) $ map (* 2) [2..10]]
```*)

but note that this (missing) closing parenthesis is (logically) at the end of the line.

What this operator really does is allows the mapping of a function over the list of functions:

```haskell
    ghci> map ($ 3) [(4+), (10*), (^2), sqrt]
    [7.0,30.0,9.0,1.7320508075688772]
```


### Function composition

In Haskell, `function composition` is based on function composition in mathematics.
It is defined as follows:

```haskell
    (.) :: (b -> c) (a -> b) -> a -> c
    f . g = \x -> f (g x)
```

One use for this operator is to replace lambda function with a clearer, more concise, expression.
The following are equivalent:

```haskell
    ghci> map (negate . sum . tail) [[1..5],[3..6],[1..7]]
    [-14,-15,-27]
    ghci> map (\xs -> negate (sum (tail xs))) [[1..5],[3..6],[1..7]]
    [-14,-15,-27]
    ghci> map negate (map sum (map tail [[1..5],[3..6],[1..7]]))
    [-14,-15,-27]
```

Another use is in `point free` notation.
Due to the nature of currying:

```haskell
    sum' :: (Num a) => [a] -> a
    sum' xs = foldl (+) 0 xs

    sum'pf :: (Num a) => [a] -> a
    sum'pf = foldl (+) 0
```

are equivalent.
The latter may take some getting used to (the type declaration tell you the function takes one parameter).

Taking the `point free` notation to its logical conclusion, the following are equivalent:

```haskell
    fn' x = ceiling (negate (tan (cod (max 50 x))))

    fn'pf = ceiling . negate . tan . cos . max 50
```

The tutorial warns against this and suggests using `let ... in` expressions to make the intent clear.
I guess it depends.

The `.` operators will only combine functions that take one parameter so
`partial application` is required for functions that take more than one.

</body>
</html>
