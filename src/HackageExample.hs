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
  getResultFromCont $ callCC welcomeWithValidation
  where
    welcomeWithValidation :: (String -> Cont r ()) -> Cont r String
    welcomeWithValidation exit = 
      do
        validateName name exit
        return $ "Welcome, " ++ name ++ "!"

getResultFromCont = (`runCont` id) :: Cont r r -> r

validateName :: (Applicative f) => String -> (String -> f ()) -> f ()
validateName name exit = 
  do
    when (null name) (exit "You forgot to tell me your name!")
