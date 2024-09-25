import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;
import std.random;

void swap(int[] arr, size_t i, size_t j)
{
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

size_t partition(int[] arr, size_t low, size_t high)
{
    size_t pivotIndex = uniform(low, high + 1);
    int pivot = arr[pivotIndex];
    swap(arr, pivotIndex, high);
    
    size_t i = low;
    for (size_t j = low; j < high; j++)
    {
        if (arr[j] <= pivot)
        {
            swap(arr, i, j);
            i++;
        }
    }
    swap(arr, i, high);
    return i;
}

void partialQuickSort(int[] arr, size_t low, size_t high, size_t k)
{
    if (low < high && low < k)
    {
        size_t pi = partition(arr, low, high);
        
        partialQuickSort(arr, low, pi - 1, k);
        if (pi < k - 1)
            partialQuickSort(arr, pi + 1, high, k);
    }
}

void main()
{
    // Read input from file
    auto file = File("rosalind_ps.txt", "r");

    // Read n
    int n = to!int(file.readln().strip());

    // Read the array
    int[] arr = file.readln().strip().split().map!(to!int).array;

    // Read k
    int k = to!int(file.readln().strip());

    // Perform partial sort
    partialQuickSort(arr, 0, arr.length - 1, k);

    // Output the k smallest elements
    writeln(arr[0..k].map!(to!string).join(" "));
}