import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

enum Color { WHITE, GRAY, BLACK }

bool hasCycle(int[][] graph, int v, Color[] colors)
{
    colors[v] = Color.GRAY;

    foreach (neighbor; graph[v])
    {
        if (colors[neighbor] == Color.GRAY)
            return true;
        if (colors[neighbor] == Color.WHITE && hasCycle(graph, neighbor, colors))
            return true;
    }

    colors[v] = Color.BLACK;
    return false;
}

bool isAcyclic(int[][] graph)
{
    int n = cast(int)graph.length;
    Color[] colors = new Color[n];

    for (int i = 0; i < n; i++)
    {
        if (colors[i] == Color.WHITE && hasCycle(graph, i, colors))
            return false;
    }

    return true;
}

void main()
{
    // Read input from file
    auto file = File("rosalind_dag.txt", "r");

    // Read k (number of graphs)
    int k = file.readln().strip().to!int;

    // Process each graph
    foreach (graph_index; 0..k)
    {
        // Read empty line
        file.readln();

        // Read n (number of vertices) and m (number of edges)
        auto line = file.readln().strip().split().map!(to!int).array;
        int n = line[0];
        int m = line[1];

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

        // Check if the graph is acyclic
        writeln(isAcyclic(graph) ? 1 : -1);
    }
}