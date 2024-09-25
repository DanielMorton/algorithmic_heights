import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.math : isInfinity;

struct Edge {
    int from, to, weight;
}

void bellmanFord(Edge[] edges, int[] distances, int n, int start) {
    distances[start] = 0;

    foreach (_; 0..n-1) {
        bool anyChange = false;
        foreach (edge; edges) {
            if (distances[edge.from] != int.max &&
                distances[edge.from] + edge.weight < distances[edge.to]) {
                distances[edge.to] = distances[edge.from] + edge.weight;
                anyChange = true;
            }
        }
        if (!anyChange) break;
    }

    // Check for negative cycles
    foreach (edge; edges) {
        if (distances[edge.from] != int.max &&
            distances[edge.from] + edge.weight < distances[edge.to]) {
            writeln("Graph contains a negative cycle");
            return;
        }
    }
}

void main() {
    auto f = File("rosalind_bf.txt", "r");
    
    // Read number of vertices and edges
    auto nm = f.readln.strip.split.map!(to!int).array;
    int n = nm[0];
    int m = nm[1];

    // Read edges
    Edge[] edges;
    foreach (_; 0..m) {
        auto uvw = f.readln.strip.split.map!(to!int).array;
        edges ~= Edge(uvw[0] - 1, uvw[1] - 1, uvw[2]);  // Convert to 0-based indexing
    }

    // Initialize distances array
    int[] distances = new int[n];
    fill(distances, int.max);

    // Run Bellman-Ford algorithm starting from vertex 0 (1 in 1-based indexing)
    bellmanFord(edges, distances, n, 0);

    // Print results
    foreach (d; distances) {
        if (d == int.max) {
            write("x ");
        } else {
            writef("%d ", d);
        }
    }
    writeln();
}