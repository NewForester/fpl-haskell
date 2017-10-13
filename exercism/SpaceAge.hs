module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

ageOn :: Planet -> Float -> Float
ageOn planet seconds =
    let period = case planet of
         Earth   -> 1.0
         Mercury -> 0.2408467
         Venus   -> 0.61519726
         Mars    -> 1.8808158
         Jupiter -> 11.862615
         Saturn  -> 29.447498
         Uranus  -> 84.016846
         Neptune -> 164.79132
         planetoid -> error "Not a planet of this solar system"
    in seconds / 31557600 / period

-- ^
-- No need for an external routine:  use let with a case ... of.
-- However, I particuarly like this implementation's use of the 'where' clause.

ageOn' :: Planet -> Float -> Float
ageOn' planet seconds = convert planet
    where convert Earth   = seconds / 31557600
          convert Mercury = convert Earth / 0.2408467
          convert Venus   = convert Earth / 0.61519726
          convert Mars    = convert Earth / 1.8808158
          convert Jupiter = convert Earth / 11.862615
          convert Saturn  = convert Earth / 29.447498
          convert Uranus  = convert Earth / 84.016846
          convert Neptune = convert Earth / 164.79132
