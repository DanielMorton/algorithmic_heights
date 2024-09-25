import System.IO
import Data.Array.IO
import Control.Monad

-- Efficient partition procedure
partition :: IOArray Int Int -> Int -> Int -> IO ()
partition arr low high = do
    pivot <- readArray arr low
    let 
        loop i j
            | i >= j = do
                writeArray arr low =<< readArray arr j
                writeArray arr j pivot
            | otherwise = do
                vi <- readArray arr i
                vj <- readArray arr j
                if vi <= pivot
                    then loop (i+1) j
                    else if vj > pivot
                        then loop i (j-1)
                        else do
                            writeArray arr i vj
                            writeArray arr j vi
                            loop (i+1) (j-1)
    loop (low+1) high

-- Function to read integers from a string
readInts :: String -> [Int]
readInts = map read . words

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_par.txt"
    let (_:arrayStr:_) = lines contents
    let inputArray = readInts arrayStr
    let n = length inputArray
    
    arr <- newListArray (1, n) inputArray :: IO (IOArray Int Int)
    partition arr 1 n
    
    result <- getElems arr
    let outputStr = unwords $ map show result
    writeFile "output.txt" outputStr
    putStrLn "Partitioned array:"
    putStrLn outputStr
    putStrLn "Result has been written to output.txt"