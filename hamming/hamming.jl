HammingList = Union{AbstractArray, AbstractString}

function hammingdist(l1:: T, l2::T) where T <: HammingList
    if typeof(l1) ≠ typeof(l2)
        throw(error("Function arguments must be of same type")) # this should be accounted by the same T in generics types :/
    end
    if length(l1) ≠ length(l2)
        error("Function arguments must be of same length")
    end

    hammingdist = 0
    for i in eachindex(l1)
        if l1[i] ≠ l2[i]
            hammingdist += 1
        end
    end
    return hammingdist
end


# If sum is forbidden is reduce forbidden as well? Not sure it makes things any faster, just less lines of code
function hammingdist_reduce(l1:: T, l2::T) where T <: HammingList
    if typeof(l1) ≠ typeof(l2)
        throw(error("Function arguments must be of same type"))
    end
    if length(l1) ≠ length(l2)
        error("Function arguments must be of same length")
    end

    return reduce((acc, i) -> acc+(l1[i]≠l2[i] ? 1 : 0) , 1:length(l1), init=0)
end


hammingdist("abc", ['a','b','c'])
hammingdist([1, 2, 3], 123)
hammingdist([1, 2, 3], [1, 4, 2, 3])
hammingdist("castle", "battle")
hammingdist([0, 3, 2, 1, 0], [0, 1, 2, 3, 1])
hammingdist([], [])

hammingdist_reduce("abc", ['a','b','c'])
hammingdist_reduce([1, 2, 3], 123)
hammingdist_reduce([1, 2, 3], [1, 4, 2, 3])
hammingdist_reduce("castle", "battle")
hammingdist_reduce([0, 3, 2, 1, 0], [0, 1, 2, 3, 1])
hammingdist_reduce([], [])
# Error handling is still a mistery to me