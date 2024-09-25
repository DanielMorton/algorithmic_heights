import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;
import std.random;

void swap(int[] arr, int i, int j)
{
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

int partition(int[] arr, int low, int high)
{
    // Choose a random pivot
    int pivotIndex = uniform(low, high + 1);
    int pivot = arr[pivotIndex];
    
    // Move pivot to the end
    swap(arr, pivotIndex, high);
    
    int i = low - 1;

    for (int j = low; j <= high - 1; j++)
    {
        if (arr[j] < pivot)
        {
            i++;
            swap(arr, i, j);
        }
    }
    swap(arr, i + 1, high);
    return i + 1;
}

void quickSort(int[] arr, int low, int high)
{
    if (low < high)
    {
        int pi = partition(arr, low, high);

        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

void main()
{
    // Read input from file
    auto file = File("rosalind_qs.txt", "r");

    // Read n
    int n = to!int(file.readln().strip());

    // Read the array
    int[] arr = file.readln().strip().split().map!(to!int).array;

    // Perform QuickSort
    quickSort(arr, 0, n - 1);

    // Output the sorted array
    writeln(arr.map!(to!string).join(" "));
}