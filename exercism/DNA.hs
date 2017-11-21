module DNA (toRNA) where

import Data.Maybe(fromJust)
import Data.Sequence(empty, (|>))
import Data.Foldable(foldl', toList)

toRNA :: String -> Maybe String
toRNA xs =
    rna $ foldl' dna (Just empty) xs
    where
        rna Nothing = Nothing
        rna rnaSeq = Just $ toList $ fromJust rnaSeq

        dna Nothing _ = Nothing
        dna rnaSeq nucleotide = dna' rnaSeq (toRNA' nucleotide)

        dna' _ Nothing = Nothing
        dna' rnaSeq nucleotide = Just $ fromJust rnaSeq |> fromJust nucleotide

        toRNA' 'G' = Just 'C'
        toRNA' 'C' = Just 'G'
        toRNA' 'T' = Just 'A'
        toRNA' 'A' = Just 'U'
        toRNA'  _  = Nothing

--
-- This iteration uses:
--
--  * Data.Sequence instead of Data.List
--  * no 'guards', only 'function headers'
--
-- The Data.Sequence allows data to be added to the end in constant time.
-- This, in turn, allows the use of the memory and time efficient foldl'.
--
-- The downside is an extra pass over the data is needed to convert back to a
-- list and the sequence may increase heap memory requirements considerably
-- although, in this case, I would expect the lower stack memory requirements
-- mean the benefits outweigh the costs.
--
-- Using foldl' means the fold will not stop early but I suspect that the new
-- rna routine will stop early instead.
--
-- It would be nice to have execution trace to confirm this.
--
