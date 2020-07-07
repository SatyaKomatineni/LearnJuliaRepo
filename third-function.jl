#=
*******************************************************
* Third function in Julia
*
* 1. How to validate strings for emptyness
* 2. How to use try/catch
* 3. How to print stack trace
* 4. How to specify return type
* 5. How to specify argument type
*******************************************************
=#

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

#=
******************************************************
#You do variable or arg or function followed by :: to specify type name
#type names are case sensitive
#string will be wrong but String will be write
******************************************************
=#
function prompt(question::String, defaultAnswer)::String
    p(question)
    line = readline(stdin)
    if (isEmptyString(line))
        return defaultAnswer
    end
    return line
end

function isEmptyString(s::String)::Bool
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


#=
******************************************************
#How stack traces work is a bit involved
#For now use these functions below as they work
#if you are curious, you have to know
# stacktrace()
# showerror()
# catch_backtrace()
******************************************************
=#
function printExceptionStackTrace(x)
    showerror(stdout, x, catch_backtrace())
end
function printExceptionMessage(x)
    showerror(stdout, x)
end

#******************************************************
# Test stack trace
#******************************************************

function testStackTrace()
        try
            p(blah)
        catch x
            printStackTrace(x)
        end
end

#******************************************************
# Test empty strings
#******************************************************
function testValidStrings()
    b = isEmptyString("")
    p(b) #true
    b = isEmptyString(" \t")
    p(b) #true
    b = isEmptyString(" dd ")
    p(b) #false

    try
        b = isEmptyString(7)
    catch x
        printExceptionMessage(x)
    end
end

#******************************************************
# Puting it all together, implemeent a prompt function
#******************************************************
function testInput()
    ans = prompt("what is your name",nothing)
    if (ans == nothing)
        p("No answer")
        return
    end
    p("You typed:$ans")
end

#Call all the tests here
#Some are commented out. Uncomment if needed.
function testmain()
    #testStackTrace()
    #testValidStrings()
    testInput()
end

#some wrapping
function test()
    hp("Program Start")
    testmain()
    hp("Program End")
end

#Run the tests
test()
