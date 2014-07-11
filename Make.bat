@ECHO off

:: Project Name
SET PROJ_NAME=SampleProject

:: Adictional Libraries
SET LIB=

:: Processor Architcture
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	SET ARCH=64
) ELSE (
	SET ARCH=32
)


SET LDIR=
SET IDIR=-I.\include\
SET CXXFLAGS=-Wextra -Ofast -std=c++11
SET GAME=.\bin\%PROJ_NAME%.exe

:: Xross detection
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	IF "%ARCH%"=="32" (
		SET XROSS=true
	) ELSE (
		SET XROSS=false
	)
) ELSE (
	SET XROSS=false
)

if "%2"=="xross" (
	SET XROSS=true
)

:: cURL Finder
::
:: We use cURL to find and install dependencies automagically :D
IF "%MSYS%"=="" (
	:: Default MSYS
	IF EXIST "%HOMEDRIVE%\MSYS\bin\curl.exe" (
		SET CURL="%HOMEDRIVE%\MSYS\bin\curl.exe"
	) ELSE (
		IF EXIST "%HOMEDRIVE%\MINGW\bin\curl.exe" (
			SET CURL="%HOMEDRIVE%\MINGW\bin\curl.exe"
		) ELSE (
			IF EXIST "%HOMEDRIVE%\TDM-GCC-64\bin\curl.exe" (
				SET CURL="%HOMEDRIVE%\TDM-GCC-64\bin\curl.exe"
			) ELSE (
				IF EXIST "%HOMEDRIVE%\TDM-GCC\bin\curl.exe" (
					SET CURL="%HOMEDRIVE%\TDM-GCC\bin\curl.exe"
				) ELSE (
					IF EXIST "%CD%\curl.exe" (
						SET CURL="%CD%\curl.exe"
					) ELSE (
						ECHO cURL was not found.
						GOTO :end
					)
				)
			)
		)
	)
) ELSE (
	SET CURL="%MSYS%\bin\curl.exe"
)

:: Later warning
IF NOT EXIST %CURL% (
	ECHO Can't FIND curl.exe :(
	GOTO :end
)

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

IF "%CXX%"=="" (
	IF "%MINGW%"=="" (
		:: Default MSYS
		IF EXIST "%HOMEDRIVE%\TDM-GCC-64\bin\g++.exe" (
			SET CXX="%HOMEDRIVE%\TDM-GCC-64\bin\g++.exe"
			SET WIND="%HOMEDRIVE%\TDM-GCC-64\bin\windres.exe"
		) ELSE (
			IF EXIST "%HOMEDRIVE%\TDM-GCC\bin\g++.exe" (
				SET CXX="%HOMEDRIVE%\TDM-GCC\bin\g++.exe"
			SET WIND="%HOMEDRIVE%\TDM-GCC\bin\windres.exe"
			) ELSE (
				IF EXIST "%HOMEDRIVE%\MINGW64\bin\g++.exe" (
					SET CXX="%HOMEDRIVE%\MINGW64\bin\g++.exe"
					SET WIND="%HOMEDRIVE%\MINGW64\bin\windres.exe"
				) ELSE (
					IF EXIST "%HOMEDRIVE%\MINGW\bin\g++.exe" (
						SET CXX="%HOMEDRIVE%\MINGW\bin\g++.exe"
						SET WIND="%HOMEDRIVE%\MINGW\bin\windres.exe"
					) ELSE (
						ECHO MinGW was not found.
						GOTO :end
					)
				)
			)
		)
	) ELSE (
		SET CXX="%MINGW%\bin\g++.exe"
	)
)

:: Later warning
IF NOT EXIST %CXX% (
	ECHO Can't find g++.exe :(
	GOTO :end
)

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

SET ZIP=".\7z.exe"
IF EXIST "%PROGRAMFILES(X86)%\7-Zip\7z.exe" SET ZIP="%PROGRAMFILES(X86)%\7-Zip\7z.exe"
IF EXIST "%PROGRAMFILES%\7-Zip\7z.exe"  SET ZIP="%PROGRAMFILES%\7-Zip\7z.exe"

SET ZIP=".\7z.exe"
IF %ZIP%=="" (
	ECHO "This file depends on 7ZIP, GCC-TDM and CURL."
	GOTO :end
)

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
SET TASK=%1
SET CB=end
:task_controller
:: Router
IF "%TASK%"=="" (
	SET TASK=deploy
	GOTO :default
) ELSE (
	IF "%TASK%"=="deps" (
		GOTO :deps
	) ELSE (
		IF "%TASK%"=="res" (
			GOTO :res
		) ELSE (
			IF "%TASK%"=="obj" (
				GOTO :obj
			) ELSE (
				IF "%TASK%"=="deploy" (
					SET TASK=deploy
					GOTO :default
				) ELSE (
					IF "%TASK%"=="debug" (
						SET TASK=debug
						GOTO :default
					) ELSE (
						IF "%TASK%"=="test" (
							GOTO :test
						) ELSE (
							IF "%TASK%"=="clean" (
								GOTO :clean
							) ELSE (
								IF "%TASK%"=="clobber" (
									GOTO :clobber
								) ELSE (
									GOTO :error
								)
							)
						)
					)
				)
			)
		)
	)
)

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:callback
GOTO %CB%
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:default

if "%XROSS%"=="true" (
	SET LIBR=-L.\lib\32
) ELSE (
	SET LIBR=-L.\lib\%ARCH%
)

:: try to build what is not built
SET CB=link_cb
GOTO :obj
:link_cb

:: prepare the app icon
SET CB=res_cb
GOTO :res
:res_cb

:: get Every Object
SETLOCAL enabledelayedexpansion enableextensions
SET LIST=
FOR %%x in (.\obj\*.o) do SET LIST=!LIST! %%x
SET LIST=%LIST:~1%
GOTO %TASK%
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:deps
CMD /C IF NOT EXIST .\tmp MKDIR .\tmp

IF "%ARCH%"=="32" (
	:: Downloads 32 bits libraries
	IF NOT EXIST ".\tmp\32.zip" (
		ECHO Downloading SFML for i386 processors.
		%CURL% http://www.sfml-dev.org/download/sfml/2.1/SFML-2.1-windows-gcc-4.7-tdm-32bits.zip > .\tmp\32.zip
	) ELSE (
		ECHO Cached SFML i386 found!
	)
	%ZIP% x .\tmp\32.zip -o%CD%\tmp -y >NUL 2>&1
) ELSE (
	:: Downloads 64 bits libraries
	IF NOT EXIST ".\tmp\64.zip" (
		ECHO Downloading SFML for amd64 processors.
		%CURL% http://www.sfml-dev.org/download/sfml/2.1/SFML-2.1-windows-gcc-4.7-tdm-64bits.zip > .\tmp\64.zip
	) ELSE (
		ECHO Cached SFML amd64 found!
	)
	ECHO Extracting...
	%ZIP% x .\tmp\64.zip -o%CD%\tmp -y >NUL 2>&1

	IF NOT EXIST .\lib\64 MKDIR .\lib\64

	:: Nondefault 64 bits dynamic libraries
	ECHO Installing amd64 dll files...
	COPY /y .\tmp\SFML-2.1\bin\*.dll .\lib\64\ >NUL 2>&1

	:: Install 64 bits libraries
	ECHO Installing amd64 libraries...
	DEL /Q .\tmp\SFML-2.1\lib\*-s.a >NUL 2>&1
	DEL /Q .\tmp\SFML-2.1\lib\*-s-d.a >NUL 2>&1
	XCOPY /Q /I /Y .\tmp\SFML-2.1\lib\*.a .\lib\64\ >NUL 2>&1
)

:: Install Headers
ECHO Installing headers...
IF NOT EXIST .\include\SFML MKDIR .\include\SFML
XCOPY /I /Y /E .\tmp\SFML-2.1\include\SFML .\include\SFML >NUL 2>&1

:: End here XD
IF "%ARCH%"=="64" (
	ECHO Native architecture install complete!
	IF NOT "%2"=="xross" (
		GOTO end
	) ELSE (
		ECHO Xrossing the project...
		:: Xross Compile Method
		IF NOT EXIST ".\tmp\32.zip" (
			ECHO Downloading SFML for i386 processors.
			%CURL% http://www.sfml-dev.org/download/sfml/2.1/SFML-2.1-windows-gcc-4.7-tdm-32bits.zip > .\tmp\32.zip
		) ELSE (
			ECHO Cached SFML i386 found!
		)
		ECHO Extracting...
		%ZIP% x .\tmp\32.zip -o%CD%\tmp -y >NUL 2>&1
	)
)

IF NOT EXIST .\lib\32 MKDIR .\lib\32

:: Default 32 bits dynamic libraries
ECHO Installing i386 dll files...
COPY /y .\tmp\SFML-2.1\bin\*.dll .\lib\32\ >NUL 2>&1

:: Install 32 bits libraries
ECHO Installing i386 libraries...
DEL /Q .\tmp\SFML-2.1\lib\*-s.a >NUL 2>&1
DEL /Q .\tmp\SFML-2.1\lib\*-s-d.a >NUL 2>&1
XCOPY /I /Y .\tmp\SFML-2.1\lib\*.a .\lib\32\ >NUL 2>&1

IF "%ARCH%"=="64" ( ECHO Xrossing complete! )
ECHO Dependencies installed, now get to work :D
GOTO :end
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:res
IF "%XROSS%"=="true" (
	%WIND% Resource.rc -O coff --target=pe-i386 -o .\bin\%PROJ_NAME%.res
) ELSE (
	%WIND% Resource.rc -O coff -o .\bin\%PROJ_NAME%.res
)
GOTO :callback
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:dll
IF EXIST .\bin (
	IF "%ARCH%"=="64" (
		IF "%XROSS%"=="true" (
			xcopy /I /Y .\lib\32\*.dll .\bin\ >NUL 2>&1
		) ELSE (
			xcopy /I /Y .\lib\64\*.dll .\bin\ >NUL 2>&1
		)
	) ELSE (
		xcopy /I /Y .\lib\32\*.dll .\bin\ >NUL 2>&1
	)
) ELSE (
	ECHO You need to build the game first.
)
GOTO :end
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =


:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:obj
IF NOT EXIST .\obj\ MKDIR .\obj\
FOR %%f in (./src/*.cpp) do (
	IF "%XROSS%"=="true" (
		%CXX% %CXXFLAGS% -m32 -DWindowsOS %IDIR% -c ./src/%%f -o ./obj/%%~nf.o
	) ELSE (
		%CXX% %CXXFLAGS% -DWindowsOS %IDIR% -c ./src/%%f -o ./obj/%%~nf.o
	)
)
GOTO :callback
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
: debug
IF NOT EXIST .\bin MKDIR bin
SET SFML=-lsfml-network-d -lsfml-graphics-d -lsfml-window-d -lsfml-system-d
IF "%XROSS%"=="true" (
	%CXX% %CXXFLAGS% -m32 -DWindowsOS %LDIR% %LIBR% %LIST% .\bin\%PROJ_NAME%.res %SFML% %LIB% -o %GAME%
) ELSE (
	%CXX% %CXXFLAGS% -DWindowsOS %LDIR% %LIBR% %LIST% .\bin\%PROJ_NAME%.res %SFML% %LIB% -o %GAME%
)
GOTO :dll
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:deploy
IF NOT EXIST .\bin MKDIR bin
SET SFML=-lsfml-network -lsfml-graphics -lsfml-window -lsfml-system
IF "%XROSS%"=="true" (
	%CXX% %CXXFLAGS% -m32 -DWindowsOS %LDIR% %LIBR% %LIST% .\bin\%PROJ_NAME%.res %SFML% %LIB% -o %GAME%
) ELSE (
	%CXX% %CXXFLAGS% -DWindowsOS %LDIR% %LIBR% %LIST% .\bin\%PROJ_NAME%.res %SFML% %LIB% -o %GAME%
)
GOTO :dll
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =


:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:test
%GAME%
GOTO :end
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:clean
DEL /Q %GAME% >NUL 2>&1
RMDIR /Q /S bin >NUL 2>&1
RMDIR /Q /S obj >NUL 2>&1
IF "%2"=="cache" ( RMDIR /Q /S tmp >NUL 2>&1 )
GOTO :end
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:clobber
DEL /Q %GAME% >NUL 2>&1
RMDIR /Q /S bin >NUL 2>&1
RMDIR /Q /S obj >NUL 2>&12>&1
RMDIR /Q /S lib >NUL 2>&1
RMDIR /Q /S include\SFML >NUL 2>&1
IF "%2"=="cache" ( RMDIR /Q /S tmp >NUL 2>&1 )
GOTO :end
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =


:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:error
if "%1"=="xross" (
	SET XROSS=true
	SET TASK=deploy
	GOTO :default
)

ECHO make: *** No rule to make target `%1'.  Stop.
GOTO :end
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
:end
@ECHO on
:: = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =