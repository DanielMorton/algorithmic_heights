import System.IO
import Data.Array.IO
import Control.Monad
import Data.List (sort)

-- QuickSelect algorithm
quickSelect :: IOArray Int Int -> Int -> Int -> Int -> IO Int
quickSelect arr low high k
    | high - low < 10 = do
        subArray <- mapM (readArray arr) [low..high]
        return $ sort subArray !! (k-1)
    | otherwise = do
        let mid = (low + high) `div` 2
        swap arr low mid
        pivot <- readArray arr low
        (p, r) <- partition arr low high pivot
        let leftSize = p - low
        let equalSize = r - p + 1
        if k <= leftSize
            then quickSelect arr low (p-1) k
            else if k > leftSize + equalSize
                then quickSelect arr (r+1) high (k-leftSize-equalSize)
                else return pivot

-- Partition function that handles equal elements
partition :: IOArray Int Int -> Int -> Int -> Int -> IO (Int, Int)
partition arr low high pivot = do
    let 
        loop p q r
            | q > r = return (p, r)
            | otherwise = do
                vq <- readArray arr q
                if vq < pivot
                    then do
                        swap arr p q
                        loop (p+1) (q+1) r
                    else if vq == pivot
                        then loop p (q+1) r
                        else do
                            swap arr q r
                            loop p q (r-1)
    loop low low high

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
    contents <- readFile "rosalind_med.txt"
    let (nStr:arrayStr:kStr:_) = lines contents
    let n = read nStr
    let inputArray = readInts arrayStr
    let k = read kStr
    
    arr <- newListArray (1, n) inputArray :: IO (IOArray Int Int)
    result <- quickSelect arr 1 n k
    
    writeFile "output.txt" (show result)
    putStrLn $ "The " ++ show k ++ "-th smallest element is: " ++ show result
    putStrLn "Result has been written to output.txt"