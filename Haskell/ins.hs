import System.IO
import Data.Array.IO
import Control.Monad

-- Insertion sort with correct swap counting
insertionSort :: [Int] -> IO Int
insertionSort xs = do
    arr <- newListArray (0, length xs - 1) xs :: IO (IOArray Int Int)
    swaps <- insertionSortHelper arr (length xs)
    return swaps

insertionSortHelper :: IOArray Int Int -> Int -> IO Int
insertionSortHelper arr n = do
    swaps <- forM [1..(n-1)] $ \i -> do
        key <- readArray arr i
        insertElement arr key i
    return (sum swaps)

insertElement :: IOArray Int Int -> Int -> Int -> IO Int
insertElement arr key i = do
    let go j swaps = do
            if j >= 0
                then do
                    current <- readArray arr j
                    if current > key
                        then do
                            writeArray arr (j+1) current
                            go (j-1) (swaps+1)
                        else return (j+1, swaps)
                else return (0, swaps)
    (pos, swaps) <- go (i-1) 0
    writeArray arr pos key
    return swaps

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_ins.txt"
    let (_:arrayStr:_) = lines contents  -- Skip the first line
    let array = map read $ words arrayStr :: [Int]
    swaps <- insertionSort array
    writeFile "output.txt" (show swaps)
    putStrLn $ "Number of swaps: " ++ show swaps
    putStrLn "Result has been written to output.txt"