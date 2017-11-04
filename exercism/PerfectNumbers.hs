module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify nn
    | nn < 1    = Nothing
    | nn == 1   = Just Deficient
    | otherwise = Just $ dandy nn $ aliquot_sum nn
    where
        dandy nn nn'
            | nn < nn'  = Abundant
            | nn > nn'  = Deficient
            | otherwise = Perfect
        bound = floor $ sqrt $ fromIntegral $ nn
        aliquot_sum nn =
            sum [x + div nn x | x <- [2 .. bound], mod nn x == 0] + correction
            where
                correction
                    | bound * bound == nn   = 1 - bound
                    | otherwise             = 1

--
-- It looks as if there are only 10 other solutions worldwide.
-- Only one other used sqrt but one used some really advanced library function.
--
-- Two used compare, which I like so much I will rewrite this.
--
-- I have used nn in correction without passing it down.
-- For consistencies sake, I should not pass nn down to dandy and aliquot sum.
--
