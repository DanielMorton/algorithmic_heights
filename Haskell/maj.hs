import System.IO
import Data.List (group, sort)

-- Function to find the majority element in a list
findMajority :: [Int] -> String
findMajority xs =
    let grouped = group $ sort xs
        n = length xs
        majority = filter (\g -> length g > n `div` 2) grouped
    in if null majority
       then "-1"
       else show $ head $ head majority

-- Function to process a single line (array) of input
processLine :: String -> String
processLine = findMajority . map read . words

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_maj.txt"
    let (_:arrays) = lines contents  -- Skip the first line
    let results = map processLine arrays
    writeFile "output.txt" (unlines results)
    putStrLn "Results have been written to output.txt"