@echo off
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
@rem vdir: variable for keeping the directory name
@set /p vdir=<%tfile%

@rem if the directory is "none" then there is Nothing
@rem for this program to change directory to.
if "%vdir%" == "none" goto nothing

@echo Changing directory to %vdir%
@cd %vdir%
goto done

:nothing
@echo No need to change changeDirectory

:done
