#=
*******************************************************
* Eighth Function: chdirs2.jl
*
* 1. Prompt a set of directories to "cd" into
^ 2. A command line utility for windows
* 2. Inoked through cjc.bat
*
* Maturity
* **************
* 1. Very very early learning exercise
* 2. There are probably a 1000 ways to make this better
*
* Related Files
* jc.bat : prompts, and records the dir in a file
* cjc.bat : Reads the file in parent process and does "cd"
*
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
    #Reset the transfer file contents
    #so that the following windows command file can choose to do Nothing
    resetTransferFile()

    #Display the array: prompting
    printDict(cmds)
    ans = prompt("Where to:", nothing)
    if ans == nothing
        p("Nothing selected. return")
        return
    end
    #Get the index of the dir entry
    index::Int16 = parse(Int16, ans)

    #Figure out the target directory
    dir = getDictionaryValueByIndex(cmds,index)
    p("dir: $dir")

    #Change the directory
    changeDirectory(dir)
end

function changeDirectory(tdir)
    p("Changing directory in julia shell")
    Base.cd(tdir)

    p("Changing directory in for the parent windows shell")

    #Write the target directory to a file
    #You need this because julia REPL cannot change
    #windows parent shell variables
    saveTargetDirToFile(tdir)

    #Make sure it is written
    readbackDir = readTargetDirFile()
    p("Saved directory: $readbackDir")

    #A subsequent batch file will read this
    #info and change the parent shell directory
end

#=
*******************************************************
* Test file io
*******************************************************
=#
function getTransferfilename()
    return  "C:\\satya\\data\\utils\\jl\\transfer-commands.txt"
end

function resetTransferFile()
    saveTargetDirToFile("none")
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
* Main procedure
*******************************************************
=#
function runMainProc()
    hp("Program Start")
    mainproc()
    hp("Program End")
end
#calling the function
runMainProc()


#=
*******************************************************
* Invoke this cjc.bat

cjc.bat
***********
call julia C:\satya\data\utils\jl\chdirs2.jl
call jc.bat

jc.bat
***********
it is a touch involved to include here.
will post a link
*******************************************************
=#
