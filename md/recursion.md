<!DOCTYPE html>
<html lang="en-GB">
    <!-- haskell notes by NewForester is licensed under a Creative Commons Attribution-ShareAlike 4.0 International Licence. -->
<head>
    <title>Learn You A Haskell Notes: Recursion</title>
    <meta charset="UTF-8" />
    <meta name="description" content="Notes on the Haskell programming language made while learning a bit about Functional Programming" />
    <meta name="keywords" content="Haskell" />
    <meta name="author" content="NewForester" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" href="../styles/style-sheet.css" />
</head>

<body>

# Learn You A Haskell

## Recursion

Recursion is core to Functional Programming languages:  it is one of the two looping constructs.

While many other languages emphasise tail recursion, which offers scope for optimisation, this chapter does not.
Thinking about this, you cannot do tail recursion on infinite lists and
Haskell is the first language to handle infinite lists explicitly.

Another thought is that Haskell implements lazy evaluation while Erlang and others do not.
With lazy evaluation perhaps recursion is merely a syntax and not an implementation.
In which case tail recursion optimisation may be moot.

The chapter is largely examples with explanations.
The code examples may all be found in [Recursion Examples](../learn-you-a-haskell/recursion.hs).

The chapter wraps up with suggestions on a general approach to thinking recursively.


### Hello recursion !

Recursion is important in Haskell because the idea is to state what something is rather than how you get it.
The idea is borrowed from mathematics.
The Fibonacci series is a good example:

```maths
    F(0) = 0
    F(1) = 1
    F(n) =  F(n-1) + F(n-2)
```

There are two edge conditions for the first two numbers in the series but
the rest of the series are defined recursively in terms of their predecessors.


### Maximum Awesome

See the `maximum` and `max` code examples.
The points to note here is that the maximum for the whole list is the maximum of the list's head and tail
and that the maximum of the tail can conveniently be calculated using recursion:
the function calls itself.


### A few more recursive functions

See the `replicate` code example.
The edge case is 0, (<= 0 is simply defensive) and the recursion in the otherwise clause works towards 0.

See the `take` code example.
There is an edge case on the first parameter and another on the second and these require different patterns.
The recursion is therefore matched by the third pattern.
It follows the standard list pattern.

See the `reverse` and `repeat` code examples.

The first has no accumulator and is not tail recursive and one might wonder why.
The second has no edge condition because it can produce an infinite list.

If you think about it, does lazy evaluation not mean recursive routines are not actually calling themselves ?
Interesting thought.

See the `zip` code example.
The function takes two parameters and naturally each has a edge case.
The zipping stops when the shorter of the two parameters is exhausted.


### Quick, sort !

Quicksort is an amazingly compact algorithm in most languages but even more so in Haskell.
It is considered 'cheesy' by Haskell programmers because it has be used too often.

From any description of the quicksort it should clear that the recursion will involve the routine calling itself twice.
See the `quicksort` code example.
It does not look particularly efficient to a C programmer.


### Thinking recursively

There is a pattern to thinking recursively that means it is not as difficult as it might seem at first.

There is something repetitive - that is rather like the body of a loop.

There are edge cases - these are rather like the end (sometimes the start) conditions of a loop.

There are the new parameters for the recursion - these are analogous to loop reinitialisation.

The non-trivial routine deals with some element of the problem and passes the rest down to itself
in order to work on the next element of the problem until an edge case is encountered.

All routines return a value.
It is useful to think of this as the accumulator or the result so far.
As results are passed back they are often combined with the element at the level above.

The edge case is often an identity - 0 or 1, for example, or an empty list.

This is the scheme of things whether dealing with numerical sequences, lists, trees or any other (recursive)
data structure.

One difference (depending on how you code) with numerical sequences may be counting down towards an edge case
rather than counting up to some arbitrary boundary.
This is perhaps less important with Haskell and its lazy evaluation.

With lists you usually keep the head and pass the tail down and the edge case is an empty list.

</body>
</html>
