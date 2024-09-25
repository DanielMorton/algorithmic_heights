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

int[] threeWayPartition(int[] arr)
{
    if (arr.length <= 1)
        return arr;

    int pivot = arr[0];
    int i = 0;  // pointer for elements < pivot
    int j = 0;  // pointer for current element
    int k = cast(int)arr.length - 1;  // pointer for elements > pivot

    while (j <= k)
    {
        if (arr[j] < pivot)
        {
            swap(arr, i, j);
            i++;
            j++;
        }
        else if (arr[j] > pivot)
        {
            swap(arr, j, k);
            k--;
        }
        else
        {
            j++;
        }
    }

    return arr;
}

void main()
{
    // Read input from file
    auto file = File("rosalind_par3.txt", "r");

    // Read n
    int n = to!int(file.readln().strip());

    // Read the array
    int[] arr = file.readln().strip().split().map!(to!int).array;

    // Perform three-way partition
    int[] result = threeWayPartition(arr);

    // Output the result
    writeln(result.map!(to!string).join(" "));
}