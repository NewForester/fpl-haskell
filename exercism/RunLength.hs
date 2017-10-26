module RunLength (decode, encode) where

import Data.Char (isDigit)
import Data.List (group)

--

decode :: String -> String
decode "" = ""
decode encodedText
    | count == ""   = x : decode xs
    | otherwise     = replicate (read count) x ++ decode xs
    where (count, x:xs) = span isDigit encodedText

--

encode :: String -> String
encode "" = ""
encode text = concat [encodeRun run | run <- group text]

encodeRun :: String -> String
encodeRun run
    | count == 1    = letter
    | otherwise     = (++) (show count) letter
    where letter = [head run]
          count = length run

-- ^
-- Refactored to use library functions span and group after a comment from the
-- invigilator and examining other solutions.
-- Iteration #3 removes spurious () reported by hlint.
--
