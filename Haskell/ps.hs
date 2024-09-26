import System.IO
import Data.Array.IO
import Control.Monad

-- QuickSelect algorithm to find k smallest elements
quickSelect :: IOArray Int Int -> Int -> Int -> Int -> IO ()
quickSelect arr low high k = do
    if low < high
        then do
            p <- partition arr low high
            let leftSize = p - low + 1
            if k < leftSize
                then quickSelect arr low (p-1) k
                else if k > leftSize
                    then quickSelect arr (p+1) high (k-leftSize)
                    else return ()
        else return ()

-- Partition function
partition :: IOArray Int Int -> Int -> Int -> IO Int
partition arr low high = do
    pivot <- readArray arr high
    let 
        loop i j
            | j == high = do
                swap arr (i+1) high
                return (i+1)
            | otherwise = do
                val <- readArray arr j
                if val <= pivot
                    then do
                        swap arr (i+1) j
                        loop (i+1) (j+1)
                    else loop i (j+1)
    loop (low-1) low

-- Swap two elements in the array
swap :: IOArray Int Int -> Int -> Int -> IO ()
swap arr i j = do
    vi <- readArray arr i
    vj <- readArray arr j
    writeArray arr i vj
    writeArray arr j vi

-- Function to read integers from a string
readInts :: String -> [Int]
readInts = map read . words

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_ps.txt"
    let (nStr:arrayStr:kStr:_) = lines contents
    let inputArray = readInts arrayStr
    let n = length inputArray
    let k = read kStr

    arr <- newListArray (1, n) inputArray :: IO (IOArray Int Int)
    quickSelect arr 1 n k
    
    result <- mapM (readArray arr) [1..k]
    let outputStr = unwords $ map show $ sort result
    writeFile "output.txt" outputStr
    putStrLn $ "The " ++ show k ++ " smallest elements:"
    putStrLn outputStr
    putStrLn "Result has been written to output.txt"

-- Simple sort function for the final k elements
sort :: [Int] -> [Int]
sort [] = []
sort (x:xs) = sort [a | a <- xs, a < x] ++ [x] ++ sort [a | a <- xs, a >= x]