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

int[] topologicalSort(int[][] graph)
{
    int n = cast(int)graph.length;
    bool[] visited = new bool[n];
    auto stack = SList!int();

    for (int i = 0; i < n; i++)
    {
        if (!visited[i])
        {
            dfs(i, graph, visited, stack);
        }
    }

    return stack.array;
}

void main()
{
    // Read input from file
    auto file = File("rosalind_ts.txt", "r");

    // Read n (number of vertices) and m (number of edges)
    auto firstLine = file.readln().strip().split().map!(to!int).array;
    int n = firstLine[0];
    int m = firstLine[1];

    // Initialize adjacency list
    int[][] graph = new int[][](n);

    // Read edges and build adjacency list
    foreach (edge_index; 0..m)
    {
        auto edge = file.readln().strip().split().map!(to!int).array;
        int u = edge[0] - 1;  // Subtract 1 because vertex numbering starts from 1
        int v = edge[1] - 1;
        
        graph[u] ~= v;
    }

    // Perform topological sorting
    int[] sortedVertices = topologicalSort(graph);

    // Output the result (add 1 to convert back to 1-based indexing)
    writeln(sortedVertices.map!(v => (v + 1).to!string).join(" "));
}