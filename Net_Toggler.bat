@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=
REM BFCPEICON=
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=0
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=0
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Product Name
REM BFCPEVERDESC=Product Description
REM BFCPEVERCOMPANY=Your Company
REM BFCPEVERCOPYRIGHT=Copyright Info
REM BFCPEOPTIONEND
@ECHO ON
@echo off
rem This script toggle a network adaptor on specefied times

title "Net Toggler"


rem running the script as admin
rem >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
rem IF '%errorlevel%' NEQ '0' (
rem goto UACPrompt
rem ) ELSE ( goto gotAdmin )
rem :UACPrompt
rem echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
rem echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
rem "%temp%\getadmin.vbs"
rem exit /B
rem :gotAdmin
rem IF exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )

rem hiding program window
rem nircmd.exe win hide ititle "Net Toggler"


setlocal EnableExtensions EnableDelayedExpansion

rem variables:
rem net= Name of the network adaptor.
rem ontime= When network should be turned off.
rem offtime= When network should be turned on.

set net="Wi-Fi 2"
set "ontime=11:00:00.0"
set "offtime=01:00:00.0"

rem infinite loop
for /L %%n in (1,0,10) do (
	set "currentTime=!Time: =0!"
	rem echo !currentTime!
	IF not defined last_task (
		IF !currentTime! geq %offtime% (
			IF !currentTime! lss %ontime% (
				netsh interface set interface %net% disable
				set "last_task=disable"
				echo !currentTime! %net% !last_task!d
			) ELSE (
				netsh interface set interface %net% enable
				set "last_task=enable"
				echo !currentTime! %net% !last_task!d
			)
		) ELSE (
			netsh interface set interface %net% enable
			set "last_task=enable"
			echo !currentTime! %net% !last_task!d
		)
	)
	
	IF !last_task!==disable (
		IF !currentTime! lss  %offtime% (
			netsh interface set interface %net% enable
			set "last_task=enable"
			echo !currentTime! %net% !last_task!d
		)
		IF !currentTime! gtr  %ontime% (
			netsh interface set interface %net% enable
			set "last_task=enable"
			echo !currentTime! %net% !last_task!d
		) 
	)
  
	IF !last_task!==enable (
		IF !currentTime! geq  %offtime% ( 
			IF !currentTime! lss %ontime% (
				netsh interface set interface %net% disable
				set "last_task=disable" 
				echo !currentTime! %net% !last_task!d
			)
		)
	)
	sleep 5
	rem call :stop
)

:stop
call :__stop 2>nul

:__stop
() creates a syntax error, quits the batch

pause
