import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

void main()
{
    // Read input from file
    auto file = File("rosalind_ddeg.txt", "r");

    // Read n (number of vertices) and m (number of edges)
    auto firstLine = file.readln().strip().split().map!(to!int).array;
    int n = firstLine[0];
    int m = firstLine[1];

    // Initialize degree array and adjacency list
    int[] degrees = new int[n];
    int[][] adjacencyList = new int[][](n);

    // Read edges, calculate degrees, and build adjacency list
    foreach (_; 0..m)
    {
        auto edge = file.readln().strip().split().map!(to!int).array;
        int u = edge[0] - 1;  // Subtract 1 because vertex numbering starts from 1
        int v = edge[1] - 1;
        
        degrees[u]++;
        degrees[v]++;
        adjacencyList[u] ~= v;
        adjacencyList[v] ~= u;
    }

    // Calculate sum of neighbor degrees
    int[] sumNeighborDegrees = new int[n];
    foreach (i; 0..n)
    {
        sumNeighborDegrees[i] = adjacencyList[i].map!(neighbor => degrees[neighbor]).sum;
    }

    // Output the sum of neighbor degrees
    writeln(sumNeighborDegrees.map!(d => d.to!string).join(" "));
}