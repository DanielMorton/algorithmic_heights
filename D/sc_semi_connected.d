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

bool isSemiConnected(int[][] graph)
{
    int n = cast(int)graph.length;
    bool[][] reachable = new bool[][](n, n);

    // Compute transitive closure using DFS
    for (int i = 0; i < n; i++)
    {
        dfs(i, graph, reachable[i]);
    }

    // Check if the graph is semi-connected
    for (int i = 0; i < n; i++)
    {
        for (int j = i + 1; j < n; j++)
        {
            if (!reachable[i][j] && !reachable[j][i])
            {
                return false;
            }
        }
    }

    return true;
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

    // Check if the graph is semi-connected
    bool result = isSemiConnected(graph);

    // Output the result
    writeln(result ? "1" : "-1");
}

void main()
{
    // Open the input file
    auto file = File("rosalind_sc.txt", "r");

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