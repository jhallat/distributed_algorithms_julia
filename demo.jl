function simpleHash(value)
    hash = 0
    for c in value
        x = Int(c)
        hash *= 31
        hash += x
    end
    hash
end

testString = "This is a test"
hashString = simpleHash(testString)
println(hashString)
