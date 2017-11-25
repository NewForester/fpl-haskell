module Squares (difference, squareOfSums, sumOfSquares) where

difference :: Integral a => a -> a
difference n = squareOfSums n - sumOfSquares n

squareOfSums :: Integral a => a -> a
squareOfSums n = sums n * sums n

sumOfSquares :: Integral a => a -> a
sumOfSquares n = div (sums n * (1+) ((2*) n)) 3

sums :: Integral a => a -> a
sums n = div (n * (1+) n) 2

--
-- This is a trivial exercise.  It does not need loops or recursion since
-- there are simple algebraic equations that produce the answers needed.
-- So here I amused myself by disguising them using Haskell's clever
-- syntax.  Readable ?  Reasonable ?  Don't be silly.
--
