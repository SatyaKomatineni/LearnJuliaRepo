#=
*******************************************************
* Tenth Function: search-env.jl
*
* 1. Explore Julia ENV variables
* 2. Explores ENV dictionary variable of julia
* 3. Inoked through search-jl-env.bat (sje.bat)
*
* Maturity
* **************
* 1. Very very early learning exercise
* 2. There are probably a 1000 ways to make this better
*
* Related Files
* sje.bat : will prompt a search string to match. prints
* all env variables if no search string is given.
*
* other useful batch files:
* cjc.bat : Reads the file in parent process and does "cd"
* jgrep.bat: simple grep implementation using julia
*
* Useful URLs
* *****************
* 1. Regex constructor for occursin
*    Flags: https://docs.julialang.org/en/v1/base/strings/#Base.@r_str
*    Regex page: https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions-1
*
* 2. occursin function
*    function doc: https://docs.julialang.org/en/v1/base/strings/#Base.occursin
*    as part of string: https://docs.julialang.org/en/v1/manual/strings/#
*
* 3. List Comprehensions (aka Select statements)
*    Forum: https://discourse.julialang.org/t/map-vs-list-comprehension/916/2
*    for loop: https://docs.julialang.org/en/v1/manual/variables-and-scoping/#For-Loops-and-Comprehensions-1
*
* 4. Splitting strings: split function
*    split: https://docs.julialang.org/en/v1/base/strings/#Base.split
*
* 5. foreach to execute functions on each object. Visitor
*    foreach function: https://docs.julialang.org/en/v1/base/collections/#Base.foreach
*
* 6. Boolean and not operators
*    operators: https://docs.julialang.org/en/v1/base/punctuation/#
*
* Batch file: sje.bat
* *******************
* @echo off
* julia C:\satya\data\utils\jl\search-env.jl
*
*******************************************************
=#

function mainproc()

    reply = prompt("Search ENV string:",nothing)
    if (isEmptyString(reply))
        p("Showing all env variables")
        printArray(keys(ENV), "Env variables")
        return
    end

    p("Searchign env for: $reply")

    #Perform case insensitive search
    #for keys or values that match a case insensitve string
    re = Regex(reply,"i")

    #key names where key or its value has a matching string
    keynames = [key for key in keys(ENV)
        if (occursin(re,key) || occursin(re,ENV[key]))
    ]

    printArray(keynames, "Env keys matching: $reply")

    hp("Matching Env  Key Values")
    printKeys(keynames, ENV)
    #printArray(keynames, "Environment names")
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

function printArray(a, message::String)
    hp(message)
    foreach(p,a)
end

function printDict(dict)
    for (index, key) in enumerate(keys(dict))
        keyvalue = dict[key]
        s = "$index), $key: $keyvalue"
        p(s)
    end
end

function printKeys(keyCollection, dict)
    for key in keyCollection
        keyvalue = dict[key]
        printKeyAndValue(key,keyvalue)
    end
end

function printKeyAndValue(key,value)
    if !occursin(";",value)
        p("$key: $value")
        return
    end
    p(key)
    valueArray = split(value,";")
    foreach(x -> p("\t $x"),valueArray)
    p("")
end
#=
*******************************************************
* End: Key utilities
*******************************************************
=#


#=
*******************************************************
* Drivers
*******************************************************
=#

function testOccursIn()
    s = "how about this"
    yesOrNo = occursin("about",s)

    #prints true
    p(yesOrNo)
end

function runMainProc()
    hp("Program Start")
    mainproc()
    #test()
    hp("Program End")
end
#calling the function
runMainProc()

#=
***********************************************************************
* Output
***********************************************************************
* Will produce output like this

Program Start
*************************************
Search ENV string:
julia
Searchign env for: julia

Env keys matching: julia
*************************************
ATOM_HOME
JULIA_DEPOT_PATH
JULIA_EDITOR
JULIA_NUM_THREADS
JULIA_PKG_SERVER
JULIPRO_HOME
JUNORC_PATH
NODE_PATH
PATH

Matching Env  Key Values
*************************************
ATOM_HOME: C:\satya\i\julia142\.atom
JULIA_DEPOT_PATH
         C:\Users\satya\.juliapro\JuliaPro_v1.4.2-1
         C:\satya\i\julia142\Julia-1.4.2\local\share\julia
         C:\satya\i\julia142\Julia-1.4.2\share\julia

JULIA_EDITOR: "C:\satya\i\julia142\app-1.47.0\atom.exe"  -a
JULIA_NUM_THREADS: 4
JULIA_PKG_SERVER: pkg.juliacomputing.com
JULIPRO_HOME: "C:\Users\satya\.juliapro\JuliaPro_v1.4.2-1"
JUNORC_PATH: C:\satya\i\julia142\.atom
NODE_PATH: C:\satya\i\julia142\app-1.47.0\resources\app.asar\exports
PATH
         C:\Windows\system32
         C:\Windows
         ....
         C:\satya\i\julia142\Julia-1.4.2\bin
         C:\satya\data\utils\jl
         C:\satya\i\python374\Scripts\
         C:\satya\i\python374\
         ...
         C:\satya\i\nvm
         C:\satya\i\nodejs

Program End
***********************************************************************
=#
