#=
*******************************************************
* Fifth function in Julia
*
* 1. String concatenation
* 2. String validation
*
*******************************************************
=#

#Strings are documented here
#https://docs.julialang.org/en/v1/manual/strings/
function testStringConcat()
    first = "first"
    second = "second"

    #First way: Using construcor like function
    s1 = string(first,second)
    p(s1)

    #second way
    s1 = string(first, ",", second)
    p(s1)

    #third way: Using the * operator
    s1 = first * "," * second
    p(s1)

    #fourth way: Using string literal
    s1 = "$first,$second"
    p(s1)
end


#=
*******************************************************
* Few utility functions
*******************************************************
=#

function p(message)
    println(message)
end

function hp(message)
    println("")
    println(message)
    println("*************************************")
end

function prompt(question::String, defaultAnswer)::Any
    p(question)
    line = readline(stdin)
    if (isEmptyString(line))
        return defaultAnswer
    end
    return line
end

function isEmptyString(s::Union{String,Nothing})::Bool
    #type ensures that an unassignd value
    #is never passed in
    if (s == nothing)
        return true
    end
    if (isempty(s) == true)
        return true
    end
    if (isempty(strip(s)) == true)
        return true
    end
    return false
end

function printExceptionStackTrace(x)
    showerror(stdout, x, catch_backtrace())
end
function printExceptionMessage(x)
    showerror(stdout, x)
end
#=
*******************************************************
* End: Key utilities
*******************************************************
=#

function testmain()
    testStringConcat()
end

function test()
    hp("Program Start")
    testmain()
    hp("Program End")
end

test()
