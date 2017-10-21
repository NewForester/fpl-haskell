module Pangram (isPangram) where

import Data.Char (toLower)

isPangram :: String -> Bool
isPangram text =
    all (\a -> any (a==) lower) ['a'..'z']
    where lower = map toLower text

--
-- The hlint tool suggested I use the library function elem.
-- That would give:
--

isPangram' :: String -> Bool
isPangram' text =
    all (\a -> elem a lower) ['a'..'z']
    where lower = map toLower text
