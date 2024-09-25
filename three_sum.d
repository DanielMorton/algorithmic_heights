import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;
import std.typecons : Tuple, tuple; // Add this import for Tuple

int[3] findThreeSum(int[] arr)
{
    int n = cast(int)arr.length;
    int[3] result = [-1, -1, -1];
    
    // Create a sorted copy of the array with original indices
    auto sortedWithIndex = new Tuple!(int, "value", int, "index")[n];
    foreach (i, value; arr)
    {
        sortedWithIndex[i] = tuple!("value", "index")(value, cast(int)i);
    }
    sort!"a.value < b.value"(sortedWithIndex);

    for (int i = 0; i < n - 2; i++)
    {
        int left = i + 1;
        int right = n - 1;

        while (left < right)
        {
            int sum = sortedWithIndex[i].value + sortedWithIndex[left].value + sortedWithIndex[right].value;
            
            if (sum == 0)
            {
                result = [
                    sortedWithIndex[i].index + 1,
                    sortedWithIndex[left].index + 1,
                    sortedWithIndex[right].index + 1
                ];
                sort(result[]); // Ensure indices are in ascending order
                return result;
            }
            else if (sum < 0)
            {
                left++;
            }
            else
            {
                right--;
            }
        }
    }
    
    return result;
}

void main()
{
    // Read input from file
    auto file = File("rosalind_3sum.txt", "r");

    // Read k and n
    auto firstLine = file.readln().strip().split().map!(to!int).array;
    int k = firstLine[0];
    int n = firstLine[1];

    // Process each array
    foreach (_; 0..k)
    {
        int[] arr = file.readln().strip().split().map!(to!int).array;
        int[3] result = findThreeSum(arr);
        
        if (result[0] == -1)
        {
            writeln("-1");
        }
        else
        {
            writefln("%d %d %d", result[0], result[1], result[2]);
        }
    }
}