import System.IO

-- Function to merge two sorted lists
merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x <= y    = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

-- Function to read integers from a string
readInts :: String -> [Int]
readInts = map read . words

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_mer.txt"
    let [n, arrA, m, arrB] = lines contents
    let listA = readInts arrA
    let listB = readInts arrB
    let merged = merge listA listB
    writeFile "output.txt" (unwords $ map show merged)
    putStrLn "Merged array:"
    putStrLn $ unwords $ map show merged
    putStrLn "Result has been written to output.txt"