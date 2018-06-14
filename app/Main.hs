module Main where

import Control.Monad.Cont

import Pythagorean

main :: IO ()
main = 
  demoPythCont

demoPyth = 
  do
    let a = 3
        b = 4
    putStr $ "Pythagorean " ++ show a ++ " and " ++ show b ++ " is "
    print $ calcPyth a b

demoPythCont =
  do
    let a = 3
        b = 4
        c = pyth_m a b
        r = runCont c id
    putStrLn $ "Pythagorean of " ++ show a ++ " and " ++ show b ++ " is " ++ show r
