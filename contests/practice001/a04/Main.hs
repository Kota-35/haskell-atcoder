module Main where

import Data.Char (intToDigit)
import Numeric (showIntAtBase)

main :: IO ()
main = do
    n <- readLn :: IO Int

    let bin = showIntAtBase 2 intToDigit n ""
        ans = replicate (10 - length bin) '0' ++ bin

    putStrLn ans
