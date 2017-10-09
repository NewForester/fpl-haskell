module LeapYear (isLeapYear) where

isLeapYear :: Integer -> Bool
isLeapYear year
    | mod year 400 == 0 = True
    | mod year 100 == 0 = False
    | mod year 4 == 0   = True
    | otherwise         = False

-- ^
-- Guards but no pattern matching.
-- The 'is divible by' could be dryer - a where clause would be neat.
