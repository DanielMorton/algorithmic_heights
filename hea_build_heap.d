import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

void swap(int[] arr, int i, int j)
{
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

void bubbleUp(int[] arr, int i)
{
    while (i > 0 && arr[(i-1)/2] < arr[i])
    {
        swap(arr, i, (i-1)/2);
        i = (i-1)/2;
    }
}

void buildHeap(int[] arr)
{
    for (int i = 1; i < arr.length; i++)
    {
        bubbleUp(arr, i);
    }
}

void main()
{
    // Read input from file
    auto file = File("rosalind_hea.txt", "r");

    // Read n
    int n = to!int(file.readln().strip());

    // Read the array
    int[] arr = file.readln().strip().split().map!(to!int).array;

    // Build the heap
    buildHeap(arr);

    // Output the heap
    writeln(arr.map!(to!string).join(" "));
}