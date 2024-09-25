import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.container : DList;

void bfs(int[][] graph, int[] distances, int start) {
    auto queue = DList!int();
    queue.insertBack(start);
    distances[start] = 0;

    while (!queue.empty) {
        int current = queue.front;
        queue.removeFront();

        foreach (neighbor; graph[current]) {
            if (distances[neighbor] == -1) {
                distances[neighbor] = distances[current] + 1;
                queue.insertBack(neighbor);
            }
        }
    }
}

void main() {
    auto f = File("rosalind_bfs.txt", "r");
    
    // Read number of vertices and edges
    auto nm = f.readln.strip.split.map!(to!int).array;
    int n = nm[0];
    int m = nm[1];

    // Initialize graph
    int[][] graph = new int[][](n);

    // Read edges
    foreach (_; 0..m) {
        auto uv = f.readln.strip.split.map!(to!int).array;
        int u = uv[0] - 1;  // Convert to 0-based indexing
        int v = uv[1] - 1;
        graph[u] ~= v;  // Directed graph
    }

    // Initialize distances array
    int[] distances = new int[n];
    fill(distances, -1);

    // Run BFS starting from vertex 0 (1 in 1-based indexing)
    bfs(graph, distances, 0);

    // Print results
    foreach (d; distances) {
        writef("%d ", d);
    }
    writeln();
}