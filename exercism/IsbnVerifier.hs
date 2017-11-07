module IsbnVerifier (isbn) where

import Text.Regex.Posix ((=~))
import Data.String.Utils (join, split)

isbn :: String -> Bool
isbn string
    | string =~ sinDashes :: Bool   = validate string
    | string =~ conDashes :: Bool   = validate $ join "" $ split "-" string
    | otherwise                     = False
    where
        sinDashes   = "^[0-9]{9}[0-9X]{1}$"
        conDashes   = "^[0-9]{1}-[0-9]{3}-[0-9]{5}-[0-9X]{1}$"

        validate string =
            (calculate string 10 0) `mod` 11 == 0

        calculate [] 0 acc =
            acc
        calculate ('X':xs) count acc =
            calculate xs (count - 1) (acc + count * 10)
        calculate (x:xs) count acc =
            calculate xs (count - 1) (acc + count * read [x])

--
-- I'm the odd one out again.
-- Almost everyone else used zipwith to produce the product.
-- Most took it that you could use x instead of X.
-- I don't think they cared where the dashes appeared.
-- No one used split and join to remove them.
-- One had !! but I blowed if I understand what this achieves.
--
