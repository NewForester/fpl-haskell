module Isogram (isIsogram) where

import Data.Set (Set, size, fromList)
import Data.Char (toLower, isLetter)

isIsogram :: String -> Bool
isIsogram string =
    length (clean string) == size (fromList (clean string))
    where clean string = [toLower c | c <- string, isLetter c]

-- ^
-- A two line solution using libraries after a suggestion by @teehemkay.
-- It uses set rather than nub and so has a better O.
-- For isogram, with N bounded at 26, the O is not important
--
-- However, it is good to know that using set is not onerous.
--
-- Note that to import Data.Set I had to change the build parameters.
--
