module IsbnVerifier (isbn) where

import Text.Regex.Posix ((=~))
import Data.Char (digitToInt)

isbn :: String -> Bool
isbn string
    | length string == 10 && string =~ sinDashes :: Bool = validate $ convert string
    | length string == 13 && string =~ conDashes :: Bool = validate $ convert $ filter (/= '-') string
    | otherwise = False
    where
        sinDashes = "^[0-9]{9}[0-9X]$"
        conDashes = "^[0-9]+-[0-9]+-[0-9]+-[0-9X]$"

        validate numbers = sum (zipWith (*) numbers [1..10]) `mod` 11 == 0
        convert string = [if c == 'X' then 10 else digitToInt c | c <- string]

--
-- The dashes are significant but their positions are not as fixed as I had thought.
--
