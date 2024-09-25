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

int partition(int[] arr, int left, int right)
{
    int pivotIndex = uniform(left, right + 1);
    int pivotValue = arr[pivotIndex];
    swap(arr, pivotIndex, right);
    int storeIndex = left;
    
    for (int i = left; i < right; i++)
    {
        if (arr[i] < pivotValue)
        {
            swap(arr, i, storeIndex);
            storeIndex++;
        }
    }
    
    swap(arr, storeIndex, right);
    return storeIndex;
}

int quickSelect(int[] arr, int left, int right, int k)
{
    if (left == right)
        return arr[left];
    
    int pivotIndex = partition(arr, left, right);
    int length = pivotIndex - left + 1;
    
    if (k == length)
        return arr[pivotIndex];
    else if (k < length)
        return quickSelect(arr, left, pivotIndex - 1, k);
    else
        return quickSelect(arr, pivotIndex + 1, right, k - length);
}

void main()
{
    // Read input from file
    auto file = File("rosalind_med.txt", "r");

    // Read n
    int n = to!int(file.readln().strip());

    // Read the array
    int[] arr = file.readln().strip().split().map!(to!int).array;

    // Read k
    int k = to!int(file.readln().strip());

    // Perform QuickSelect
    int result = quickSelect(arr, 0, n - 1, k);

    // Output the result
    writeln(result);
}