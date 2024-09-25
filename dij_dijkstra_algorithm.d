import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.typecons : Tuple, tuple;

alias PriorityQueue = Tuple!(int, int)[];

void push(ref PriorityQueue pq, Tuple!(int, int) item) {
    pq ~= item;
    for (int i = cast(int)pq.length - 1; i > 0 && pq[i][1] < pq[(i-1)/2][1]; i = (i-1)/2) {
        swap(pq[i], pq[(i-1)/2]);
    }
}

Tuple!(int, int) pop(ref PriorityQueue pq) {
    auto result = pq[0];
    pq[0] = pq[$-1];
    pq.length--;
    if (pq.length > 0) {
        int i = 0;
        while (true) {
            int j = 2*i + 1;
            if (j >= pq.length) break;
            if (j+1 < pq.length && pq[j+1][1] < pq[j][1]) j++;
            if (pq[i][1] <= pq[j][1]) break;
            swap(pq[i], pq[j]);
            i = j;
        }
    }
    return result;
}

void dijkstra(int[][] graph, int[][] weights, int[] distances, int start) {
    PriorityQueue pq;
    push(pq, tuple(start, 0));
    distances[start] = 0;

    while (pq.length > 0) {
        auto current = pop(pq);
        int v = current[0], dist = current[1];

        if (dist > distances[v]) continue;

        foreach (i, neighbor; graph[v]) {
            int newDist = dist + weights[v][i];
            if (newDist < distances[neighbor]) {
                distances[neighbor] = newDist;
                push(pq, tuple(neighbor, newDist));
            }
        }
    }
}

void main() {
    auto f = File("rosalind_dij.txt", "r");
    
    // Read number of vertices and edges
    auto nm = f.readln.strip.split.map!(to!int).array;
    int n = nm[0];
    int m = nm[1];

    // Initialize graph and weights
    int[][] graph = new int[][](n);
    int[][] weights = new int[][](n);

    // Read edges
    foreach (_; 0..m) {
        auto uvw = f.readln.strip.split.map!(to!int).array;
        int u = uvw[0] - 1;  // Convert to 0-based indexing
        int v = uvw[1] - 1;
        int w = uvw[2];
        graph[u] ~= v;
        weights[u] ~= w;
    }

    // Initialize distances array
    int[] distances = new int[n];
    fill(distances, int.max);

    // Run Dijkstra's algorithm starting from vertex 0 (1 in 1-based indexing)
    dijkstra(graph, weights, distances, 0);

    // Print results
    foreach (d; distances) {
        writef("%d ", d == int.max ? -1 : d);
    }
    writeln();
}