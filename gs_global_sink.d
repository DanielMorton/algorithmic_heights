import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

void dfs(int v, int[][] graph, bool[] visited)
{
    visited[v] = true;
    foreach (neighbor; graph[v])
    {
        if (!visited[neighbor])
        {
            dfs(neighbor, graph, visited);
        }
    }
}

int findReachableVertex(int[][] graph)
{
    int n = cast(int)graph.length;
    
    foreach (start; 0..n)
    {
        bool[] visited = new bool[n];
        dfs(start, graph, visited);
        
        if (visited.all!(v => v))
        {
            return start + 1;  // Convert back to 1-based indexing
        }
    }
    
    return -1;  // No vertex can reach all others
}

void processGraph(File file)
{
    // Read n (number of vertices) and m (number of edges)
    auto line = file.readln().strip().split().map!(to!int).array;
    int n = line[0];
    int m = line[1];

    // Initialize adjacency list
    int[][] graph = new int[][](n);

    // Read edges and build adjacency list
    foreach (_; 0..m)
    {
        auto edge = file.readln().strip().split().map!(to!int).array;
        int u = edge[0] - 1;  // Subtract 1 because vertex numbering starts from 1
        int v = edge[1] - 1;
        
        graph[u] ~= v;
    }

    // Find a vertex that can reach all others
    int result = findReachableVertex(graph);

    // Output the result
    writeln(result);
}

void main()
{
    // Open the input file
    auto file = File("rosalind_gs.txt", "r");

    // Read k (number of graphs)
    int k = file.readln().strip().to!int;

    // Process each graph
    foreach (_; 0..k)
    {
        // Read empty line between graphs
        file.readln();
        
        processGraph(file);
    }
}