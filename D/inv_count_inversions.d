import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

long mergeAndCount(int[] arr, int left, int mid, int right)
{
    int[] temp = new int[right - left + 1];
    int i = left, j = mid + 1, k = 0;
    long invCount = 0;

    while (i <= mid && j <= right)
    {
        if (arr[i] <= arr[j])
        {
            temp[k++] = arr[i++];
        }
        else
        {
            temp[k++] = arr[j++];
            invCount += mid - i + 1; // Count inversions
        }
    }

    while (i <= mid)
        temp[k++] = arr[i++];

    while (j <= right)
        temp[k++] = arr[j++];

    for (i = 0; i < k; i++)
        arr[left + i] = temp[i];

    return invCount;
}

long mergeSortAndCount(int[] arr, int left, int right)
{
    long invCount = 0;
    if (left < right)
    {
        int mid = (left + right) / 2;

        invCount += mergeSortAndCount(arr, left, mid);
        invCount += mergeSortAndCount(arr, mid + 1, right);

        invCount += mergeAndCount(arr, left, mid, right);
    }
    return invCount;
}

void main()
{
    // Read input from file
    auto file = File("rosalind_inv.txt", "r");

    // Read the number of elements
    int n = to!int(file.readln().strip());

    // Read the array
    int[] arr = file.readln().strip().split().map!(to!int).array;

    // Count inversions using modified merge sort
    long inversions = mergeSortAndCount(arr, 0, n - 1);

    // Output the number of inversions
    writeln(inversions);
}