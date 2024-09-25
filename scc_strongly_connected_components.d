import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;
import std.container;

void dfs(int v, int[][] graph, bool[] visited, ref SList!int stack)
{
    visited[v] = true;

    foreach (neighbor; graph[v])
    {
        if (!visited[neighbor])
        {
            dfs(neighbor, graph, visited, stack);
        }
    }

    stack.insertFront(v);
}

void dfsTransposed(int v, int[][] transposedGraph, bool[] visited)
{
    visited[v] = true;

    foreach (neighbor; transposedGraph[v])
    {
        if (!visited[neighbor])
        {
            dfsTransposed(neighbor, transposedGraph, visited);
        }
    }
}

int countSCC(int[][] graph, int n)
{
    bool[] visited = new bool[n];
    auto stack = SList!int();

    // First DFS to fill the stack
    for (int i = 0; i < n; i++)
    {
        if (!visited[i])
        {
            dfs(i, graph, visited, stack);
        }
    }

    // Create transposed graph
    int[][] transposedGraph = new int[][](n);
    for (int i = 0; i < n; i++)
    {
        foreach (neighbor; graph[i])
        {
            transposedGraph[neighbor] ~= i;
        }
    }

    // Reset visited array
    visited[] = false;

    // Second DFS on transposed graph
    int sccCount = 0;
    foreach (v; stack)
    {
        if (!visited[v])
        {
            dfsTransposed(v, transposedGraph, visited);
            sccCount++;
        }
    }

    return sccCount;
}

void main()
{
    // Open the input file
    auto file = File("rosalind_scc.txt", "r");

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
    }

    // Count strongly connected components
    int sccCount = countSCC(graph, n);

    // Output the result
    writeln(sccCount);
}