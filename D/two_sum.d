import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;

int[2] findTwoSum(int[] arr)
{
    int[int] numMap;
    
    for (int i = 0; i < arr.length; i++)
    {
        if (arr[i] in numMap)
        {
            return [numMap[arr[i]] + 1, i + 1]; // Adding 1 to convert to 1-based index
        }
        numMap[-arr[i]] = i;
    }
    
    return [-1, -1]; // No solution found
}

void main()
{
    // Read input from file
    auto file = File("rosalind_2sum.txt", "r");

    // Read k and n
    auto firstLine = file.readln().strip().split().map!(to!int).array;
    int k = firstLine[0];
    int n = firstLine[1];

    // Process each array
    foreach (_; 0..k)
    {
        int[] arr = file.readln().strip().split().map!(to!int).array;
        int[2] result = findTwoSum(arr);
        
        if (result[0] == -1)
        {
            writeln("-1");
        }
        else
        {
            writefln("%d %d", result[0], result[1]);
        }
    }
}