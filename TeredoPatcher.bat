@ECHO OFF
mode con: cols=100 lines=20

:reload
cls
echo ================================
echo //   TEREDO ADAPTER PATCHER   //
echo //         by Jayk0b          //
echo ================================
echo =        (Run as admin)        =
echo ================================
echo = 1 = Config Teredo Adapter    =
echo = 2 = Check Adapter            =
echo ================================
set /p choice="ENTER NUMBER: "
IF "%choice%"=="1" goto config
IF "%choice%"=="2" goto check
IF %ERRORLEVEL% EQU 0 goto reload
IF %ERRORLEVEL% EQU 1 goto reload

:config
@ping -n 4 localhost> nul
echo Setting teredo adapter to "Enterprise Client"
netsh interface teredo set state type=enterpriseclient

@ping -n 2 localhost> nul
netsh interface teredo show state
echo IF STATUS SHOWS: "qualified" press "1" and check XBOX Network again.
echo IF teredo status is still: "offline" continue and press "2"
set /p choice="ENTER NUMBER: "
IF "%choice%"=="1" goto exit
IF "%choice%"=="2" goto repair
IF %ERRORLEVEL% EQU 0 goto reload
IF %ERRORLEVEL% EQU 1 goto reload
echo ---------------------------------------------

:repair
@ping -n 4 localhost> nul
echo Disable teredo adapter
netsh interface Teredo set state disable

@ping -n 4 localhost> nul
echo Setting teredo adapter to state default
netsh interface Teredo set state type=default


@ping -n 4 localhost> nul
echo Setting teredo adapter Server to: win10.ipv6.microsoft.com
netsh interface teredo set state servername=win10.ipv6.microsoft.com


echo Teredo adapter state:
@ping -n 2 localhost> nul
netsh interface teredo show state
echo ---------------------------------------------

echo = Teredo adapter configured, you need to restart the machine!
set /p choice="Do you want to restart now? Y/N [ENTER]: "
IF "%choice%"=="Y" goto restart_machine
IF "%choice%"=="N" goto no_restart
IF %ERRORLEVEL% EQU 0 goto reload
IF %ERRORLEVEL% EQU 1 goto reload
goto :reload

:check
echo Teredo adapter state:
@ping -n 2 localhost> nul
netsh interface teredo show state
echo ---------------------------------------------

@ping -n 2 localhost> nul
echo Press any button to return to menu
pause

goto reload

:restart_machine
shutdown.exe /r /t 00

pause

:exit
exit



