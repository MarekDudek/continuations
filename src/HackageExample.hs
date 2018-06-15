module HackageExample where 

import Control.Monad.Cont

-- simple usage

calculateLength :: [a] -> Cont r Int
calculateLength l = return $ length l

double :: Int -> Cont r Int
double n = return $ 2 * n


hackageExampleMain :: IO ()
hackageExampleMain =
  do
    runCont (calculateLength "123" >>= double) print


-- using callCC example

whatsYourName :: String -> String
whatsYourName name = 
  (`runCont` id ) $ do
    response <- callCC $ \exit -> do
      validateName name exit
      return $ "Welcome, " ++ name ++ "!"
    return response

validateName name exit = 
  do
    when (null name) (exit "You forgot to tell me your name!")
