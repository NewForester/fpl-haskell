module DNA (toRNA) where

toRNA :: String -> Maybe String
toRNA rna =
    check [toRNA' c | c <- rna]
    where
        check dna
            | elem 'X' dna = Nothing
            | otherwise    = Just dna

        toRNA' 'G' = 'C'
        toRNA' 'C' = 'G'
        toRNA' 'T' = 'A'
        toRNA' 'A' = 'U'
        toRNA'  _  = 'X' -- error "Invalid DNA nucleotide symbol."

--
-- Confusing name
--
-- Now, read carefully  ...
--
-- In an imperative language, you'd have a loop with two steps inside
-- (validate and convert nucleotide) and a stop on error.
--
-- A simple minded approach in a functional language involves two
-- passes of the list:  validate string and convert string.  Oops.
-- Even my use of 'elem' is, in effect, a second pass.
--
-- The use of the Maybe class appears to be an additional hindrance
-- but, in fact, it allows the two passes of the list to be combined
-- but only if you use the 'monad' mapM or the 'applicative' traverse.
--
-- What these achieve is something that like
--
--     "when Nothing meet Just list the result is Nothing"
--
-- I don't understand mapM or traverse but I should be able to use
-- Maybe with fold to do this.
--
