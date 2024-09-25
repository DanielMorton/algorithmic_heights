import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

int[] partition(int[] arr)
{
    if (arr.length <= 1)
        return arr;

    int pivot = arr[0];
    int[] left = [];
    int[] right = [];

    foreach (num; arr[1..$])
    {
        if (num <= pivot)
            left ~= num;
        else
            right ~= num;
    }

    return left ~ pivot ~ right;
}

void main()
{
    // Read input from file
    auto file = File("rosalind_par.txt", "r");

    // Read n
    int n = to!int(file.readln().strip());

    // Read the array
    int[] arr = file.readln().strip().split().map!(to!int).array;

    // Perform partition
    int[] result = partition(arr);

    // Output the result
    writeln(result.map!(to!string).join(" "));
}