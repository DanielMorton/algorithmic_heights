import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;

struct Edge {
    int from, to, weight;
}

bool hasNegativeCycle(Edge[] edges, int n) {
    long[] distances = new long[n];
    int[] predecessor = new int[n];
    fill(distances, 0);  // Initialize all distances to 0
    fill(predecessor, -1);

    // Relax all edges n-1 times
    foreach (i; 0..n-1) {
        bool anyChange = false;
        foreach (edge; edges) {
            if (distances[edge.from] + edge.weight < distances[edge.to]) {
                distances[edge.to] = distances[edge.from] + edge.weight;
                predecessor[edge.to] = edge.from;
                anyChange = true;
            }
        }
        if (!anyChange) break;
    }

    // Check for negative cycle
    foreach (edge; edges) {
        if (distances[edge.from] + edge.weight < distances[edge.to]) {
            return true;  // Negative cycle detected
        }
    }

    return false;
}

void main() {
    auto f = File("rosalind_nwc.txt", "r");
    
    // Read number of graphs
    int k = f.readln.strip.to!int;

    foreach (graph_index; 0..k) {

        // Read number of vertices and edges
        auto nm = f.readln.strip.split.map!(to!int).array;
        int n = nm[0];
        int m = nm[1];

        // Read edges
        Edge[] edges;
        foreach (edge_index; 0..m) {
            auto uvw = f.readln.strip.split.map!(to!int).array;
            edges ~= Edge(uvw[0] - 1, uvw[1] - 1, uvw[2]);  // Convert to 0-based indexing
        }

        // Check for negative cycle
        bool hasNegCycle = hasNegativeCycle(edges, n);

        // Print result
        writef("%d ", hasNegCycle ? 1 : -1);
    }
    writeln();
}