::¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸
::
::    File Name:  day-logger.bat
::   Created By:  Facets Batch Support (Chace Prochazka (CPRO))
::   Created On:  June 02, 2008
::
::¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨
::
:: Update Descr: Added Search capability to search all logs
::  Update Date: June 24, 2008
::    Update By: CPRO
::
::¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸

@ECHO OFF
@SET _path=%CD%
@SET _filename=%DATE%
@SET _filename=%_filename:/=-%
@SET _filename=%_filename: =-%
@SET _complete_path=%_path%\%_filename%.txt

@GOTO :ShowMenu


::¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸
:: PRINT MENU OPTIONS
::¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨

:ShowMenu
@CLS
@ECHO *===============================================================================================*
@ECHO      Today's log is: %_complete_path%
@ECHO *===============================================================================================*
@ECHO       MENU  -  CHOOSE AN ITEM AND PRESS ENTER
@ECHO *===============================================================================================*
@ECHO    1  -  Make New Log Entry
@ECHO    2  -  View Today's Log in Command Window
@ECHO    3  -  Open Today's Log File in Notepad
@ECHO    4  -  View a Previous Day's Log File in Command Window
@ECHO    5  -  View a Previous Day's Log File in Notepad
@ECHO    6  -  Search all daily logs
@ECHO    7  -  Exit
@ECHO *===============================================================================================*

@SET /P _option=[ Enter Menu Choice ]

@if %_option% LSS 1 goto :NotValidOption
@if %_option% EQU 1 goto :NewLogEntry
@if %_option% EQU 2 goto :PrintLog
@if %_option% EQU 3 goto :OpenLog
@if %_option% EQU 4 goto :OpenPrevLogWindow
@if %_option% EQU 5 goto :OpenPrevLog
@if %_option% EQU 6 goto :SearchLogs
@if %_option% EQU 7 goto :Goodbye
@if %_option% GTR 7 goto :NotValidOption


::¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸
:: MENU ITEMS
::¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨

:NewLogEntry
@CLS
@ECHO *===============================================================================================*
@ECHO      New Log Entry:
@ECHO *===============================================================================================*
@SET /P _new_entry=[Enter Log Entry Now and Press Enter]
@if EXIST %_filename%.txt (
@ECHO %time% - %_new_entry% >> %_filename%.txt
) else (
@ECHO %time% - %_new_entry% > %_filename%.txt
)
@GOTO :ShowMenu

:PrintLog
@CLS
@ECHO *===============================================================================================*
@ECHO      Today's Log:
@ECHO *===============================================================================================*
@TYPE %_filename%.txt
@PAUSE
@GOTO :ShowMenu

:OpenPrevLogWindow
@CLS
@SETLOCAL ENABLEDELAYEDEXPANSION
@ECHO *===============================================================================================*
@ECHO      Listing all existing logs, find desired and enter number . . .
@ECHO *===============================================================================================*
@SET count=0
@FOR /R "%_path%" %%G IN (*.txt) DO (
 ECHO %%G > _!count!.var
 ECHO !count!: & TYPE _!count!.var
 SET /A count=count+1
)
@SET /P _old_log=[Enter Log Number to See and Press Enter]
@SET /P _tempvar=<"%_path%\_%_old_log%.var"  
@CLS
@ECHO *===============================================================================================*
@ECHO      Showing Log File . . .
@ECHO *===============================================================================================*
@TYPE "%_tempvar%"
@PAUSE
@SET count=0
@FOR /R "%_path%" %%G IN (*.txt) DO (
 DEL _!count!.var
 SET /A count=count+1
)
@ENDLOCAL
@GOTO :ShowMenu

:OpenPrevLog
@CLS
@SETLOCAL ENABLEDELAYEDEXPANSION
@ECHO *===============================================================================================*
@ECHO      Listing all existing logs, find desired and enter number . . .
@ECHO *===============================================================================================*
@SET count=0
@FOR /R "%_path%" %%G IN (*.txt) DO (
 ECHO %%G > _!count!.var
 ECHO !count!: & TYPE _!count!.var
 SET /A count=count+1
)
@SET /P _old_log=[Enter Log Number to See and Press Enter]
@SET /P _tempvar=<"%_path%\_%_old_log%.var"  
@NOTEPAD %_tempvar%
@SET count=0
@FOR /R "%_path%" %%G IN (*.txt) DO (
 DEL _!count!.var
 SET /A count=count+1
)
@ENDLOCAL
@GOTO :ShowMenu

:OpenLog
@CLS
@ECHO *===============================================================================================*
@ECHO      Opening Today's Log . . .
@ECHO *===============================================================================================*
NOTEPAD %_complete_path%
@GOTO :ShowMenu

:SearchLogs
@CLS
@ECHO *===============================================================================================*
@ECHO      Enter the string you are looking for and press enter to search all logs
@ECHO *===============================================================================================*
@SET /P _searchstring=[Enter Search String]
@ECHO *===============================================================================================*
@ECHO      Searching for [%_searchstring%] now . . .
@ECHO *===============================================================================================*
@FINDSTR %_searchstring%  *.txt > search_results.sea
@NOTEPAD search_results.sea
@DEL search_results.sea
@GOTO :ShowMenu

::¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸
:: ERROR MESSAGES ISSUED
::¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨¨´°¹*¬·._¸¸_.·¬*¹°´¨

:NotValidOption
@ECHO *===============================================================================================*
@ECHO      ERROR!
@ECHO *===============================================================================================*
@ECHO There is no option '%_option%' in this program, please try again . . .
@ECHO *===============================================================================================*
@PAUSE
@GOTO :ShowMenu

:ErrorA
@ECHO *===============================================================================================*
@ECHO      ERROR!
@ECHO *===============================================================================================*
@ECHO There was an ERROR in the batch-file, quitting...
@ECHO Return Code: 8
@ECHO *===============================================================================================*
@Exit 8

:Goodbye
@CLS
@ECHO *===============================================================================================*
@ECHO      You have chose to EXIT, goodbye!
@ECHO *===============================================================================================*
@PAUSE
@EXIT