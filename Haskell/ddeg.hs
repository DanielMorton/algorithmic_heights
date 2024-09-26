import System.IO
import qualified Data.Map.Strict as Map
import Data.List (intercalate)

-- Function to update the graph and degree map with an edge
updateGraphAndDegrees :: (Map.Map Int [Int], Map.Map Int Int) -> (Int, Int) -> (Map.Map Int [Int], Map.Map Int Int)
updateGraphAndDegrees (graph, degMap) (u, v) = 
    let graph' = Map.insertWith (++) u [v] $ Map.insertWith (++) v [u] graph
        degMap' = Map.insertWith (+) u 1 $ Map.insertWith (+) v 1 degMap
    in (graph', degMap')

-- Function to read an edge from a string
readEdge :: String -> (Int, Int)
readEdge s = let [u, v] = map read $ words s in (u, v)

-- Function to calculate sum of neighbor degrees
sumNeighborDegrees :: Map.Map Int [Int] -> Map.Map Int Int -> Int -> Int
sumNeighborDegrees graph degMap v =
    case Map.lookup v graph of
        Just neighbors -> sum [degMap Map.! n | n <- neighbors]
        Nothing -> 0

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_ddeg.txt"
    let (firstLine:edgeLines) = lines contents
    let [n, _] = map read $ words firstLine
    
    -- Process edges and build graph and degree map
    let edges = map readEdge edgeLines
    let (graph, degreeMap) = foldl updateGraphAndDegrees (Map.empty, Map.fromList [(v, 0) | v <- [1..n]]) edges
    
    -- Calculate sum of neighbor degrees
    let neighborDegSums = [sumNeighborDegrees graph degreeMap v | v <- [1..n]]
    
    -- Prepare output
    let outputStr = intercalate " " $ map show neighborDegSums
    writeFile "output.txt" outputStr
    putStrLn "Sum of neighbor degrees for each vertex:"
    putStrLn outputStr
    putStrLn "Result has been written to output.txt"