#=
*******************************************************
* First function in Julia
* This is a comment block
*******************************************************
=#

#simple line comment

#simple variable
x = 10

#function definiton
function testfunction(name)
    println(name)
    Base.println("This is test")

    #see what diretory we are in
    #Base.Filesystem.pwd
    println(pwd())
end

#calling the function
testfunction("satya")
