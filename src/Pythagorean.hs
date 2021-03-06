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
pow2' a c = c $ pow2 a

add' :: Float -> Float -> (Float -> a) -> a
add' a b c = c $ add a b

sqrt' :: Float -> (Float -> a) -> a
sqrt' a c = c $ sqrt a

pyth' :: Float -> Float -> (Float -> a) -> a
pyth' a b c = 
  pow2' a (
    \aa -> pow2' b (
      \bb -> add' aa bb (
        \aabb -> sqrt' aabb c
      )
    )
  )

calcPyth a b = pyth' a b id

-- Cont 

pow2_m :: Float -> Cont a Float
pow2_m a = return $ pow2 a

add_m :: Float -> Float -> Cont a Float
add_m a b = return $ add a b

sqrt_m :: Float -> Cont a Float
sqrt_m a = return $ sqrt a

pyth_m :: Float -> Float -> Cont a Float
pyth_m a b =
  do
    aa <- pow2_m a
    bb <- pow2_m b
    aabb <- return $ aa + bb
    return $ sqrt aabb 

-- constructing Cont with cont function

someFun :: (Float -> r) -> r
someFun c = c $ sqrt 3

someResult :: Float
someResult = someFun id

someCont :: Cont a Float
someCont = cont someFun

someCont' :: Cont a Float
someCont' = return $ sqrt 3

someResult' :: Float
someResult' = runCont someCont id
