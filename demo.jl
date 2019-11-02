using Random

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

function generateNodeHashes(address::String, number::Int64)

    nodes = Int64[]
    for i = 1:number
        node = string(address, randstring())
        nodeHash = simpleHash(node)
        append!(nodes, nodeHash)
    end  
    nodes

end  

nodes = generateNodeHashes("127.0.0.1:8080", 10)
nodes = append!(nodes, generateNodeHashes("127.0.0.1:8081", 10))
nodes = append!(nodes, generateNodeHashes("127.0.0.1:8082", 10))
nodes = mergeSort(nodes)
println(createTree(nodes))
