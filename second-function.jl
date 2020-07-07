#=
*******************************************************
* Second function in Julia
*
* Initialize and walk through an ordered Dictionary
*
* This is a comment block
*
*******************************************************
=#
#simple line comment

#using DataStructures
using DataStructures

#array init
cmdArray = [
    "vscode" "createVSCodeCommand";
    "psutils" "C:\\satya\\data\\code\\power-shell-scripts"
]

#Ordered Dictionary or hashtable
#keeps the keys in order
cmds = OrderedDict([
    ("vscode","createVSCodeCommand"),
    ("psutils","C:\\satya\\data\\code\\power-shell-scripts")
])

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
    for key in keysIter
        println(key)
    end
end

#calling the function
testfunction("satya")

#=
*******************************************************
* Key observations
* *****************************
* 1. You have to understand packages a little to pull in a package
* using add package.
* 2. functions are independent of objects/types
* 3. So you cant say Dict.keys()
* 4. you have to say keys(Dict)
* 5. functions are organized  into modules
* 6. So keys() is a function in Base.keys()
* 7. Look for cheatsheets where ALL functions can be glanced quickly
* 8. The online manual has a search where you can type Base. and
* that will list all functions in that module
*
* Good luck!
*******************************************************
=#
