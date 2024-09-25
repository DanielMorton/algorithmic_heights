import System.IO
import Data.List (intercalate)

-- Binary search function
binarySearch :: [Int] -> Int -> Int -> Int -> Int
binarySearch arr target low high
    | high < low = -1
    | otherwise = 
        let mid = (low + high) `div` 2
        in case compare target (arr !! mid) of
            EQ -> mid + 1  -- Adding 1 because the problem uses 1-based indexing
            LT -> binarySearch arr target low (mid - 1)
            GT -> binarySearch arr target (mid + 1) high

-- Main function to read input and process
main :: IO ()
main = do
    contents <- readFile "rosalind_bins.txt"
    let (n:m:arr:keys:_) = lines contents
        n' = read n :: Int
        m' = read m :: Int
        arr' = map read $ words arr :: [Int]
        keys' = map read $ words keys :: [Int]
        results = map (\k -> binarySearch arr' k 0 (n' - 1)) keys'
    
    -- Write results to output file
    writeFile "output.txt" (intercalate " " $ map show results)
    putStrLn "Results have been written to output.txt"