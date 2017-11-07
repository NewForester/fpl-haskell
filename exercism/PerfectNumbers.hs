module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify nn
    | nn < 1    = Nothing
    | otherwise = case compare nn aliquot_sum of
        LT -> Just Abundant
        GT -> Just Deficient
        EQ -> Just Perfect
    where
        aliquot_sum =
            sum [x + div nn x | x <- [2 .. bound], mod nn x == 0] + correction
        bound = floor $ sqrt $ fromIntegral $ nn
        correction
            | bound * bound == nn   = 1 - bound
            | otherwise             = 1

--
-- Much neater, liked by teehemkay
--
