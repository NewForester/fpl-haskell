module DNA (toRNA) where

toRNA :: String -> Maybe String
toRNA =
    foldr dna (Just[])
    where
        dna nucleotide rnaSeq = (:) <$> toRNA' nucleotide <*> rnaSeq

        toRNA' 'G' = Just 'C'
        toRNA' 'C' = Just 'G'
        toRNA' 'T' = Just 'A'
        toRNA' 'A' = Just 'U'
        toRNA'  _  = Nothing

--
-- This iteration is a lot more succinct.  It does not use `fromJust`
-- and `Just` (explicitly) to do things to stuff inside `Maybe`s.
--
-- This is not just the discovery of apprporiate syntax or library functions to
-- do the job.  This uses functions from the 'applicative' typeclass.  It seems
-- you need this:  'functors' are not sufficient and 'monoids' more than.
--
-- The even neater solutions that use `traverse` and `mapM` are, in a loose
-- sense, the `applicative` and `monoid` equivalents of `foldr`.
--
-- The use of `foldr` means this is memory greedy.  I suspect `traverse` and
-- `mapM` need not be but lazy evaluation means they probably are.
--
