import std.stdio;
import std.file;
import std.conv;      // For to!int
import std.string;    // For strip
import std.array;     // For split
import std.algorithm; // For map

// Function to find the majority element in an array
int findMajorityElement(int[] arr) {
    int n = cast(int) arr.length; // Explicit cast to int
    int threshold = n / 2;
    
    // Use a frequency counter (associative array)
    int[int] count;
    
    // Count the occurrences of each element
    foreach (element; arr) {
        count[element]++;
        if (count[element] > threshold) {
            return element; // Majority element found
        }
    }
    
    return -1; // No majority element
}

void main() {
    // Read input from file
    string[] input = readText("rosalind_maj.txt").strip.splitLines();
    
    // First line: k (number of arrays) and n (size of each array)
    auto params = input[0].split.map!(to!int).array;
    int k = params[0]; // number of arrays
    int n = params[1]; // size of each array

    // Process each array and find the majority element
    for (int i = 1; i <= k; i++) {
        int[] array = input[i].split.map!(to!int).array;
        writeln(findMajorityElement(array));
    }
}
