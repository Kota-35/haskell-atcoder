module Main where

import Data.Char (isSpace)

main :: IO ()
main = do
  input <- getContents
  putStrLn (trimEnd input)

trimEnd :: String -> String
trimEnd = reverse . dropWhile isSpace . reverse
