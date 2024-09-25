import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.container : DList;

struct Edge {
    int to;
    int weight;
}

void dfs(int v, int[][] graph, bool[] visited, ref DList!int order) {
    visited[v] = true;
    foreach (u; graph[v]) {
        if (!visited[u]) {
            dfs(u, graph, visited, order);
        }
    }
    order.insertFront(v);
}

int[] topologicalSort(int[][] graph) {
    int n = cast(int)graph.length;
    bool[] visited = new bool[n];
    auto order = DList!int();

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i, graph, visited, order);
        }
    }

    return order.array;
}

long[] shortestPath(int[][] graph, Edge[][] weightedGraph, int start) {
    int n = cast(int)graph.length;
    auto order = topologicalSort(graph);
    long[] dist = new long[n];
    fill(dist, long.max);
    dist[start] = 0;

    foreach (v; order) {
        if (dist[v] != long.max) {
            foreach (edge; weightedGraph[v]) {
                int u = edge.to;
                int weight = edge.weight;
                if (dist[v] + weight < dist[u]) {
                    dist[u] = dist[v] + weight;
                }
            }
        }
    }

    return dist;
}

void main() {
    auto f = File("rosalind_sdag.txt", "r");
    
    // Read number of vertices and edges
    auto nm = f.readln.strip.split.map!(to!int).array;
    int n = nm[0];
    int m = nm[1];

    // Initialize graph
    int[][] graph = new int[][](n);
    Edge[][] weightedGraph = new Edge[][](n);

    // Read edges
    foreach (_; 0..m) {
        auto uvw = f.readln.strip.split.map!(to!int).array;
        int u = uvw[0] - 1;  // Convert to 0-based indexing
        int v = uvw[1] - 1;
        int w = uvw[2];
        graph[u] ~= v;
        weightedGraph[u] ~= Edge(v, w);
    }

    // Compute shortest paths
    long[] distances = shortestPath(graph, weightedGraph, 0);  // Start from vertex 0 (1 in 1-based indexing)

    // Print results
    foreach (d; distances) {
        if (d == long.max) {
            write("x ");
        } else {
            writef("%d ", d);
        }
    }
    writeln();
}