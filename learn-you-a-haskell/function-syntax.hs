--
-- The code examples from the Syntax in Functions section of the Learn You A Haskell tutorial.
-- Copyright (C) 2017 NewForester
-- Available under MIT Licence terms
--

--

lucky :: (Integral x) => x -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

--

sayMe :: (Integral x) => x -> String
sayMe 1 = "One !"
sayMe 2 = "Two !"
sayMe 3 = "Three !"
sayMe 4 = "Four !"
sayMe 5 = "Five !"
sayMe x = "Not between 1 and 5"

--

factorial ::  (Integral n) => n -> n
factorial 0 = 1
factorial n = n * factorial (n - 1)

--

addVectors :: (Num x, Num y) => (x,y) -> (x,y) -> (x,y)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

--

first :: (a,b,c) -> a
first (a,_,_) = a

second :: (a,b,c) -> b
second (_,b,_) = b

third :: (a,b,c) -> c
third (_,_,c) = c

--

head' :: [a] -> a
head' [] = error "Cannot call head on an empty list"
head' (x:_) = x

headcase' :: [a] -> a
headcase' xs =
    case xs of
        [] -> error "No head for empty lists!"
        (x:_) -> x

--

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

--

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

---

cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
    let sideArea =  2 * pi * r * h
        topArea = pi * r ^ 2
    in  sideArea + 2 * topArea

-- EOF
