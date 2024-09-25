import std.stdio;
import std.file;
import std.conv;     // For to!int
import std.string;   // For strip
import std.array;    // For split
import std.algorithm; // For map

// Function to perform binary search manually
int binarySearch(int[] arr, int key) {
    int left = 0;
    int right = cast(int)(arr.length - 1); // Explicit cast to int
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == key) {
            return mid + 1; // Return 1-based index
        } else if (arr[mid] < key) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return -1; // Return -1 if key is not found
}

void main() {
    // Read input from file
    string[] input = readText("rosalind_bins.txt").strip.splitLines(); // Use strip and splitLines for cleanup
    
    int n = input[0].to!int;        // First line: size of array A
    int m = input[1].to!int;        // Second line: number of keys
    int[] A = input[2].split.map!(to!int).array; // Sorted array A[1..n], use map to convert to integers
    int[] keys = input[3].split.map!(to!int).array; // List of keys to search, use map to convert to integers

    // Perform binary search for each key and store the result
    foreach (key; keys) {
        write(binarySearch(A, key), " ");
    }
    writeln();
}
