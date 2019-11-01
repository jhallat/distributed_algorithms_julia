
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

function createTree(values)
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

#println(simpleHash("This is a test"))
#println(simpleHash("This is not a test"))
#println(simpleHash("This could be a test"))
println(createTree([10,20,30,40,50,60,70,80,90,100]))
