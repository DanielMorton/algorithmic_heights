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

bool isHamiltonianPath(int[] path, int[][] graph)
{
    for (int i = 0; i < path.length - 1; i++)
    {
        if (!graph[path[i]].canFind(path[i+1]))
        {
            return false;
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

    // Perform topological sorting
    int[] sortedVertices = topologicalSort(graph);

    // Check if the topological sort is a Hamiltonian path
    if (isHamiltonianPath(sortedVertices, graph))
    {
        write("1 ");
        writeln(sortedVertices.map!(v => (v + 1).to!string).join(" "));
    }
    else
    {
        writeln("-1");
    }
}

void main()
{
    // Open the input file
    auto file = File("rosalind_hdag.txt", "r");

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