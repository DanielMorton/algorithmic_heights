import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

void main()
{
    // Read input from file
    auto file = File("rosalind_deg.txt", "r");

    // Read n (number of vertices) and m (number of edges)
    auto firstLine = file.readln().strip().split().map!(to!int).array;
    int n = firstLine[0];
    int m = firstLine[1];

    // Initialize degree array
    int[] degrees = new int[n];

    // Read edges and calculate degrees
    foreach (_; 0..m)
    {
        auto edge = file.readln().strip().split().map!(to!int).array;
        int u = edge[0] - 1;  // Subtract 1 because vertex numbering starts from 1
        int v = edge[1] - 1;
        
        degrees[u]++;
        degrees[v]++;
    }

    // Output the degrees
    writeln(degrees.map!(d => d.to!string).join(" "));
}