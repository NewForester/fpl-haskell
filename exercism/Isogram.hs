module Isogram (isIsogram) where

import Data.Set (Set, size, fromList)
import Data.Char (toLower, isLetter)

isIsogram :: String -> Bool
isIsogram string =
    checkIsogram [toLower c | c <- string, isLetter c]
    where checkIsogram string
            | length' <= 26 = size (fromList string) == length'
            | otherwise     = False
            where length' = length string

-- ^
-- Final word.
-- This iteration incorporate the upper bound:
-- no string longer than 26 characters can possibly be an isogram.
--
