import System.IO
import Data.Array.IO
import Control.Monad

-- 3-way partition procedure
partition3Way :: IOArray Int Int -> Int -> Int -> IO ()
partition3Way arr low high = do
    pivot <- readArray arr low
    let 
        loop lt i gt
            | i > gt = return ()
            | otherwise = do
                vi <- readArray arr i
                if vi < pivot
                    then do
                        swap arr lt i
                        loop (lt+1) (i+1) gt
                    else if vi > pivot
                        then do
                            swap arr i gt
                            loop lt i (gt-1)
                        else
                            loop lt (i+1) gt
    loop low (low+1) high

-- Swap two elements in an array
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
    contents <- readFile "rosalind_par3.txt"
    let (_:arrayStr:_) = lines contents
    let inputArray = readInts arrayStr
    let n = length inputArray
    
    arr <- newListArray (1, n) inputArray :: IO (IOArray Int Int)
    partition3Way arr 1 n
    
    result <- getElems arr
    let outputStr = unwords $ map show result
    writeFile "output.txt" outputStr
    putStrLn "3-way partitioned array:"
    putStrLn outputStr
    putStrLn "Result has been written to output.txt"