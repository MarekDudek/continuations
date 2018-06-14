module Main where

import Lib
import Pythagorean

main :: IO ()
main = demoPyth


demoPyth = 
  do
    let a = 3
        b = 4
    putStr $ "Pythagorean " ++ show a ++ " and " ++ show b ++ " is "
    pyth' a b print
