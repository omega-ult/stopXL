@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
		goto UACPrompt
		) else ( goto gotAdmin )
:UACPrompt
	echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	exit /B
	:gotAdmin
	if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
	pushd "%CD%"
	CD /D "%~dp0"

:-----------------------

call taskkill /f /t /im Thunder.exe
call sc config XLServicePlatform start=demand
call sc config XLNXService start=demand
call sc stop XLServicePlatform
call sc stop XLNXService
