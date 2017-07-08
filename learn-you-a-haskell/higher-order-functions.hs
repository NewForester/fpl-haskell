--
-- The code examples from the Higher Order Functions section of the Learn You A Haskell tutorial.
-- Copyright (C) 2017 NewForester
-- Available under MIT Licence terms
--

--

multiplyThreeNumbers :: (Num a) => a -> a -> a -> a
multiplyThreeNumbers x y z = x * y * z

--

compareWithOneHundred :: (Num a, Ord a) => a -> Ordering
compareWithOneHundred x = compare x 100

--

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

--

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

--

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x

flip'' :: (a -> b -> c) -> (b -> a -> c)
flip'' f y x = f x y

flip''' :: (a -> b -> c) -> b -> a -> c
flip''' f = \x y -> f y x

--

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map f xs

--

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs)
    | p x           = x : filter' p xs
    | otherwise     = filter' p xs

--

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort (filter (<=x) xs) ++ [x] ++ quicksort (filter (>x) xs)

--

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
    | even n    = n : chain (div n 2)
    | odd n     = n : chain (n * 3 + 1)

--

addThree :: (Num a) => a -> a -> a -> a
addThree x y z = x + y + z

addThree' :: (Num a) => a -> a -> a -> a
addThree' = \x -> \y -> \z -> x + y + z

-- Only folds and horses

sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

sum'' :: (Num a) => [a] -> a
sum'' = foldl1 (+)

map'' :: (a -> b) -> [a] -> [b]
map'' f xs = foldr (\x acc -> f x : acc) [] xs

maximum' :: (Ord a) => [a] -> a
maximum' = foldr1 (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x : acc) []

product' :: (Num a) => [a] -> a
product' = foldr1 (*)

filter'' :: (a -> Bool) -> [a] -> [a]
filter'' p = foldr  (\x acc -> if p x then x : acc else acc) []

head' :: [a] -> a
head' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\_ x -> x)

reverse'' :: [a] -> [a]
reverse'' = foldl (flip (:)) []


-- EOF
