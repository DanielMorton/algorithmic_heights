import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

void swap(int[] arr, size_t i, size_t j)
{
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

void siftDown(int[] arr, size_t start, size_t end)
{
    size_t root = start;

    while (root * 2 + 1 <= end)
    {
        size_t child = root * 2 + 1;
        size_t swapIndex = root;

        if (arr[swapIndex] < arr[child])
            swapIndex = child;

        if (child + 1 <= end && arr[swapIndex] < arr[child + 1])
            swapIndex = child + 1;

        if (swapIndex == root)
            return;
        else
        {
            swap(arr, root, swapIndex);
            root = swapIndex;
        }
    }
}

void heapify(int[] arr)
{
    if (arr.length <= 1) return;
    
    size_t start = (arr.length - 2) / 2;

    while (start >= 0 && start < arr.length)
    {
        siftDown(arr, start, arr.length - 1);
        if (start == 0) break;
        start--;
    }
}

void heapSort(int[] arr)
{
    heapify(arr);

    for (size_t end = arr.length - 1; end > 0; end--)
    {
        swap(arr, 0, end);
        siftDown(arr, 0, end - 1);
    }
}

void main()
{
    // Read input from file
    auto file = File("rosalind_hs.txt", "r");

    // Read n
    int n = to!int(file.readln().strip());

    // Read the array
    int[] arr = file.readln().strip().split().map!(to!int).array;

    // Perform Heap Sort
    heapSort(arr);

    // Output the sorted array
    writeln(arr.map!(to!string).join(" "));
}