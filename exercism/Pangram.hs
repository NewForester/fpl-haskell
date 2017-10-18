module Pangram (isPangram) where

import Data.Char (toLower)

isPangram :: String -> Bool
isPangram text =
    all (\a -> any (\c -> c == a) lower) ['a'..'z']
    where lower = map toLower text

--
-- The monitor for this exercise suggested I use a 'section'.
-- So I did.  See iteration #2.
--
