@echo off
@rem *****************************************************
@rem jgrep.bat
@rem
@rem usage
@rem jgrep search-sring
@rem
@rem *****************************************************

@rem setup where the .jp file is
@set jgrepfile=C:\satya\data\utils\jl\simple-grep.jl

julia %jgrepfile% %1%
