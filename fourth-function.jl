#=
*******************************************************
* Fourth function in Julia
*
* Motivation
* ************
* This fourth function came about because I want to
* optimize looking up a key in an ordered Dictionary
* using its index and not by key name.
*
* This required the function to prefetch and store it
* in a local variable whose state is maintained
* between multiple invocations.
*
* In other words a stateful function.
*
* In python such stateful functions I hear
* can be  implemented using yield key words
* such functions are also called generatros
*
* answer
* ****************
* In OO like java one would implment such a function
* in a static class or an object that keeps the state.
*
* In Julia also the state for a function can be maintained
* it appears in a type (class in OO) and follows a similar
* pattern.
*
* This code demonstrates this idea while exposing other
* syntactical examples as well
*
* This function demonstrate in addition
* **************************************
* 1. How to create a struct/type/object/class
* 2. How to write a constructor
* 3. How to wrap another type or object
* 4. How to attach functions to a type as one would in OO
* 5. How to implement operator function for indexing []
* 6. One way to solve the stateful function
*
*******************************************************
=#
#simple line comment

#using DataStructures
using DataStructures
import Base.getindex

#*******************************************
# Ordered Dictionary or hashtable
# keeps the keys in order
# I want to accesss the values using indexes as well
#*******************************************
cmds = OrderedDict([
    ("vscode","createVSCodeCommand"),
    ("psutils","C:\\satya\\data\\code\\power-shell-scripts")
])

#=
*******************************************************
* You will need a place to keep the keys as an array
* The OrderedDict doesn't have indexing
* You don't want this array to be constructed everytime
* So in the constructor gather those keys and keep them in the object
*******************************************************
=#
struct IndexedOrderDict
    keysArray::AbstractArray #syntax name::type
    dict::OrderedDict

    #this is called an inner constructor
    function IndexedOrderDict(dict::OrderedDict)
        keysArray = collect(keys(dict))
        new(keysArray,dict) #ONLY way to init the variables
    end
end

#=
*******************************************************
* Further commentary on types
* 1. default constructor takes the variables
* identified in struct as input args
*
* 2. The constructor above is called inner constructor
* 3. Inner constructor does not have access to local variables
* 4. It has to call the defaul "new" which is the default constructotr
* 5. Outside of the type the default constructor name is
* is the name of the struct itself
*
* The above type now has 2 constructors
* One default
* One inner
*
*******************************************************
=#

#=
*******************************************************
* Lets attach the [] operation on the dictionary wrapper
* Julia translates obj[i] to Base.getindex(obj, i)
*
* So we need to define (Override) getindex for this type so that
* you can do dict[7] -> translates to getindex on that type
*
* This code demonstrates
* **********************
* 1. how to override a base generic function
* 2. How variables of a type are accessed through . symbol
*******************************************************
=#
function Base.getindex(d::IndexedOrderDict, index::Int)
    keyname = d.keysArray[index]
    keyvalue = d.dict[keyname]
    return keyvalue
end

#=
*******************************************************
* Now we can make use o fthe wrapper class (struct)
* so that the [] or the getindex can use the wrapper
* to manage its state between
* dict[1] and dict[2] the multiple calls
*
* This code demonstrates
* **********************
* 1. Instantiate a type through inner constructor
* 2. Calling the getindex via the [] operator
* 3. Managing the state between multiple [] calls
*******************************************************
=#

function testGetValueByIndex()
    #Instantiate the opritmized wrapper
    dict = IndexedOrderDict(cmds)

    #Call the getindex any number of times
    dir = dict[1]
    println(dir)

    dir = dict[2]
    println(dir)
end

testGetValueByIndex()
