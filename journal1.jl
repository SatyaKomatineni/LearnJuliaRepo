#=
*******************************************************
* chdirs2.jl
*
* 1. Show a set of directories and changes them
* 2. Inoked through cjc.bat
*
* Related Files
* jc.bat : prompts, and records the dir in a file
* cjc.bat : Reads the file in parent process and does "cd"
*******************************************************
=#

#using DataStructures for OrderedDict
using DataStructures

#To simulate [] operator
import Base.getindex

#Ordered Dictionary or hashtable
#keeps the keys in order
cmds = OrderedDict([
    ("jl-utils", raw"C:\satya\data\utils\jl")
    ,("shortcuts", raw"C:\Users\satya\OneDrive\Desktop\shortcuts")
])

#=
*******************************************************
* IndexedOrderDict: Quick wrapper around OrderedDict
* Collects keys in an cmdArray
* holds the keys for future calls
* In that sense it acts as a stateful function
* like a generator in python
*******************************************************
=#
struct IndexedOrderDict
    dict::OrderedDict
    keysArray::AbstractArray
    function IndexedOrderDict(dict::OrderedDict)
        keysArray = collect(keys(dict))
        new(keysArray,dict)
    end
end

#Override getindex for this type so that
#you can do dict[7] -> translates to getindex on that type
function Base.getindex(d::IndexedOrderDict, index::Int)
    keyname = d.keysArray[index]
    keyvalue = d.dict[keyname]
    return keyvalue
    #return "blah"
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

function getDictionaryValueByIndex(dict, index)
    keyarray = collect(keys(dict))
    keyname = keyarray[index]
    keyvalue = dict[keyname]
    return keyvalue
end

#=
*******************************************************
* End: Key utilities
*******************************************************
=#

#function definiton
function testfunction(name)
    hp("Print an input variable")
    println(name)

    hp("Print a 2x2 array")
    print(cmdArray)
    print(typeof(cmdArray))
    print(cmds)

    hp("Exploring dictionaries")
    keys = Base.keys(cmds)
    p(typeof(keys))
    printkeys(keys)
end

function printkeys(keysIter)
    for (index, key) in enumerate(keysIter)
        println("$index : $key")
    end
end

function testargs(value)
    p(value)
end


function testInput()
    ans = prompt("what is your name",nothing)
    if (ans == nothing)
        p("No answer")
        return
    end
    p("You typed:$ans")
end

#=
*******************************************************
* Helpers
*******************************************************
=#
function printDict(dict)
    for (index, key) in enumerate(keys(dict))
        keyvalue = dict[key]
        s = "$index), $key: $keyvalue"
        p(s)
    end
end
#=
*******************************************************
* Invokers
*******************************************************
=#

function mainproc()
    #Display the array
    printDict(cmds)
    ans = prompt("Where to:", nothing)
    if ans == nothing
        p("Nothing selected. return")
        return
    end
    index::Int16 = parse(Int16, ans)
    dir = getDictionaryValueByIndex(cmds,index)
    p("dir: $dir")
    changeDirectory(dir)
end

function changeDirectory(tdir)
    p("Changing directory in julia shell")
    Base.cd(tdir)

    p("Changing directory in for the parent windows shell")
    saveTargetDirToFile(tdir)
    readbackDir = readTargetDirFile()
    p("Saved directory: $readbackDir")
end
#=
*******************************************************
* Test file io
*******************************************************
=#
function getTransferfilename()
    return  "C:\\satya\\data\\utils\\jl\\transfer-commands.txt"
end

function saveTargetDirToFile(tdir)
    tfile = getTransferfilename()
    Base.open(tfile,"w") do io
        write(io,tdir)
    end
end

function readTargetDirFile()
    tfile = getTransferfilename()
    txt = Base.open(tfile,"r") do io
        return read(io,String)
    end
    return txt
end

function testFileio()
    tdir = raw"C:\satya\data\utils\jl"
    tdir1 = raw"C:\satya\data\utils\jl\1"

    saveTargetDirToFile(tdir1)
    txt = readTargetDirFile()
    p(txt)
end

#=
*******************************************************
* Testers
*******************************************************
=#
function testmain()
    #testStackTrace()
    #testValidStrings()
    #testInput()
    mainproc()
    #testOps()
    #testFileio()
end

function testOps()
    dict = IndexedOrderDict(cmds)
    dir = dict[2]
    p(dir)
end
function test()
    hp("Program Start")
    testmain()
    hp("Program End")
end
#calling the function
#testfunction("satya")
test()
