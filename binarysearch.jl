# Copyright (c) 2022 Code Komali
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

using Test

include("StudentData.jl")
using .StudentData

# Binary Search - Returns the index of the element if found, 
# otherwise returns -1
function binarySearch(arr::Vector, elem;
    desc = true,
    compareFn = desc ? (x, y) -> x > y : (x, y) -> x < y,
    startindex = 1)
    mid = ceil(Int, length(arr) / 2)
    if mid == 0
        -1
    elseif arr[mid] == elem
        startindex + mid - 1
    elseif compareFn(arr[mid], elem)
        binarySearch(arr[mid+1:end], elem,
            desc = desc, compareFn = compareFn, startindex = startindex + mid)
    else
        binarySearch(arr[1:mid-1], elem,
            desc = desc, compareFn = compareFn, startindex = startindex)
    end
end

@testset "Binary search" begin
    @test binarySearch([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 7) == 4
    @test binarySearch([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 10) == 1
    @test binarySearch([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 1) == 10
    @test binarySearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 7, desc = false) == 7
    @test binarySearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 10, desc = false) == 10
    @test binarySearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 1, desc = false) == 1
    @test binarySearch(sortedStudents, Student("mark", "s2020127", 7.9),
        compareFn = studentCompareFn) == 3
end
