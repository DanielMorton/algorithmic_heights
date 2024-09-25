import System.IO

-- Modified Merge Sort function to count inversions
countInversions :: [Int] -> (Int, [Int])
countInversions [] = (0, [])
countInversions [x] = (0, [x])
countInversions xs = 
    let (leftInv, sortedLeft) = countInversions left
        (rightInv, sortedRight) = countInversions right
        (mergeInv, sortedXs) = mergeAndCount sortedLeft sortedRight
    in (leftInv + rightInv + mergeInv, sortedXs)
  where
    (left, right) = splitAt (length xs `div` 2) xs

-- Merge function that also counts inversions
mergeAndCount :: [Int] -> [Int] -> (Int, [Int])
mergeAndCount [] ys = (0, ys)
mergeAndCount xs [] = (0, xs)
mergeAndCount (x:xs) (y:ys)
  | x <= y    = let (inv, merged) = mergeAndCount xs (y:ys) in (inv, x:merged)
  | otherwise = let (inv, merged) = mergeAndCount (x:xs) ys in (inv + length (x:xs), y:merged)

-- Function to read integers from a string
readInts :: String -> [Int]
readInts = map read . words

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_inv.txt"
    let (_:arrayStr:_) = lines contents  -- Skip the first line
    let array = readInts arrayStr
    let (inversions, _) = countInversions array
    writeFile "output.txt" (show inversions)
    putStrLn $ "Number of inversions: " ++ show inversions
    putStrLn "Result has been written to output.txt"