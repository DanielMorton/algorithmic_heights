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

int countConnectedComponents(int[][] graph)
{
    int n = cast(int)graph.length;
    bool[] visited = new bool[n];
    int components = 0;

    for (int i = 0; i < n; i++)
    {
        if (!visited[i])
        {
            dfs(i, graph, visited);
            components++;
        }
    }

    return components;
}

void main()
{
    // Read input from file
    auto file = File("rosalind_cc.txt", "r");

    // Read n (number of vertices) and m (number of edges)
    auto firstLine = file.readln().strip().split().map!(to!int).array;
    int n = firstLine[0];
    int m = firstLine[1];

    // Initialize adjacency list
    int[][] graph = new int[][](n);

    // Read edges and build adjacency list
    foreach (_; 0..m)
    {
        auto edge = file.readln().strip().split().map!(to!int).array;
        int u = edge[0] - 1;  // Subtract 1 because vertex numbering starts from 1
        int v = edge[1] - 1;
        
        graph[u] ~= v;
        graph[v] ~= u;
    }

    // Count connected components
    int components = countConnectedComponents(graph);

    // Output the result
    writeln(components);
}