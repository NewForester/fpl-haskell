module Isogram (isIsogram) where

import Data.Char (toLower, isLetter)

isIsogram :: String -> Bool
isIsogram string =
    checkIsogram [toLower c | c <- string, isLetter c]

checkIsogram :: String -> Bool
checkIsogram "" =
    True
checkIsogram (x:xs)
    | elem x xs     = False
    | otherwise     = checkIsogram xs

-- ^
-- Most solutions I looked at did not use a list comprehension
-- Many used nub to removed duplicates.
-- One then used sort which seems overkill.
--
-- As I thought, it should be possible to do this in one function.
--

isIsogram' :: String -> Bool
isIsogram' string =
    checkIsogram [toLower c | c <- string, isLetter c]
    where checkIsogram "" = True
          checkIsogram (x:xs)
              | elem x xs     = False
              | otherwise     = checkIsogram xs

-- ^
-- If nub is used to do the heavy lifting we might have:
--

isIsogram'' :: String -> Bool
isIsogram'' string =
    checkIsogram [toLower c | c <- string, isLetter c]
    where checkIsogram string = string == nub string
