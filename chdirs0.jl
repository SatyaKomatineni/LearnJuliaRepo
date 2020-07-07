#=
*******************************************************
* First function in Julia
* This is a comment block
*******************************************************
=#
#simple line comment

#using DataStructures
using DataStructures

#simple variable
x = 10

#=
cmdArray = [
    "vscode" "createVSCodeCommand";
    "psutils" "C:\satya\data\code\power-shell-scripts";
]

=#

cmdArray = [
    "vscode" "createVSCodeCommand";
    "psutils" "C:\\satya\\data\\code\\power-shell-scripts"
]


cmds = OrderedDict([
    ("vscode","createVSCodeCommand"),
    ("psutils","C:\\satya\\data\\code\\power-shell-scripts")
])

#=
home = 'c:\satya'
pslearn = 'C:\satya\data\code\power-shell-scripts\individual\satya\learn'
plnutils = 'C:\satya\data\code\jakarta\general-repo\utils'
plnftp = 'C:\satya\data\code\jakarta\ftp\plant1\stage'
plnsamplefiles = 'C:\satya\data\code\jakarta\general-repo\requirements\samplefiles\windplant1'
vsworkspaces = "C:\satya\data\code\vs-workspaces"
shortcuts="C:\Users\satya\OneDrive\Desktop\shortcuts"
pln_googledrive="C:\Users\satya\Google Drive\2019\private\projects\jakarta"
pln_shared_gdrive="C:\Users\satya\Google Drive\external\vre\vrepln"
kreate_big_data="C:\satya\data\code\kreate-gitlab1\big-data-deck"
test_func=createTestFunc
=#

#function definiton
function testfunction(name)
    println(name)
    Base.println("This is test")

    #see what diretory we are in
    #Base.Filesystem.pwd
    println(pwd())
    print(cmdArray)
    print(typeof(cmdArray))
    println("")
    print(cmds)
end

#calling the function
testfunction("satya")
