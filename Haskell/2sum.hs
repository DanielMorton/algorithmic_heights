import System.IO
import qualified Data.IntMap.Strict as Map

-- Function to find two elements that sum to zero
findTwoSum :: [Int] -> Maybe (Int, Int)
findTwoSum xs = go xs Map.empty 1
  where
    go [] _ _ = Nothing
    go (x:xs) seen i =
      case Map.lookup (-x) seen of
        Just j -> if j /= i then Just (min j i, max j i) else go xs (Map.insert x i seen) (i + 1)
        Nothing -> go xs (Map.insert x i seen) (i + 1)

-- Function to read integers from a string
readInts :: String -> [Int]
readInts = map read . words

-- Function to format output
formatOutput :: Maybe (Int, Int) -> String
formatOutput Nothing = "-1"
formatOutput (Just (i, j)) = show i ++ " " ++ show j

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_2sum.txt"
    let (firstLine:arrays) = lines contents
    let [k, _] = map read $ words firstLine  -- Read k and n, but we only need k
    let results = map (formatOutput . findTwoSum . readInts) (take k arrays)
    writeFile "output.txt" (unlines results)
    putStrLn "Results:"
    mapM_ putStrLn results
    putStrLn "Results have been written to output.txt"