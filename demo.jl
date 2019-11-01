
struct Node
    value::Int64
    left::Union{Node,Nothing}
    right::Union{Node,Nothing}
end

function simpleHash(value)
    hash = 0
    for c in value
        x = Int(c)
        hash *= 378551
        hash += x
        hash *= 63689
    end
    abs(hash)
end

function createTree(values::Array{Int64})
    if length(values) > 2
        midpoint = div(length(values), 2)
        Node(values[midpoint], createTree(values[1:midpoint - 1]), createTree(values[midpoint + 1:end]))
    elseif length(values) == 2
        if values[1] > values[2]
            Node(values[1], createTree([values[2]]), nothing)
        else
            Node(values[1], nothing, createTree([values[2]]))
        end   
    elseif length(values) == 1  
        Node(values[1], nothing, nothing)
    else
        nothing    
    end  
end

function mergeSort(values::Array{Int64})
    count = length(values)
    if count == 1
        values
    else  
        midpoint = div(count, 2)
        values1 = mergeSort(values[1:midpoint])
        values2 = mergeSort(values[midpoint + 1:end])
        sorted = Array{Int64}(undef, count)
        index1 = 1
        index2 = 1
        indexSort = 1
        while index1 <= length(values1) && index2 <= length(values2)
            if values1[index1] < values2[index2]
                sorted[indexSort] = values1[index1]
                index1 += 1
            else
                sorted[indexSort] = values2[index2]
                index2 += 1
            end
            indexSort += 1
        end
        while length(values1) >= index1
            sorted[indexSort] = values1[index1]
            indexSort += 1
            index1 += 1
        end  
        while length(values2) >= index2
            sorted[indexSort] = values2[index2]
            indexSort += 1
            index2 += 1
        end  
        sorted 
    end   
end  

#println(simpleHash("This is a test"))
#println(simpleHash("This is not a test"))
#println(simpleHash("This could be a test"))
values = [100,50,60,20,10,30,90,70,80,40]
values = mergeSort(values)
println(createTree(values))
