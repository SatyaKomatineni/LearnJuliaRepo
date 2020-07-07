#=
*******************************************************
* Ninth Function: simple-grep.jl
*
* 1. A simple grep for DOS command line
*
* Maturity
* **************
* 1. Very very early learning exercise
* 2. There are probably a 1000 ways to make this better
*
* Related Files
* jgrep.bat : wraps julia REPL
* Allows usage: dir | jgrep <some-part-of-a-filename>
*
*******************************************************
=#

function mainproc()
    #simpleGrep("hello")
    res = validateArgs()
    if res == false
        p("Requires a search string")
        return
    end
    searchString = ARGS[1]
    p("Searc results for '$searchString'")
    p("")
    simpleGrep(searchString)
end

function simpleGrep(grepString)
    casInsensitiveSearchString = Regex(grepString,"i")
    for line in eachline(stdin)
        if (occursin(casInsensitiveSearchString, line) == true)
            p(line)
        end
    end
end

function validateArgs()
    len = length(ARGS)
    #p("Number of args: $len")
    if len == 0 return false end
    return true
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
***********************************************************

@rem Begining of batch file
@echo off
@rem *****************************************************
@rem jgrep.bat
@rem
@rem usage
@rem 
@rem dir | jgrep search-filename-sring
@rem set | jgrep search-env-variable-string
@rem
@rem *****************************************************

@rem setup where the .jp file is
@set jgrepfile=C:\satya\data\utils\jl\simple-grep.jl

julia %jgrepfile% %1%
@rem end of batch file

***********************************************************
=#
