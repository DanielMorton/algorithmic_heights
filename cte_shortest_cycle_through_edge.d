import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.typecons : Tuple, tuple;

struct Edge {
    int to;
    int weight;
}

alias PriorityQueue = Tuple!(int, long)[];

void push(ref PriorityQueue pq, Tuple!(int, long) item) {
    pq ~= item;
    for (int i = cast(int)pq.length - 1; i > 0 && pq[i][1] < pq[(i-1)/2][1]; i = (i-1)/2) {
        swap(pq[i], pq[(i-1)/2]);
    }
}

Tuple!(int, long) pop(ref PriorityQueue pq) {
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

long[] dijkstra(Edge[][] graph, int start) {
    int n = cast(int)graph.length;
    long[] dist = new long[n];
    fill(dist, long.max);
    dist[start] = 0;

    PriorityQueue pq;
    push(pq, tuple(start, 0L));

    while (pq.length > 0) {
        auto current = pop(pq);
        int v = current[0];
        long d = current[1];

        if (d > dist[v]) continue;

        foreach (edge; graph[v]) {
            long newDist = d + edge.weight;
            if (newDist < dist[edge.to]) {
                dist[edge.to] = newDist;
                push(pq, tuple(edge.to, newDist));
            }
        }
    }

    return dist;
}

long shortestCycleThroughEdge(Edge[][] graph, int start, int end, int weight) {
    long[] distFromStart = dijkstra(graph, start);
    long[] distToEnd = dijkstra(graph, end);

    if (distFromStart[end] == long.max || distToEnd[start] == long.max) {
        return -1;  // No cycle exists
    }

    return weight + distToEnd[start];
}

void main() {
    auto f = File("rosalind_cte.txt", "r");
    
    int k = f.readln.strip.to!int;

    foreach (graph_index; 0..k) {
        //f.readln();  // Read blank line

        auto nm = f.readln.strip.split.map!(to!int).array;
        int n = nm[0];
        int m = nm[1];

        Edge[][] graph = new Edge[][](n);

        int firstStart, firstEnd, firstWeight;
        bool isFirstEdge = true;

        foreach (edge_index; 0..m) {
            auto uvw = f.readln.strip.split.map!(to!int).array;
            int u = uvw[0] - 1;  // Convert to 0-based indexing
            int v = uvw[1] - 1;
            int w = uvw[2];

            if (isFirstEdge) {
                firstStart = u;
                firstEnd = v;
                firstWeight = w;
                isFirstEdge = false;
            }

            graph[u] ~= Edge(v, w);
        }

        long result = shortestCycleThroughEdge(graph, firstStart, firstEnd, firstWeight);
        writef("%d ", result);
    }
    writeln();
}