import System.IO
import Data.List (sortOn, sort)
import Data.Ord (comparing)

-- Function to find three elements that sum to zero
findThreeSum :: [Int] -> Maybe (Int, Int, Int)
findThreeSum xs =
    let indexed = zip [1..] xs
        sorted = sortOn snd indexed
    in go sorted
  where
    go ((i,x):rest) =
        case twoSum (-x) rest of
            Just (j, k) -> Just (i, j, k)
            Nothing -> go rest
    go [] = Nothing

-- Two-pointer approach to find two elements that sum to target
twoSum :: Int -> [(Int, Int)] -> Maybe (Int, Int)
twoSum target xs = go xs (reverse xs)
  where
    go ((i,x):xs) ((j,y):ys)
        | i == j = Nothing
        | x + y == target = Just (i, j)
        | x + y < target = go xs ((j,y):ys)
        | otherwise = go ((i,x):xs) ys
    go _ _ = Nothing

-- Function to read integers from a string
readInts :: String -> [Int]
readInts = map read . words

-- Function to format output
formatOutput :: Maybe (Int, Int, Int) -> String
formatOutput Nothing = "-1"
formatOutput (Just (i, j, k)) = unwords $ map show $ sort [i, j, k]

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_3sum.txt"
    let (firstLine:arrays) = lines contents
    let [k, _] = map read $ words firstLine  -- Read k and n, but we only need k
    let results = map (formatOutput . findThreeSum . readInts) (take k arrays)
    writeFile "output.txt" (unlines results)
    putStrLn "Results:"
    mapM_ putStrLn results
    putStrLn "Results have been written to output.txt"