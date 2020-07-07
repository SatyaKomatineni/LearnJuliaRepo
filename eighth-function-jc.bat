@rem *****************************************************
@rem Something about a batch file
@rem this is a complement
@rem a simple @ at the begining of a line will exec that command silently
@rem *****************************************************

@rem setup a directory for the control file
@set td=C:\satya\data\utils\jl

@rem look for a filename
@set tfile=%td%\transfer-commands.txt

@rem read the file into a variable
@set /p vdir=<%tfile%

@echo Changing directory to %vdir%
@cd %vdir%
