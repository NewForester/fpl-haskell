module DNA (toRNA) where

import Data.Maybe(fromJust, isNothing)

toRNA :: String -> Maybe String
toRNA =
    foldl dna (Just[])
    where
        dna Nothing _ = Nothing
        dna rna nucleotide
            | isNothing (toRNA' nucleotide) = Nothing
            | otherwise = Just $ fromJust rna ++ [fromJust (toRNA' nucleotide)]

        toRNA' 'G' = Just 'C'
        toRNA' 'C' = Just 'G'
        toRNA' 'T' = Just 'A'
        toRNA' 'A' = Just 'U'
        toRNA'  _  = Nothing

--
-- This iteration uses heads and guards to make it clear we want the function
-- to stop and go no further with:
--
--     dna Nothing _ = Nothing
--
