module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz nn
    | nn > 0    = Just $ getOnWithIt nn 0
    | otherwise = Nothing
    where getOnWithIt nn count
            | nn == 1   = count
            | odd nn    = 1 + getOnWithIt (nn * 3 + 1) (+1) count
            | even nn   = 1 + getOnWithIt (nn `div` 2) (+1) count

-- ^
-- I had trouble with Maybe.
-- I introduced a second routine just to get around this.
--
-- I could have imported Data.Maybe and used fromJust/1
-- to convert the Maybe returned by recursion to integers.
--
-- Others used recursion to pass down the count so avoiding
-- conversion to Maybe until the final return and allowing
-- the compiler to use tail recursion (if Haskell does that).
--
-- Some other used recursion with a 'where' clause, which
-- seemed to solve all the problems.  See iteration #2.
--
