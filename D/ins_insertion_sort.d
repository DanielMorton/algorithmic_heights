import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm; // Added this import for the map function

int insertionSort(int[] arr)
{
    int n = cast(int)arr.length;
    int swaps = 0;
    
    for (int i = 1; i < n; i++)
    {
        int key = arr[i];
        int j = i - 1;
        
        while (j >= 0 && arr[j] > key)
        {
            arr[j + 1] = arr[j];
            j--;
            swaps++;
        }
        arr[j + 1] = key;
    }
    
    return swaps;
}

void main()
{
    // Read input from file
    auto file = File("rosalind_ins.txt", "r");
    
    // Read the number of elements
    int n = to!int(file.readln().strip());
    
    // Read the array
    int[] arr = file.readln().strip().split().map!(to!int).array;
    
    // Perform insertion sort and count swaps
    int swaps = insertionSort(arr);
    
    // Output the result
    writeln(swaps);
}