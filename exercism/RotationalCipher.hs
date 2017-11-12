module RotationalCipher (rotate) where

import Data.Char (isLower, isUpper, ord, chr)

rotate :: Int -> String -> String
rotate key text =
    [encrypt c | c <- text]
    where
        encrypt c
            | isLower c = encrypt' (ord c) (ord 'a')
            | isUpper c = encrypt' (ord c) (ord 'A')
            | otherwise = c
        encrypt' char base =
            chr $ mod (char - base + key') 26 + base
        key' = mod key 26

--
-- This looks imperative to me but without suitable library functions ...
--
-- Tarmean appears to have a pointless solution that uses <*>
--
-- Otherwise most solution used map (not a list comprehension)
-- and dealt with one character at a time.  Pity.
--
-- Most appear to have tried to set up a translation table
-- but I find their code anything but easy to reason about.
--
