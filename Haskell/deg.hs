import System.IO
import qualified Data.Map.Strict as Map
import Data.List (intercalate)

-- Function to update the degree map with an edge
updateDegrees :: Map.Map Int Int -> (Int, Int) -> Map.Map Int Int
updateDegrees degMap (u, v) = 
    let degMap' = Map.insertWith (+) u 1 degMap
    in  Map.insertWith (+) v 1 degMap'

-- Function to read an edge from a string
readEdge :: String -> (Int, Int)
readEdge s = let [u, v] = map read $ words s in (u, v)

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_deg.txt"
    let (firstLine:edgeLines) = lines contents
    let [n, _] = map read $ words firstLine
    
    -- Process edges and build degree map
    let edges = map readEdge edgeLines
    let degreeMap = foldl updateDegrees (Map.fromList [(v, 0) | v <- [1..n]]) edges
    
    -- Extract degrees in order
    let degrees = [degreeMap Map.! v | v <- [1..n]]
    
    -- Prepare output
    let outputStr = intercalate " " $ map show degrees
    writeFile "output.txt" outputStr
    putStrLn "Vertex degrees:"
    putStrLn outputStr
    putStrLn "Result has been written to output.txt"