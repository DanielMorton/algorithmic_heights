import std.stdio;
import std.file;
import std.string; // For strip
import std.conv;   // For to!int

ulong fibonacci(int n) {
    if (n <= 1) {
        return n;
    }
    ulong a = 0, b = 1, c;
    for (int i = 2; i <= n; i++) {
        c = a + b;
        a = b;
        b = c;
    }
    return b;
}

void main() {
    string input = readText("rosalind_fibo.txt").strip(); // Read and strip input
    int n = input.to!int; // Convert string to integer
    writeln(fibonacci(n)); // Output Fn
}
