import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;

bool isBipartite(int[][] graph, int n) {
    if (n <= 1) return true;

    int[] colors = new int[n];
    fill(colors, -1);  // -1 represents uncolored

    bool dfs(int v, int color) {
        colors[v] = color;
        foreach (u; graph[v]) {
            if (colors[u] == -1) {
                if (!dfs(u, 1 - color)) return false;
            } else if (colors[u] == color) {
                return false;
            }
        }
        return true;
    }

    for (int i = 0; i < n; i++) {
        if (colors[i] == -1) {
            if (!dfs(i, 0)) return false;
        }
    }
    return true;
}

void main() {
    auto f = File("rosalind_bip.txt", "r");
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

        writef("%d ", isBipartite(graph, n) ? 1 : -1);
    }
    writeln();
}