import System.IO
import Data.Array.IO
import Control.Monad

-- Function to bubble up an element in the heap
bubbleUp :: IOArray Int Int -> Int -> IO ()
bubbleUp arr i = do
    let parent = i `div` 2
    if parent == 0
        then return ()
        else do
            parentVal <- readArray arr parent
            currentVal <- readArray arr i
            if parentVal < currentVal
                then do
                    swapElements arr parent i
                    bubbleUp arr parent
                else return ()

-- Function to swap two elements in the array
swapElements :: IOArray Int Int -> Int -> Int -> IO ()
swapElements arr i j = do
    valI <- readArray arr i
    valJ <- readArray arr j
    writeArray arr i valJ
    writeArray arr j valI

-- Function to build the heap
buildHeap :: IOArray Int Int -> Int -> IO ()
buildHeap arr n = forM_ [1..n] $ \i -> bubbleUp arr i

-- Function to read integers from a string
readInts :: String -> [Int]
readInts = map read . words

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_hea.txt"
    let (_:arrayStr:_) = lines contents
    let inputArray = readInts arrayStr
    let n = length inputArray
    
    arr <- newListArray (1, n) inputArray :: IO (IOArray Int Int)
    buildHeap arr n
    
    result <- getElems arr
    let outputStr = unwords $ map show result
    writeFile "output.txt" outputStr
    putStrLn "Max Heap:"
    putStrLn outputStr
    putStrLn "Result has been written to output.txt"