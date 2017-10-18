module Bob (responseFor, responseFor') where

import Data.Char (isSpace, isUpper, isAlpha, toLower, toUpper)

responseFor :: String -> String
responseFor xs =
    case (silence, shouting, question) of
        (True, _, _) -> "Fine. Be that way!"
        (_, True, _) -> "Whoa, chill out!"
        (_, _, True) -> "Sure."
        otherwise    -> "Whatever."
    where trimmed = filter (\c -> not (isSpace c)) xs
          silence = null trimmed
          shouting = any isAlpha trimmed && all (\c -> isUpper c || not (isAlpha c)) trimmed
          question = last trimmed == '?'

-- ^
-- Filtering trimmed to remove non alphabetic character first
-- does not help determine shouting since all on any empty vector is True, not False
--
-- It is possible to have guards comprising complex evaluations
-- (I must have been thinking Erlang) and so avoid evaluating all three conditions.

responseFor' :: String -> String
responseFor' xs
    | silence = "Fine. Be that way!"
    | shouting = "Whoa, chill out!"
    | question = "Sure."
    | otherwise = "Whatever."
    where trimmed = filter (\c -> not (isSpace c)) xs
          silence = null trimmed
          shouting = any isAlpha trimmed && all (\c -> isUpper c || not (isAlpha c)) trimmed
          question = last trimmed == '?'

-- ^
-- It turns out someone liked my first implementation.  Perhaps Haskell is
-- lazy enough to only evaluate elements of the 'where' clause if needs to.
-- My Erlang implementation followed the second form above but someone
-- submitted an Erlang solution that did (and Erlang uses eager evaluation) !
--
