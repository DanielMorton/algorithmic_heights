import System.IO
import Data.Array.IO
import Control.Monad

-- Function to sift down an element in the heap
siftDown :: IOArray Int Int -> Int -> Int -> IO ()
siftDown arr i n = do
    let left = 2 * i
    let right = 2 * i + 1
    largest <- findLargest arr i left right n
    when (largest /= i) $ do
        swapElements arr i largest
        siftDown arr largest n

-- Function to find the largest among parent and children
findLargest :: IOArray Int Int -> Int -> Int -> Int -> Int -> IO Int
findLargest arr i left right n = do
    rootVal <- readArray arr i
    leftVal <- if left <= n then readArray arr left else return (minBound :: Int)
    rightVal <- if right <= n then readArray arr right else return (minBound :: Int)
    return $ if leftVal > rootVal && leftVal >= rightVal
                then left
                else if rightVal > rootVal && rightVal >= leftVal
                    then right
                    else i

-- Function to swap two elements in the array
swapElements :: IOArray Int Int -> Int -> Int -> IO ()
swapElements arr i j = do
    valI <- readArray arr i
    valJ <- readArray arr j
    writeArray arr i valJ
    writeArray arr j valI

-- Function to build the max heap
buildMaxHeap :: IOArray Int Int -> Int -> IO ()
buildMaxHeap arr n = 
    forM_ [n `div` 2, n `div` 2 - 1 .. 1] $ \i ->
        siftDown arr i n

-- Heap Sort function
heapSort :: IOArray Int Int -> Int -> IO ()
heapSort arr n = do
    buildMaxHeap arr n
    forM_ [n, n-1 .. 2] $ \i -> do
        swapElements arr 1 i
        siftDown arr 1 (i-1)

-- Function to read integers from a string
readInts :: String -> [Int]
readInts = map read . words

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_hs.txt"
    let (_:arrayStr:_) = lines contents
    let inputArray = readInts arrayStr
    let n = length inputArray
    
    arr <- newListArray (1, n) inputArray :: IO (IOArray Int Int)
    heapSort arr n
    
    result <- getElems arr
    let outputStr = unwords $ map show result
    writeFile "output.txt" outputStr
    putStrLn "Sorted array:"
    putStrLn outputStr
    putStrLn "Result has been written to output.txt"