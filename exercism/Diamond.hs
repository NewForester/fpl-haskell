module Diamond (diamond) where

import Data.Char (ord, chr)

diamond :: Char -> [String]
diamond letter =
    diamond' 1
    where
        diamond' nn
            | nn == centre  = torow nn
            | otherwise     = torow nn ++ diamond' (nn + 1) ++ torow nn

        torow nn = [torow' 1 nn]

        torow' nn num
            | nn > centre * 2 - 1       = []
            | nn == centre - (num - 1)  = toletter num : torow' (nn + 1) num
            | nn == centre + (num - 1)  = toletter num : torow' (nn + 1) num
            | otherwise                 = ' ' : torow' (nn + 1) num

        centre = ord letter - ord 'A' + 1

        toletter num = chr $ num + ord 'A' - 1
--
-- This solution looks simple enough but I would have trouble commenting it.
-- There is no clever use of library functions.
--
-- Of the 10 solutions I studied:
--   - rbasso used (advanced) libraries and monoids - no idea what it is doing
--   - FabienGadet0 gave up
--   - teehemkay produced the Goldlocks solution
--
-- Most of the others where longer and I spent my time reasoning about their
-- use of library functions.
--
-- The only shorter one condensed teekhemkay's solution but left you needing
-- to reason about the whole problem at once, not just one bit at a time.
--

-- teehemkay's solution

diamond' :: Char -> [String]
diamond' char = [rowFor letter | letter <- verticalPattern]
    where
        -- ABCD
        letters = ['A' .. char]
        -- DCBABCD
        horizontalPattern = (reverse . drop 1 $ letters) ++ letters
        -- ABCDCBA
        verticalPattern = letters ++ (drop 1 . reverse $ letters)
        -- rowFor 'A' -> "···A···", rowFor 'B' -> "··B·B··"...
        rowFor :: Char -> String
        rowFor letter = map mask horizontalPattern
    where
        mask :: Char -> Char
        mask c
            | c == letter = letter
            | otherwise = ' '

-- gilgamec's condensation

diamond'' :: Char -> [String]
diamond'' ch = map rowFor col
    where row = [ch,pred ch..'A'] ++ ['B'..ch]
          col = ['A'..ch] ++ tail [ch,pred ch..'A']
          rowFor ch = map (\c -> if c == ch then c else ' ') row
