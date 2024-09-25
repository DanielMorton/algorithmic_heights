import System.IO

-- Merge Sort function
mergeSort :: [Int] -> [Int]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort left) (mergeSort right)
  where
    (left, right) = splitAt (length xs `div` 2) xs

-- Merge function to combine two sorted lists
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
    contents <- readFile "rosalind_ms.txt"
    let (_:arrayStr:_) = lines contents  -- Skip the first line
    let array = readInts arrayStr
    let sortedArray = mergeSort array
    writeFile "output.txt" (unwords $ map show sortedArray)
    putStrLn "Sorted array:"
    putStrLn $ unwords $ map show sortedArray
    putStrLn "Result has been written to output.txt"