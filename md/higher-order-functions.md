<!DOCTYPE html>
<html lang="en-GB">
    <!-- haskell notes by NewForester is licensed under a Creative Commons Attribution-ShareAlike 4.0 International Licence. -->
<head>
    <title>Learn You A Haskell Notes: Higher Order Functions</title>
    <meta charset="UTF-8" />
    <meta name="description" content="Notes on the Haskell programming language made while learning a bit about Functional Programming" />
    <meta name="keywords" content="Haskell" />
    <meta name="author" content="NewForester" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" href="../styles/style-sheet.css" />
</head>

<body>

# Learn You A Haskell

## Higher Order Functions

In Haskell a function may take another function as a parameter or return a function.
Functions that do so are called `higher order functions`.

This puts functions on a par with data.

In Haskell this is taken to the extreme.
It uses currying heavily (no mention of closures).

The chapter leaps straight into `currying`,
which may seem strange until you realise currying is central to Haskell thinking and
not merely an interesting consequence.

Partial application of functions, function composition and anonymous `lambda` functions are covered
as is function application with $ instead of <space>.

The chapter covers `map` and `filter`, the bread and butter of functional programming,
and later fold and scan in some detail.
The examples make `currying` and `partial application` of functions look natural.


### Curried Functions

Officially, every function in Haskell takes only one parameter.
A function that appears to take two parameters is in fact a function that takes one (the first) parameter
and returns a function that takes the other (second) parameter.

A function that takes several parameters is converted into a sequence of functions that
each take only one parameter by a process known as `currying`.

That is, at one level, all there is to it.  The process of currying is named after Haskell Curry,
the logician after who the language is also named.

In terms of Haskell syntax, the following are equivalent:

```haskell
    ghci> max 4 5
    5
    ghci>(max 4) 5
    5
```

In the first (more common) form the space is an operator named `function application`.
It quite simply has the highest order of precedence.

The type declaration of `max` can also be written two ways:

```haskell
    max :: (Ord a) => a -> a -> a
    max :: (Ord a) => a ->(a -> a)
```

The second declaration reads:
"max is a function that takes an `a` and returns a function that takes an `a` and returns an `a`".


Note the parentheses in a type declaration have a different significance:
on the left of -> is the parameter and on the right is the return.

Consider next:

```haskell
    multiplyThreeNumbers :: (Num a) => a -> a -> a -> a
    multiplyThreeNumbers x y z = x * y * z
```

Conventional wisdom says this is a function that takes three (numeric) parameters a multiplies then together.

Haskell wisdom says this is a function that takes a number and returns a function that takes a second number
and multiplies it with the first and returns another function that takes the third number and
multiplies it with the result so far.

If insufficient parameters are passed to the routine, another function on the fly is created on-the-fly:

```haskell
    ghci> let multiplyTwoNumbersByNine = multiplyThreeNumbers 9
    ghci> let multiplyByEighteen = multiplyTwoNumbersByNine 2
```

This simple example may not look very useful but really useful examples may not be all that simple.

Here's one more:

```haskell
    compareWithOneHundred :: (Num a, Ord a) => a -> Ordering
    compareWithOneHundred x = compare x 100
```

This process is called `partial application`.
The language's infix functions can also be applied partially by using `sections`.
Remember that infix function can be used as an ordinary function by using parentheses ... so voilá:

```haskel
    ghci> let divideByTen = (/10)
    ghci> divideByTen 200
    20.0
    ghci> let divideIntoOneHundred = (100/)
    ghci> divideIntoOneHundred 25
    4.0
```

Note that `(-4)` means 'minus four'.  Oops.
Use `(subtract 4)` instead.

xxxx  EXPLAIN the missing parameter    sum'' = foldl (+) 0

Functions do not belong to the Show typeclass so if you mess up your partial application in GHCI you will
very likely get an exception that complains about a use of `print` when you have not typed print.


### Some higher-orderism is in order

Functions may take functions as parameters:

```haskell
    applyTwice :: (a -> a) -> a -> a
    applyTwice f x = f (f x)
```

The parentheses in the type declaration indicate the first parameter is a function that takes and returns an `a`.

Now watch the magic as this new function is used with partially applied functions:

```haskell
    ghci> applyTwice (+3) 10
    16
    ghci> applyTwice (++ " HAHA") "HEY"
    "HEY HAHA HAHA"
    ghci> applyTwice ("HAHA " ++) "HEY"
    "HAHA HAHA HEY"
    ghci> applyTwice (3:) [1]
    [3,3,1]
```

Higher order functions are very versatile.
Here is an implementation of the standard library `zipwith` function that looks a lot like map(f,a,b) in Python.

```haskell
    zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
    zipWith' _ [] _ = []
    zipWith' _ _ [] = []
    zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys
```

Again, watch the magic:

```haskell
    ghci> zipWith' (+) [4,2,5,6] [2,6,2,3]
    [6,8,7,9]
    ghci> zipWith' min [6,3,2,1] [7,3,1,5]
    [6,3,1,1]
    ghci> zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]]
    [[3,4,6],[9,20,30],[10,12,12]]
```*)

Another function in the standard library is `flip`.
It takes a function and returns another that accepts the functions first two parameters in reverse order.

```haskell
    flip' :: (a -> b -> c) -> (b -> a -> c)
    flip' f = g
        where g x y = f y x
```

I can see why what is declared says the right thing but do not quite grasp how the Haskell compiler complies it.
Perhaps it all comes back to currying

An alternative way of writing this is:

```haskell
    flip'' :: (a -> b -> c) -> (b -> a -> c)
    flip'' f y x = f x y
```

[ed:  Now I am lost.]


### Maps and Filters = HERE

The bread and butter of functional programming are `map` and `filter`.
They are alternatives to list comprehensions.

A `map` takes a function and applies it to every element in a list producing a new list.

Note: it is not just lists - other recursive data structures such as trees have an analogous function.

```haskell
    map' :: (a -> b) -> [a] -> [b]
    map' _ [] = []
    map' f (x:xs) = f x : map' f xs
```

Watch the magic:

```haskell
    ghci> map' (+3) [1,5,3,1,6]
    [4,8,6,4,9]
    ghci> map' (map' (^2)) [[1,2],[3,4,5,6],[7,8]]
    [[1,4],[9,16,25,36],[49,64]]
    ghci> map' fst [(1,2),(3,5),(6,3),(2,6),(2,5)]
    [1,3,6,2,2]
```

A `filter` takes a predicate and a list and returns a new list containing the elements of the first list
for which the predicate is true.

```haskell
    filter' :: (a -> Bool) -> [a] -> [a]
    filter' _ [] = []
    filter' p (x:xs)
        | p x           = x : filter' p xs
        | otherwise     = filter' p xs
```

Watch the magic:

```haskell
    ghci> filter' (>3) [1,5,3,2,1,6,4,3,2,1]
    [5,6,4]
    ghci> filter' even [1..10]
    [2,4,6,8,10]
    ghci> let notNull x = not (null x) in filter' notNull [[1,2,3],[],[3,4,5],[2,2],[],[],[]]
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

A map-with-filter may be easier to read as a list comprehension.
Nested list maps may be easier to read as nested comprehensions.

You can even combine the two:

```haskell
    ghci> [x | x <- map (+0.5) [1,5,3,2,1,6,4,3,2,1], x > 3]
    [5.5,3.5,6.5,4.5,3.5]
```

The choice is yours.


The old quicksort chestnut can be expressed using filters:

```haskell
    quicksort :: (Ord a) => [a] -> [a]
    quicksort [] = []
    quicksort (x:xs) = quicksort (filter (<=x) xs) ++ [x] ++ quicksort (filter (>x) xs)
```

but once again this illustrates clarity and not necessary efficiency.

This section wraps up with an illustration of applying a function partially using map to produce a list of functions:

```haskell
    map (+) [0 ...]
```

I thought this would lead to an illustration of how map can be used to map a function that takes two parameters
over a list but I don't think it did.

[ed:  Now I am lost again.]


#### Collatz Sequences

Collatz sequences are generated from a seed
by dividing even numbers by 2 and
by multiplying odd numbers by 3 and adding 1.
The chain finishes with 1.
The theory is that all sequences finish (there are no infinite series).

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
Here they are alternatives and you are free to use whichever clearly conveys your reasoning.

The final expression from the previous section may be expressed as:

```haskell
    ghci> length (filter (\xs -> length xs > 15) (map chain [1..100]))
```

A lambda function is introduced by \ (standing in for λ).
This is followed by a list of parameters then -> followed by the body of the function.
The whole thing is usually enclosed in parentheses in order to make it clear (to the compiler) where it ends.

Lamdas do not have type declaration.
They can take any number of parameters.
They may take one guard pattern but they can only have one pattern:
if the pattern is not matched, an exception is thrown.

Do not over use lambdas:  `(+3)` and `(\x -> x + 3)` are equivalent but the first form is to be preferred.


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

conveys the intent best.

This is apparently because `flip` is usually bound with some other function and the result passed to
map or filter, which is odd because these last two take only one parameter.
Anyway , the tutorial recommends lambdas should be used in this way to suggest explicitly that
the function is meant to be partially applied and then passed to some other higher order function.

[ed:  Now I am lost yet again.]

Perhaps it means that `partical application` of the first parameter to a function before passing it to
map or filter just works but to bind the second parameter you need flip.


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
    map'' :: (a -> b) -> [a] -> [b]
    map'' f xs = foldr (\x acc -> f x : acc) [] xs
```

When the accumulator is a list, the right fold is much more efficient:
prepending values to a list is cheaper than appending them.

This is interesting because other functional programming languages have only the left fold.
They also prepend to the accumulator but must then reverse the result before return.
This arrangement would seem to be incompatible with lazy evaluation and
so may explain why Haskell has a right as well as a left fold.

Note:  you cannot fold from the left on infinite series but you can fold from the right.
Do not ask why.

To illustrate the use of fold (and not necessary good Haskell programming practice),
here are some more examples of alternative implementations of standard library functions.

```haskell
    maximum' :: (Ord a) => [a] -> a
    maximum' = foldr1 (\x acc -> if x > acc then x else acc)

    reverse' :: [a] -> [a]
    reverse' = foldl (\acc x -> x : acc) []

    product' :: (Num a) => [a] -> a
    product' = foldr1 (*)

    filter'' :: (a -> Bool) -> [a] -> [a]
    filter'' p = foldr  (\x acc -> if p x then x : acc else acc) []

    head' :: [a] -> a
    head' = foldr (\x _ -> x)

    last' :: [a] -> a
    last' = foldl (\_ x -> x)
```

The implementation of reverse makes the intent very clear.
Contrast that with:

```haskell
    reverse'' :: [a] -> [a]
    reverse'' = foldl (flip (:)) []
```

Now some things begin to look a little clearer.
The `flip` function is about reordering another functions parameters to meet the function's requirements,
it is not about achieving a complementary result with non-commutative parameters.

Here are a few examples of using scan:

```haskell
    ghci> scanl (+) 0 [3,5,2,1]
    [0,3,8,10,11]
    ghci> scanr (+) 0 [3,5,2,1]
    [11,10,8,3,0]

    ghci> scanl1 (\acc x -> if x > acc then x else acc) [3,4,5,3,7,9,2,1]
    [3,4,5,5,7,9,9,9]
    ghci> scanl (flip (:)) [] [3,2,1]
    [[],[3],[2,3],[1,2,3]]
```

The surprise here is the order of the result for `scanr`.

A slightly less trivial use:
how many elements does it take for the sums of the roots of all natural numbers to exceed 1000 ?

```haskell
    ghci> length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1
    131
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
