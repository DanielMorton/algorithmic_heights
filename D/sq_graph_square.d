import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;

bool hasCycleOfLength4(int[][] graph, int n) {
    for (int i = 0; i < n - 3; i++) {
        for (int j = i + 1; j < n - 2; j++) {
            if (!graph[i].canFind(j)) continue;
            for (int k = j + 1; k < n - 1; k++) {
                if (!graph[j].canFind(k)) continue;
                for (int l = k + 1; l < n; l++) {
                    if (graph[k].canFind(l) && graph[l].canFind(i)) {
                        return true;
                    }
                }
            }
        }
    }
    return false;
}

void main() {
    auto f = File("rosalind_sq.txt", "r");
    int k = f.readln.strip.to!int;

    foreach (graph_index; 0..k) {
        // Read and ignore the blank line
        f.readln();

        auto nm = f.readln.strip.split.map!(to!int).array;
        int n = nm[0];
        int m = nm[1];

        int[][] graph = new int[][](n);

        foreach (edge_index; 0..m) {
            auto uv = f.readln.strip.split.map!(to!int).array;
            int u = uv[0] - 1;  // Convert to 0-based indexing
            int v = uv[1] - 1;
            graph[u] ~= v;
            graph[v] ~= u;  // Undirected graph
        }

        writef("%d ", hasCycleOfLength4(graph, n) ? 1 : -1);
    }
    writeln();
}