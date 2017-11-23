module SumOfMultiples (sumOfMultiples) where

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit =
    sum [x | x <- [1..limit - 1], any (\n -> mod x n == 0) factors]

--
-- Easy exercise translated from Erlang via Python.
--
-- This 'loops' on 'factors' within 'limit', which is inside out wrt to the
-- readme.  I guess there is a trade-off that would mean the alternative might
-- be faster for a large limit and few factors.
--
-- Half the other solutions used the same method as I.  A couple used the
-- alternative a `nub` to eliminate duplicates.
--
