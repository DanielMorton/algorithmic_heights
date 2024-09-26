import System.IO

-- Merge Sort function
mergeSort :: [Int] -> [Int]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort left) (mergeSort right)
  where
    (left, right) = splitAt (length xs `div` 2) xs

-- Merge function
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
    contents <- readFile "rosalind_qs.txt"
    let (_:arrayStr:_) = lines contents
    let inputArray = readInts arrayStr
    
    let sortedArray = mergeSort inputArray
    let outputStr = unwords $ map show sortedArray
    
    writeFile "output.txt" outputStr
    putStrLn "Sorted array:"
    putStrLn outputStr
    putStrLn "Result has been written to output.txt"