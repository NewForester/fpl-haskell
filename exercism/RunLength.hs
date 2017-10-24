module RunLength (decode, encode) where

import Data.Char (digitToInt)

--

decode :: String -> String
decode encodedText = decoder encodedText 0 ""

decoder :: String -> Int -> String -> String
decoder [] _ result
    = result
decoder (x:xs) count result
    | elem x ['0'..'9'] = decoder xs (10 * count + digitToInt x) result
    | otherwise         = decoder xs 0 $ (++) result $ replicate (max 1 count) x

--

encode :: String -> String
encode text = encoder text 0 '!' ""

encoder :: String -> Int -> Char -> String -> String
encoder [] count letter result
    = glue result count letter
encoder (x:xs) count letter result
    | x == letter       = encoder xs (count + 1) letter result
    | otherwise         = encoder xs 1 x $ glue result count letter

glue :: String -> Int -> Char -> String
glue encoding count letter
    | count == 0    = encoding
    | count == 1    = (++) encoding [letter]
    | otherwise     = (++) encoding $ (++) (show count) [letter]

-- ^
-- Most of the other solution I looked at do not use recursion
-- but use library functions (that must do the recursion)
--      decode: read (opposite of show). span
--      encode: concatMap, group, groupBy (all three in Data.list), span
--
-- Feedback from the monitor suggest glue does two things and should be split
