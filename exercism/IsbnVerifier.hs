module IsbnVerifier (isbn) where

import Text.Regex.Posix (Regex, makeRegex, matchTest)
import Data.List (elemIndex)
import Data.Maybe (fromJust)

isbn :: String -> Bool
isbn = flip any [sansDashes, withDashes] . almost
    where
        almost pointless = ($ pointless)

        sansDashes = check [length' 10, match' sansRegex, validateSans']
        withDashes = check [length' 13, match' withRegex, validateWith']

        check conditions = flip all conditions . almost

        length' nn = (== nn) . length
        match' = matchTest

        sansRegex = makeRegex "^[0-9]{9}[0-9X]$" :: Regex
        withRegex = makeRegex "^[0-9]+-[0-9]+-[0-9]+-[0-9X]$" :: Regex

        validateSans' = validate . convert
        validateWith' = validateSans' . filter (/= '-')

        convert = map (fromJust . flip elemIndex "0123456789X")

        validate = (== 0) . flip mod 11 . sum . zipWith (*) [1..10]

--
-- This is my attempt at a pointless solution.
--
-- It does not name the string that represents the ISBN number being checked.
-- This string is the implicit last parameter of most statements.
-- The important exception is
--
--      almost pointless = ($ pointless)
--
-- My poor understanding of pointless notation is such that I think you can
-- only use it if you can reorder within statements so the last (here only)
-- parameter appears only once at the end of the statement.
--
-- It seems to me that you have to abandon using guards and list comprehensions
-- and probably other useful features of the Haskell language.
--
-- I have used any and all in an unusual way.
--
-- Instead of using them to apply a predicate to a list of parameters,  I have
-- used then to apply a list of predicates to just one parameter.  Fine.
--
-- Then I tried to rearrange statements so that the one parameter appeared at
-- the end of the statement.  Not fine.  I ran into syntax errors.
--
-- Applying a value to a list of functions instead of a function to a list of
-- values strikes me as well within the capability of the language. I imagine
-- there is a library of functions that do just that and that if I used that
-- library I would not need flip and so would have no trouble making this
-- solution pointless.
--
