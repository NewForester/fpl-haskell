module IsbnVerifier (isbn) where

import Text.Regex.Posix ((=~))
import Data.Char (digitToInt)

isbn :: String -> Bool
isbn string
    | string =~ sinDashes :: Bool   = validate $ convert string
    | string =~ conDashes :: Bool   = validate $ convert $ filter (/= '-') string
    | otherwise                     = False
    where
        sinDashes = "^[0-9]{9}[0-9X]{1}$"
        conDashes = "^[0-9]{1}-[0-9]{3}-[0-9]{5}-[0-9X]{1}$"

        validate string = sum (zipWith (*) string [10,9..1]) `mod` 11 == 0
        convert string = [if c == 'X' then 10 else digitToInt c | c <- string]

--
-- Yes, zipwith was what I was looking for.
--
