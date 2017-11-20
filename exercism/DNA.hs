module DNA (toRNA) where

import Data.Maybe(fromJust, isNothing)

toRNA :: String -> Maybe String
toRNA =
    foldr dna (Just[])
    where
        dna _ Nothing = Nothing
        dna nucleotide rna
            | isNothing (toRNA' nucleotide) = Nothing
            | otherwise = Just $ fromJust (toRNA' nucleotide) : fromJust rna

        toRNA' 'G' = Just 'C'
        toRNA' 'C' = Just 'G'
        toRNA' 'T' = Just 'A'
        toRNA' 'A' = Just 'U'
        toRNA'  _  = Nothing

--
-- This iteration uses foldr:
--
--   * good list construction uses : instead of ++
--   * foldr instead of foldl allows early termination
--   * needs an awful lot of stack
--
-- So it's a two out of three ain't bad solution.
--
