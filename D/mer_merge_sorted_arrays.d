import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

int[] mergeSortedArrays(int[] A, int[] B)
{
    int[] C = new int[A.length + B.length];
    int i = 0, j = 0, k = 0;

    while (i < A.length && j < B.length)
    {
        if (A[i] <= B[j])
        {
            C[k++] = A[i++];
        }
        else
        {
            C[k++] = B[j++];
        }
    }

    // If there are remaining elements in A, add them to C
    while (i < A.length)
    {
        C[k++] = A[i++];
    }

    // If there are remaining elements in B, add them to C
    while (j < B.length)
    {
        C[k++] = B[j++];
    }

    return C;
}

void main()
{
    // Read input from file
    auto file = File("rosalind_mer.txt", "r");

    // Read the first array
    int n = to!int(file.readln().strip());
    int[] A = file.readln().strip().split().map!(to!int).array;

    // Read the second array
    int m = to!int(file.readln().strip());
    int[] B = file.readln().strip().split().map!(to!int).array;

    // Merge the sorted arrays
    int[] C = mergeSortedArrays(A, B);

    // Output the result
    writeln(C.map!(to!string).join(" "));
}