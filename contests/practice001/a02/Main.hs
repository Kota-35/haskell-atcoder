module Main where

main :: IO ()
main = do
    [_, x] <- map read . words <$> getLine :: IO [Int]
    as <- map read . words <$> getLine :: IO [Int]

    let result = any (\a -> a == x) as
    putStrLn (if result then "Yes" else "No")
