module DNA (toRNA) where

import Data.Maybe(fromJust, isNothing)

toRNA :: String -> Maybe String
toRNA =
    foldl dna (Just [])
    where
        dna rna nucleotide =
            if isNothing rna || isNothing (toRNA' nucleotide)
               then Nothing
               else Just $ fromJust rna ++ [fromJust (toRNA' nucleotide)]

        toRNA' 'G' = Just 'C'
        toRNA' 'C' = Just 'G'
        toRNA' 'T' = Just 'A'
        toRNA' 'A' = Just 'U'
        toRNA'  _  = Nothing

--
-- Here is an apparent one pass solution using foldl.
--
-- I don't like the if then else so that will have to go.
--
-- I'm not all at all sure the ++ is efficient.
--
