import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.container : DList;
import std.math : abs;

struct Edge {
    int to;
}

void dfs(int v, Edge[][] graph, bool[] visited, ref DList!int order) {
    visited[v] = true;
    foreach (edge; graph[v]) {
        if (!visited[edge.to]) {
            dfs(edge.to, graph, visited, order);
        }
    }
    order.insertFront(v);
}

int[] findSCCs(Edge[][] graph, Edge[][] reversedGraph) {
    int n = cast(int)graph.length;
    bool[] visited = new bool[n];
    auto order = DList!int();

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i, graph, visited, order);
        }
    }

    visited[] = false;
    int[] component = new int[n];
    int currentComponent = 0;

    foreach (v; order[]) {
        if (!visited[v]) {
            auto componentOrder = DList!int();
            dfs(v, reversedGraph, visited, componentOrder);
            foreach (u; componentOrder[]) {
                component[u] = currentComponent;
            }
            currentComponent++;
        }
    }

    return component;
}

int getNodeIndex(int literal, int n) {
    return (literal > 0) ? literal - 1 : n + abs(literal) - 1;
}

bool solve2SAT(int n, int[][] clauses) {
    int numNodes = 2 * n;
    Edge[][] graph = new Edge[][](numNodes);
    Edge[][] reversedGraph = new Edge[][](numNodes);

    foreach (clause; clauses) {
        int a = getNodeIndex(clause[0], n);
        int b = getNodeIndex(clause[1], n);
        int notA = (a < n) ? a + n : a - n;
        int notB = (b < n) ? b + n : b - n;

        graph[notA] ~= Edge(b);
        graph[notB] ~= Edge(a);
        reversedGraph[b] ~= Edge(notA);
        reversedGraph[a] ~= Edge(notB);
    }

    int[] component = findSCCs(graph, reversedGraph);

    for (int i = 0; i < n; i++) {
        if (component[i] == component[i + n]) {
            return false;
        }
    }

    return true;
}

int[] findSatisfyingAssignment(int n, int[][] clauses) {
    int numNodes = 2 * n;
    Edge[][] graph = new Edge[][](numNodes);
    Edge[][] reversedGraph = new Edge[][](numNodes);

    foreach (clause; clauses) {
        int a = getNodeIndex(clause[0], n);
        int b = getNodeIndex(clause[1], n);
        int notA = (a < n) ? a + n : a - n;
        int notB = (b < n) ? b + n : b - n;

        graph[notA] ~= Edge(b);
        graph[notB] ~= Edge(a);
        reversedGraph[b] ~= Edge(notA);
        reversedGraph[a] ~= Edge(notB);
    }

    int[] component = findSCCs(graph, reversedGraph);
    int[] assignment = new int[n];

    for (int i = 0; i < n; i++) {
        if (component[i] > component[i + n]) {
            assignment[i] = i + 1;
        } else {
            assignment[i] = -(i + 1);
        }
    }

    return assignment;
}

void main() {
    auto f = File("rosalind_2sat.txt", "r");
    
    int k = f.readln.strip.to!int;

    foreach (formula_index; 0..k) {
        f.readln();  // Read blank line

        auto nm = f.readln.strip.split.map!(to!int).array;
        int n = nm[0];
        int m = nm[1];

        int[][] clauses;
        foreach (clause_index; 0..m) {
            auto clause = f.readln.strip.split.map!(to!int).array;
            clauses ~= clause;
        }

        bool isSatisfiable = solve2SAT(n, clauses);
        
        if (!isSatisfiable) {
            write("0 ");
        } else {
            write("1 ");
            int[] assignment = findSatisfyingAssignment(n, clauses);
            foreach (a; assignment) {
                writef("%d ", a);
            }
        }
        writeln();
    }
}