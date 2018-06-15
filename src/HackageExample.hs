module HackageExample where 

import Control.Monad.Cont


calculateLength :: [a] -> Cont r Int
calculateLength l = return $ length l

double :: Int -> Cont r Int
double n = return $ 2 * n


hackageExampleMain :: IO ()
hackageExampleMain =
  do
    runCont (calculateLength "123" >>= double) print


