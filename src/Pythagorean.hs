module Pythagorean where

import Control.Monad.Cont

-- traditional 

pow2 :: Float -> Float
pow2 a = a ** 2

add :: Float -> Float -> Float
add a b = a + b

pyth :: Float -> Float -> Float
pyth a b = sqrt (add (pow2 a) (pow2 b))

-- CPS

pow2' :: Float -> (Float -> a) -> a
pow2' a cont = cont $ pow2 a

add' :: Float -> Float -> (Float -> a) -> a
add' a b cont = cont $ add a b

sqrt' :: Float -> (Float -> a) -> a
sqrt' a cont = cont $ sqrt a

pyth' :: Float -> Float -> (Float -> a) -> a
pyth' a b cont = 
  pow2' a (
    \aa -> pow2' b (
      \bb -> add' aa bb (
        \aabb -> sqrt' aabb cont
      )
    )
  )

calcPyth a b = pyth' a b id

-- Cont 

pow2_m :: Float -> Cont a Float
pow2_m a = return $ pow2 a

pyth_m :: Float -> Float -> Cont a Float
pyth_m a b =
  do
    aa <- pow2_m a
    bb <- pow2_m b
    aabb <- cont (add' aa bb)
    r <- cont (sqrt' aabb)
    return r
