import System.IO
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import Data.List (foldl')

-- Function to update the graph with an edge
updateGraph :: Map.Map Int [Int] -> (Int, Int) -> Map.Map Int [Int]
updateGraph graph (u, v) = 
    let graph' = Map.insertWith (++) u [v] graph
    in  Map.insertWith (++) v [u] graph'

-- Function to read an edge from a string
readEdge :: String -> (Int, Int)
readEdge s = let [u, v] = map read $ words s in (u, v)

-- Depth-First Search
dfs :: Map.Map Int [Int] -> Set.Set Int -> Int -> Set.Set Int
dfs graph visited start =
    let neighbors = Map.findWithDefault [] start graph
        unvisitedNeighbors = filter (not . (`Set.member` visited)) neighbors
        visited' = Set.insert start visited
    in foldl' (dfs graph) visited' unvisitedNeighbors

-- Count Connected Components
countComponents :: Map.Map Int [Int] -> Int -> Int
countComponents graph n =
    let vertices = [1..n]
        (_, count) = foldl' (\(visited, count) v -> 
                        if Set.member v visited
                            then (visited, count)
                            else (dfs graph visited v, count + 1))
                     (Set.empty, 0) vertices
    in count

-- Main function
main :: IO ()
main = do
    contents <- readFile "rosalind_cc.txt"
    let (firstLine:edgeLines) = lines contents
    let [n, _] = map read $ words firstLine
    
    -- Process edges and build graph
    let edges = map readEdge edgeLines
    let graph = foldl' updateGraph Map.empty edges
    
    -- Count connected components
    let componentCount = countComponents graph n
    
    -- Prepare output
    let outputStr = show componentCount
    writeFile "output.txt" outputStr
    putStrLn $ "Number of connected components: " ++ outputStr
    putStrLn "Result has been written to output.txt"