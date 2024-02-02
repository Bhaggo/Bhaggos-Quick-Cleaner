@echo off
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if %errorlevel% NEQ 0 (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"
:menu
color 09
mode 300
color 1F
title Bhaggo's Quick Cleaner         
msg %user% Thanks for using my software @BhaggoYT on YouTube
cls
echo.* * * * * * * * * * * * * * * * * * * * * * * * * * 
echo * "______________                               ";* 
echo * "___  __ )__  /_______ _______ _______ ______ ";* 
echo * "__  __  |_  __ \  __ `/_  __ `/_  __ `/  __ \";* 
echo * "_  /_/ /_  / / / /_/ /_  /_/ /_  /_/ // /_/ /";* 
echo * "/_____/ /_/ /_/\__,_/ _\__, / _\__, / \____/ ";*
echo * "                      /____/  /____/         ";*  
echo.* * * * * * * * * * * * * * * * * * * * * * * * * * 

echo.
echo *********************************
color 09
echo.
echo  Enter [1] for creating a restore point ( IMPORTANT! )
echo.
echo  Enter [2] for clearing basic cache
echo.
echo  Enter [3] for removing bloatware and animations and maximizing FPS
echo.
echo  Enter [4] for less delay to your mouse and keyboard
echo.
echo  Enter [5] for clearing your DNS cache
echo.
echo *********************************
echo.
echo !! HARD CLEAN !!
echo.
echo  Enter [6] for clearing all forms of PC cache ( MAY DELETE GAMES OR APPS! )( HARD CLEAN )
echo.
echo  Enter [7] for clearing your DNS cache and internet cache ( MAY DELETE GAMES OR APPS! )( HARD CLEAN )
echo.
echo *********************************
echo.
echo. Enter [69] to see what my program offers (Ver 1.0)
echo.
echo. Enter [420] to shut down your computer (make sure to turn it on to see the results)
echo.
echo  Enter [0] to quit the program.
echo.
echo *********************************

set /p ans="Enter Number: "

if "%ans%"=="1" goto restorepoint
if "%ans%"=="2" goto basic_clean
if "%ans%"=="3" goto bloat
if "%ans%"=="4" goto delay
if "%ans%"=="5" goto basic_wifi_clean
if "%ans%"=="6" goto hard_clean
if "%ans%"=="7" goto hard_wifi_clean
if "%ans%"=="69" goto about
if "%ans%"=="420" goto shutdown
if "%ans%"=="0" goto quit
echo Invalid answer
pause
goto menu

:restorepoint
cls
call :IsAdmin
echo Go and create a restore point
start C:\Windows\System32\SystemPropertiesProtection.exe
start C:\WINDOWS\regedit.exe
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Bhaggo Restore Point", 100, 7
powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'Bhaggo Restore Point' >nul 2>&1
cls
echo Make sure you create a restore point before continuing!!
timeout /t 3
goto menu

:basic_clean
cls
echo You are clearing log files (WAIT UNTIL PROCESSED)
cd/
@echo
del *.log /a /s /q /f
cls
echo Log files cleared!
timeout /t 3
goto menu

:basic_wifi_clean
cls
echo You are clearing your dns cache
ipconfig /flushdns
cls
echo You flushed your DNS cache!
timeout /t 3
goto menu

:bloat
cls
echo You are adding registry files to disable bloat
call :IsAdmin
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "Win32_AutoGameModeDefaultProfile" /t REG_BINARY /d "01000100000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "Win32_GameModeRelatedProcesses" /t REG_BINARY /d "010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "GameDVR_Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowgameDVR" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f 
Reg.exe add "HKCU\System\GameConfigStore\Children\008af23d-f4cc-4435-9422-b95fecf4b177" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\008af23d-f4cc-4435-9422-b95fecf4b177" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\008af23d-f4cc-4435-9422-b95fecf4b177" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\008af23d-f4cc-4435-9422-b95fecf4b177" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000002000a2aa3fc105db7031bdec104bf4abb2ac2ec9ba61470eaa47e35f70470739000000000e80000000020000200000004c4c9bb247edfba288821848b8a5ac4c179afe56042f12cbbd160f504413172d40000000a37e3ef9d3ecec8d6e0a7c3810ce8fec7dd8a95ff8e32733462e46c510bc9c0c679869e43b9b0a5c5847d7566a480d4c460ff7d091dc9e59cfabf33e18852ed3400000006268d09da61abb457e96064d252ad099ba4e7c6b718221ed28d82b2c4c88af2dada82ff5c82cf409174a6138b36d044dc9ed793a87e11cd91a0f691f2d25842d" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\008af23d-f4cc-4435-9422-b95fecf4b177" /v "GameDVR_GameGUID" /t REG_SZ /d "9f5addde-641b-47fd-83d4-96631cf0d47d" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\008af23d-f4cc-4435-9422-b95fecf4b177" /v "TitleId" /t REG_SZ /d "2121740635" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\00e51963-7a20-47e8-86dd-c5061773edad" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\00e51963-7a20-47e8-86dd-c5061773edad" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\00e51963-7a20-47e8-86dd-c5061773edad" /v "Flags" /t REG_DWORD /d "19" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\00e51963-7a20-47e8-86dd-c5061773edad" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000c2df71fcb3a8c4492d1bdc384d3713b1a06ddec2c98b19f2f557c6301bdf5114000000000e80000000020000200000006b9e52a75ba13e5894355aaa0db627d643467a639c1500ee302380c2a6ca92dc30000000609291d835a39f16c075eb96f99c5c5039e3d2cca33dc0f557542087aa34bd5ad717a4bf87304720e6553aef042ba32c4000000081262c093afc386b8449384dbdb76b8c53f76c8e8e61c2f9354cf43abe84ede38e6b39130f08935e58afb04dd6b7c266bb2f4d21ef6c5b99f707a920e0a95f6d" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\00e51963-7a20-47e8-86dd-c5061773edad" /v "GameDVR_GameGUID" /t REG_SZ /d "8bba1d53-2f6d-4275-b42d-61db4def7d51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\00e51963-7a20-47e8-86dd-c5061773edad" /v "TitleId" /t REG_SZ /d "1877036175" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\00e51963-7a20-47e8-86dd-c5061773edad" /v "MatchedExeFullPath" /t REG_SZ /d "C:\Users\pc\AppData\Local\Roblox\Versions\version-5a2a97e1d9794df1\RobloxPlayerBeta.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\04cc06c9-e532-4b12-a143-77fc1cb3283a" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\04cc06c9-e532-4b12-a143-77fc1cb3283a" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\04cc06c9-e532-4b12-a143-77fc1cb3283a" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\04cc06c9-e532-4b12-a143-77fc1cb3283a" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa10400000002000000000010660000000100002000000031756bbb777d47648941c37eb5679eb5faea718ad1d33a8dffa7cbe1037a2602000000000e8000000002000020000000ce5a17520c298ceb4ad269c435d68303e05e8c732368f36058a8c8579d0f2cdc2000000022f2a35d2e25cef6c4cfab6d189642c1fa0bbb04a4f01b6f26613afc238ea395400000004a03fe735dd356be81dba2c8c6d14dc1f10ae9feb993f375c40ffa0564439546f83b723636dcedcc681bee3373f142bf14b892fc6b3bfba99764893af1a041f1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\04cc06c9-e532-4b12-a143-77fc1cb3283a" /v "ExeParentDirectory" /t REG_SZ /d "Thunder" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\04cc06c9-e532-4b12-a143-77fc1cb3283a" /v "GameDVR_GameGUID" /t REG_SZ /d "0a7b1129-06ec-49b3-b3cb-7bcab1043941" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0731122e-f429-4e74-8501-842bc3d88850" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0731122e-f429-4e74-8501-842bc3d88850" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0731122e-f429-4e74-8501-842bc3d88850" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0731122e-f429-4e74-8501-842bc3d88850" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000002373d4cb829b8d309a4f1bf07c66364bfa41378d31f6f744cc9f7f23ef4e1031000000000e8000000002000020000000a24b64be0c9b8d0f16cbd994639c188f3444951eb6c9bfcb47d8b681fa47b07120000000e38d3fb7a2427b9ccf8037d5a2802d56bd7e898dffb34e4577195c1e3fcf86b4400000009eb26b0a765800ded0f098c87b606bbfc9b3528be71fbb8175b82eeb5cd67738abb1dcacd79a324933f20a7851732fa4c6f1a6d6b4961746f447b9e9fd473a55" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0731122e-f429-4e74-8501-842bc3d88850" /v "GameDVR_GameGUID" /t REG_SZ /d "5b0cb2d0-553f-4a2e-bc7a-337f2b827646" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0731122e-f429-4e74-8501-842bc3d88850" /v "TitleId" /t REG_SZ /d "2040962988" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0a956050-9628-4220-b516-808e497417c6" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0a956050-9628-4220-b516-808e497417c6" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0a956050-9628-4220-b516-808e497417c6" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0a956050-9628-4220-b516-808e497417c6" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa10400000002000000000010660000000100002000000015e602d1f42285538dacf649daaf7592dca0581750b9107296e7abc37242f06c000000000e8000000002000020000000bb381d1ca94e32652bb70cf995c4bbd2c19f3f49d26f13e9fc9337ebef477169400000001990f6e1858e542b422e89184e9f34f2312d28ed1d2e9723360359e8de3ac62865b00e1850b3c22c7bce0768d1e4a46bc2fe733bef6dec93f1411d9699ecef0c40000000423459ded360714b12ef18939ab130e05218cad9db83b975d48d43f02e50702d5e72a47c23cc1a6384247c7e13e81e48370524883224f3507b282547c5fdeb39" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0a956050-9628-4220-b516-808e497417c6" /v "GameDVR_GameGUID" /t REG_SZ /d "5415bfb2-a9e9-4a8c-bcbd-4d1d9a066d3b" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0a956050-9628-4220-b516-808e497417c6" /v "TitleId" /t REG_SZ /d "1742142364" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0a956050-9628-4220-b516-808e497417c6" /v "ProcessDependencies" /t REG_MULTI_SZ /d "audiodg.exe|1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0f715c27-e790-401f-b0a4-58a636f50f48" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0f715c27-e790-401f-b0a4-58a636f50f48" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0f715c27-e790-401f-b0a4-58a636f50f48" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0f715c27-e790-401f-b0a4-58a636f50f48" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000a7e4efc94492c124758db5e8d7f5b3506a9cad55309cecd340d1809f28f66ce4000000000e8000000002000020000000fbe13cd1ba843a295fc8ce9f1f8d24c798ac4c064d59b161a12a98d133dc0a6b5000000077a46e8ac62ed853f6ab669b720e9db5247d6ffe4b7f4d7b1143aba453e87b72563b737d481adeb48a6b2cc7114e1b14c71775a55bbd5490a2b804715069895257e67c009df44896a0ac430054c2abc5400000001c39f03041e17283c4f3b4607d4e2e86f1697d4b45830c7413d084bfc81c6ca5470a72c84737c44b659028763d95b9e75cb89a78e7eaca94db9edaa358c31d28" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0f715c27-e790-401f-b0a4-58a636f50f48" /v "GameDVR_GameGUID" /t REG_SZ /d "284ea1b3-f5e7-4133-b521-74a8d9ae997e" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0f715c27-e790-401f-b0a4-58a636f50f48" /v "TitleId" /t REG_SZ /d "1820250788" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\0f715c27-e790-401f-b0a4-58a636f50f48" /v "MatchedExeFullPath" /t REG_SZ /d "E:\fORTNITE\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\11163eb8-ff97-4fc8-a4d1-1d46c9565579" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\11163eb8-ff97-4fc8-a4d1-1d46c9565579" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\11163eb8-ff97-4fc8-a4d1-1d46c9565579" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\11163eb8-ff97-4fc8-a4d1-1d46c9565579" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000645d20b00299a5ec1ec1ea07a8c46ff1fced90efadac97b15f127f059499360c000000000e8000000002000020000000efa25878be8c0e928864cc2e6dea1d8ee7232416c6131c1e8f09b76c9a023cf7200000001bffe4cafc21b93e79b6d96b2c0b1c4c4c4707c7b5570eea449aba66a99951f44000000047b0cc43987ee5631ebd08041ecce1ae0671c247c6d9a0ef546d45a6f549027b7e9a580271278a5386db42c817c2adac9b9c5f744974a67b4f9752ecda3f9559" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\11163eb8-ff97-4fc8-a4d1-1d46c9565579" /v "ExeParentDirectory" /t REG_SZ /d "assettocorsa" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\11163eb8-ff97-4fc8-a4d1-1d46c9565579" /v "GameDVR_GameGUID" /t REG_SZ /d "504b718c-a940-4c74-a033-a1a8ae2214b7" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\11163eb8-ff97-4fc8-a4d1-1d46c9565579" /v "TitleId" /t REG_SZ /d "1732322725" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\241e0838-282a-453c-bf0c-b453987e7fa3" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\241e0838-282a-453c-bf0c-b453987e7fa3" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\241e0838-282a-453c-bf0c-b453987e7fa3" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\241e0838-282a-453c-bf0c-b453987e7fa3" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000812f71d40c69942ad2801687683e9b9fea1a51b8c518e2fa9b2d028bb455a4d4000000000e8000000002000020000000cbfe4aae72d069e43f20f336242fa53a9dd7c50c137349bb22ef32764c61a46330000000ad8cbc9f66d19470cd21556902c384e16235b6afc00f8b77b94171d411962392e527219838c20f77fdf50d48134eb5b740000000a20940b64d97a2d58c8904f51e8695b6cabf86f9a98fc022999620e11264c52d272e845533f8b52ff0e52b5733185ec97ddcd8a163126075e7c2a5e290253aba" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\241e0838-282a-453c-bf0c-b453987e7fa3" /v "GameDVR_GameGUID" /t REG_SZ /d "2605801a-c442-492c-8f9e-b274878c9c77" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\241e0838-282a-453c-bf0c-b453987e7fa3" /v "TitleId" /t REG_SZ /d "1918679142" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\326c86ae-f3a9-4980-8b9e-1da326311c76" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\326c86ae-f3a9-4980-8b9e-1da326311c76" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\326c86ae-f3a9-4980-8b9e-1da326311c76" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\326c86ae-f3a9-4980-8b9e-1da326311c76" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000005adce9ed51586046e825f8bae3d84ada217bdfa03a02782544acb89b4f07cf14000000000e80000000020000200000000d0d1c54874fba900bf7e8c3d3c697caaf75a69f2afd41654d5792dbcf61ee0640000000abce9f2877fdf8007c1b848fe0f38f5bfb2c85bdc12c6ab0b9cce2027594795a8fcfb983868aa003b0c7b45c7b1a63e872e1336d8cd15f7ef6537e8bd864ee82400000001bfb009a1cfe6551434fa53717acb6ded8b80c45543cf7a42ab404acd1e147bd9ddf6c47deab6b0219331ff10c93c98ebd5ad3e89132b2db0095466ac797f383" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\326c86ae-f3a9-4980-8b9e-1da326311c76" /v "GameDVR_GameGUID" /t REG_SZ /d "af3f11bd-4a4a-4e7f-915b-42f92384577f" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\326c86ae-f3a9-4980-8b9e-1da326311c76" /v "TitleId" /t REG_SZ /d "1698925306" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3409f26f-7bae-42a6-9c74-99c544ce5476" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3409f26f-7bae-42a6-9c74-99c544ce5476" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3409f26f-7bae-42a6-9c74-99c544ce5476" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3409f26f-7bae-42a6-9c74-99c544ce5476" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000003ff4d03d1330e9cf0d9a7b9da7817b290e7fae6386966068ed5cc0f447b4cff4000000000e8000000002000020000000251e6b7fb961c8e8203beab95528f6b2c39ce0b0ea3b38d4549fa346fb82f8903000000023aba10017424bc05fac79b28829993e7c17b5a2f8c903fb43f4d9b7f39aa4dbc295331d4de9a46ad9da580d2af5bc5b4000000073cd8d5ab4f8cafa232a49c639814452a4e4e2893fb63acdbe965b97e8b2e87be7047a2d9860ff1cd5f4804fb67555ec9781bcfea656a5f54ae6ea4aca1ca6fb" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3409f26f-7bae-42a6-9c74-99c544ce5476" /v "GameDVR_GameGUID" /t REG_SZ /d "3d991043-7128-48fd-936e-618d3e900873" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3409f26f-7bae-42a6-9c74-99c544ce5476" /v "TitleId" /t REG_SZ /d "1918679142" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37578440-a809-44bd-88fe-2f00932796b4" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37578440-a809-44bd-88fe-2f00932796b4" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37578440-a809-44bd-88fe-2f00932796b4" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37578440-a809-44bd-88fe-2f00932796b4" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000003e569115f1e219b6cb1ade76d055c775fc508ea69260a25ccc3520e8c5c0bc30000000000e8000000002000020000000c16745aa95af88753ac48c3f1f2c41fd9fee2af7d4cb17155b0b3f2b40e004e13000000043a04b70d8bc03af97ba932e2e05138851f168e4084222e1a4dabc5eb66b41425d852d358adb4ccc9b2d923b49f93f5b40000000a529c6e9e708662cc2fbea67085757904ae652ae102e184479f9654478fcec6e60eb64b73f16927ba35e41956c1e97e278bfcb26d69df0106490e246874f9022" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37578440-a809-44bd-88fe-2f00932796b4" /v "GameDVR_GameGUID" /t REG_SZ /d "44948889-a2f7-4479-a57f-918e58b10519" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37578440-a809-44bd-88fe-2f00932796b4" /v "TitleId" /t REG_SZ /d "1918679142" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37b0bb90-816e-4853-b8e4-b943541b2f03" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37b0bb90-816e-4853-b8e4-b943541b2f03" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37b0bb90-816e-4853-b8e4-b943541b2f03" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37b0bb90-816e-4853-b8e4-b943541b2f03" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000006727cd8340f88cc8db833d57d67542565dc14054fdede06121d88482246cfe56000000000e8000000002000020000000b598ddf3a6928927d0b24f37a6152b83648f341391f461c616e88ff21fb836e0200000001eb85bcb0689c029f5352964cbe327b0caaad7e185042229296dd7da3377ac934000000091bfffbe25441ef201a0061c2da071b4b0ae80bfd2ce193ee3b91eb88f0bff443a1aabf1b10bced5bc8ff7e063447685fb5e7a00977cceb51ad733db20c3575d" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37b0bb90-816e-4853-b8e4-b943541b2f03" /v "ExeParentDirectory" /t REG_SZ /d "Grand Theft Auto V" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37b0bb90-816e-4853-b8e4-b943541b2f03" /v "GameDVR_GameGUID" /t REG_SZ /d "07637478-a718-4c3b-85f1-4208550bf9ed" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\37b0bb90-816e-4853-b8e4-b943541b2f03" /v "TitleId" /t REG_SZ /d "1862446374" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3f43ed16-df66-4422-abd8-925b1350bb64" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3f43ed16-df66-4422-abd8-925b1350bb64" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3f43ed16-df66-4422-abd8-925b1350bb64" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3f43ed16-df66-4422-abd8-925b1350bb64" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000150f1ad2ab133c5e6acafd8c2531de42a18e75c280fa12a39a8f7c3d09488493000000000e8000000002000020000000da79e02a246b1cccc6449260fa0716b3730865a5c8ddd9cf1bbdaf16754130e73000000060c98c0fc321e4f820338acd13ddfb6326c5646ff36a41aaae010cf0af548833b31aa59e078a4b322dccb1cd1e00720240000000606ea71737e8d97c431b0e9bf480bfbb34e0827d4d3d8643a47c8afaa15d666b872075d36c503ffba9298dbc25b388cc66fcc3fbe1621463593164aa7865d97c" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3f43ed16-df66-4422-abd8-925b1350bb64" /v "GameDVR_GameGUID" /t REG_SZ /d "beadb662-4a97-4790-bc99-33f001c314ec" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\3f43ed16-df66-4422-abd8-925b1350bb64" /v "TitleId" /t REG_SZ /d "2119592325" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40406386-7428-4521-a6f9-2f0581086ddf" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40406386-7428-4521-a6f9-2f0581086ddf" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40406386-7428-4521-a6f9-2f0581086ddf" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40406386-7428-4521-a6f9-2f0581086ddf" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000cd7cd59665dfeea16874a88d5ad65fcc2954689392e02bd2ea0d92b5b51f0335000000000e8000000002000020000000722920510f52b5bc5eaf06280539bf46c0f7f341e32287446e8aa043c2044a6d20000000dd0c5bf79ec58f80e853f5f9e73792b9d48896ef4138a2345f3315e62fe3d7b64000000073e6da8dd74e263b9b266303bf1825154e20f3d5d2731e599ca8112e7d63f6057a54a415890ca31e9f64a707282a48f3cb5a7a05ba3052d18f65d9f454367476" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40406386-7428-4521-a6f9-2f0581086ddf" /v "GameDVR_GameGUID" /t REG_SZ /d "7cf934d6-536b-413b-84bf-519f36dc9a65" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40406386-7428-4521-a6f9-2f0581086ddf" /v "TitleId" /t REG_SZ /d "2119592325" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\405c1cab-14ed-4e85-97a8-ec71126aa2e7" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\405c1cab-14ed-4e85-97a8-ec71126aa2e7" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\405c1cab-14ed-4e85-97a8-ec71126aa2e7" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\405c1cab-14ed-4e85-97a8-ec71126aa2e7" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000006b3691f3166eb2992449c41c62750677a0ce745f9ea4b57c3887fed0a1eb1554000000000e8000000002000020000000d6fb787a1bb3f89017425fbcdeab5608aed2c477df8b20600b896ff42f9322ad2000000043f666e5377918e15335c0b163ebb2f4d30827eddf0011b6e6f4fbe6454df92940000000a9636dc842c836906fd6af8ddbf211c1e413c57f24f2d2b7f8004b0b806593721845b36c8e025d8ee9a4336fe5f0d7e31dd6ac4bb3f19272e9a95999d8d2170d" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\405c1cab-14ed-4e85-97a8-ec71126aa2e7" /v "GameDVR_GameGUID" /t REG_SZ /d "5f16f138-9b89-48cd-a1b4-935f9e07e014" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\405c1cab-14ed-4e85-97a8-ec71126aa2e7" /v "TitleId" /t REG_SZ /d "2089711717" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40aa1199-5ca0-4ee6-be13-eb5009af6889" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40aa1199-5ca0-4ee6-be13-eb5009af6889" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40aa1199-5ca0-4ee6-be13-eb5009af6889" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40aa1199-5ca0-4ee6-be13-eb5009af6889" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000e24669136e4ec3ce30126669669af8bb664d0044c03befb093853fda1926c385000000000e8000000002000020000000b786383eb05f671e603d94b4be38efd132099514f7ad5601eb63202d3958f44120000000b47a626f2f564dde2eab7810240840a24d4ba54e5b991f251740951d1b6c2c674000000051b7875f0bd1004e8cd9d87aed5cdd09828357745d0a1d35f781a17d2e176782f648ed0240e3ee473b39af2e9f7e6fb025e7920725cacbae8f1c93527b982668" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40aa1199-5ca0-4ee6-be13-eb5009af6889" /v "GameDVR_GameGUID" /t REG_SZ /d "278317db-52b0-4257-9ddd-17e942d6f851" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40aa1199-5ca0-4ee6-be13-eb5009af6889" /v "TitleId" /t REG_SZ /d "2040962988" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40e28932-7ee7-404d-b262-77693fb6f631" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40e28932-7ee7-404d-b262-77693fb6f631" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40e28932-7ee7-404d-b262-77693fb6f631" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40e28932-7ee7-404d-b262-77693fb6f631" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000009503cfca9d3af229c7db1abb2aef9697f915c80726cf5d6da014b2cfd72a2759000000000e800000000200002000000016e8d2065a5cf84c209b058efb16c592e653f5560dcad87bf2110d672b00348c300000001960cf2d94a6afd3a8fa17e8ed77eb4a3b573fed6aa49bb80d851298330eeccd98c7e0c6f292934d599e0dcd74742779400000008d5b77e4475e9374702db263201d602e2be31be23e58a8c8ab3b1c4aaf05729b09c90b732bc0f99595a60513f0c86db94a38cc8465d5312990eb79b9375927a2" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40e28932-7ee7-404d-b262-77693fb6f631" /v "GameDVR_GameGUID" /t REG_SZ /d "13a903e3-8525-4b48-b0c2-ad91ed8432be" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40e28932-7ee7-404d-b262-77693fb6f631" /v "TitleId" /t REG_SZ /d "1877036175" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\40e28932-7ee7-404d-b262-77693fb6f631" /v "MatchedExeFullPath" /t REG_SZ /d "C:\Users\pc\AppData\Local\Roblox\Versions\version-096c60fcfa5e4ca2\RobloxStudioBeta.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\43c24735-989f-477c-8ced-dc705c0a60aa" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\43c24735-989f-477c-8ced-dc705c0a60aa" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\43c24735-989f-477c-8ced-dc705c0a60aa" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\43c24735-989f-477c-8ced-dc705c0a60aa" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000003c78cef4c4a58d9b9c4a5c23b3a78269ed35a9dd1b40cb0854d9efc13cc4eb6c000000000e80000000020000200000000feb290bf86ac9839eb4fc8fdea072bf929b2ec94ed4250d9537313d20e81b0630000000973bd0f32e1568427af962be0e0357458ad35123e43aa7a5c9c46490ccddb495af57e67008a6f35666f2e322e28cff834000000049b6aa6d8fa70625eb9e85b544b7bd1524d0cf56f84d0e04d8faa5de1b5b061f83b0aae007a800d794aacdfc41c61c88e2a7962b1b77864a4c29c283c9517790" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\43c24735-989f-477c-8ced-dc705c0a60aa" /v "GameDVR_GameGUID" /t REG_SZ /d "d462329a-a831-42b3-809b-6ce39187b369" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\456db1d1-339b-4a77-8b0b-6795a1699345" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\456db1d1-339b-4a77-8b0b-6795a1699345" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\456db1d1-339b-4a77-8b0b-6795a1699345" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\456db1d1-339b-4a77-8b0b-6795a1699345" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000000d1875b75d6b6703956c461615dd90c7a7321e3ebf8d4111f2cd7f7482f84cc0000000000e8000000002000020000000029c841959994881220817cd114fe56b6c8673bf75fe022a868d4ef9dd11f5b51000000037d4e2a071532725b35f235b765a37d44000000008ac48aa6f2ddc3115963eb1e3409a1f29eae74bd1b28615100b5ca43a5e3c7aaea8452a2a2321c08e5bfc03124f45b701b0c6af5f1c03e708250289293f8c32" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\456db1d1-339b-4a77-8b0b-6795a1699345" /v "ExeParentDirectory" /t REG_SZ /d "Assetto Corsa" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\456db1d1-339b-4a77-8b0b-6795a1699345" /v "GameDVR_GameGUID" /t REG_SZ /d "ad9f3b82-3ec2-4d93-93d5-23bdbc2374ab" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\456db1d1-339b-4a77-8b0b-6795a1699345" /v "TitleId" /t REG_SZ /d "1732322725" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\46fc0979-b6fb-4de8-b90d-253cc753d244" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\46fc0979-b6fb-4de8-b90d-253cc753d244" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\46fc0979-b6fb-4de8-b90d-253cc753d244" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\46fc0979-b6fb-4de8-b90d-253cc753d244" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000d52a46f383dc691a1a0d8a21a16a059337cab58f9e4fe3b82fcdb890b674d330000000000e8000000002000020000000b9793a1f3a581404cc58a2ab8a1fbf4b5471ce05d3555350a3374bb9023c508f200000009b9e9b012e9d73ea05dac532154b718c50a6fafc1d2b3fd3d99f82dab97a184a40000000652433422f755eb1ac79d8fbd4e4bb112a305f39bf5cc29e1e96eddde222968668885a8c457197db56f999599d98f85b34d341c7d8d8db8c507626c2dc86f8c3" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\46fc0979-b6fb-4de8-b90d-253cc753d244" /v "GameDVR_GameGUID" /t REG_SZ /d "15c6ac82-6f25-4f79-8ff1-a7c777f1a7db" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\46fc0979-b6fb-4de8-b90d-253cc753d244" /v "TitleId" /t REG_SZ /d "1714452188" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\46fc0979-b6fb-4de8-b90d-253cc753d244" /v "MatchedExeFullPath" /t REG_SZ /d "E:\Spellbreak\Spellbreak\g3\Binaries\Win64\Spellbreak.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4787b2ac-d4ec-45b8-818a-bfaa6ff7daa3" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4787b2ac-d4ec-45b8-818a-bfaa6ff7daa3" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4787b2ac-d4ec-45b8-818a-bfaa6ff7daa3" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4787b2ac-d4ec-45b8-818a-bfaa6ff7daa3" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000e0cc8dca8535c1fa2aef2cc8173953f514cbeb4f0e359ef43088c4530d1af248000000000e8000000002000020000000f2e4a07a4e10f902c4530b7a9a7d12e59f7bd5adfaf5428172a9601bbea826f0200000004518395700d59104c92cde981530e1c133600197f4cc6e439bc2bfaad88efe3b400000004583aadf35fe87d01d143e4130c0a4eb889ee849e25cda7ea0076bc3eeaee9d55e86420b48e752eb35b8bc72ef936120fe758c774f05671c81d2c21232a97dc9" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4787b2ac-d4ec-45b8-818a-bfaa6ff7daa3" /v "GameDVR_GameGUID" /t REG_SZ /d "224d89df-2628-4203-bf5c-11c62dcbe9f2" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4787b2ac-d4ec-45b8-818a-bfaa6ff7daa3" /v "TitleId" /t REG_SZ /d "1667877464" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4787b2ac-d4ec-45b8-818a-bfaa6ff7daa3" /v "ProcessDependencies" /t REG_MULTI_SZ /d "audiodg.exe|1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4f561632-47cd-4c2b-93a9-e1da865f03ba" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4f561632-47cd-4c2b-93a9-e1da865f03ba" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4f561632-47cd-4c2b-93a9-e1da865f03ba" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4f561632-47cd-4c2b-93a9-e1da865f03ba" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000b6991435445b505867cdd106bb476b742f92bc755eeb634d6f2885e2b5e7efbd000000000e8000000002000020000000a46e751b690f47645666afd17e84a88f7ab4c0765929c510ac6f7f5017fcf95e30000000dd7b2cc92e57419c4e2dae72e68ecbc7982b85a9142baaa4608fe17c6b07c175d638e6bd72f20f7d7832c3c2990b2322400000004244d78b9ad62b3624678a3d999101467c25ab3d1b6d91e8e2236ca30d9b08cc928f5079c875b8c5d90bd4ea2f1321bff897c72c044b8c213e8e5f92992c254f" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4f561632-47cd-4c2b-93a9-e1da865f03ba" /v "GameDVR_GameGUID" /t REG_SZ /d "88c24bf8-d1db-48be-b6f7-684ab89c9194" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\4f561632-47cd-4c2b-93a9-e1da865f03ba" /v "TitleId" /t REG_SZ /d "1698925306" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\50ef2ba5-7013-4e09-917e-2e77e806b4d4" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\50ef2ba5-7013-4e09-917e-2e77e806b4d4" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\50ef2ba5-7013-4e09-917e-2e77e806b4d4" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\50ef2ba5-7013-4e09-917e-2e77e806b4d4" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000f713a26d358d220a63f472dc57e490304b0097aa9f1befb7c8d1c1f7ebf95cbf000000000e8000000002000020000000336049e4b7a194d18a9a4ba3a574cb4c4bd6f7c442f51e625b62cfdea584b49c30000000ca811d733df673963f08026251ccd8d0ba534d29378995cc2bbe9210809b85748cdfafe5968ba31b9da6802ef63908a040000000f7448769e6a4c6326a175fb12ad8bd9da728d52c2b366552f67c9fd5f375d24e90abd47a2ae510cc4c8374af9d33ff5efdb2b85bff28098f95180cd1c125e118" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\50ef2ba5-7013-4e09-917e-2e77e806b4d4" /v "GameDVR_GameGUID" /t REG_SZ /d "1b71cdd5-d687-414b-b729-64a8e30f9cab" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\50ef2ba5-7013-4e09-917e-2e77e806b4d4" /v "TitleId" /t REG_SZ /d "1801033410" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5bb62464-0905-4a39-b7e4-317edb6f0b33" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5bb62464-0905-4a39-b7e4-317edb6f0b33" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5bb62464-0905-4a39-b7e4-317edb6f0b33" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5bb62464-0905-4a39-b7e4-317edb6f0b33" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000b2b46af91c169e0a7897663ecda48baea3eaf1862f0579134fbee50afc2aa149000000000e800000000200002000000062de0b130e701430941da28f61e66de44d07485ffcad4a70fd9e2d79c27c4c2940000000bfe53e0e667c6b69aec5e454a4417648d1ba9c9da5d9653c0c2000a0b8275c21d0bd938bcc3202d929190c43a00312151d794a6f498d6dda6b359abbfa071d3740000000c2672ee3a991cfd9bfa2c069b50ec10d02ad25d66f7ff31dc841854a69b82a31e0455213ad8aa7f147c364c4c8e80404c5ca0bc9184fb88db240bc57008db46c" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5bb62464-0905-4a39-b7e4-317edb6f0b33" /v "GameDVR_GameGUID" /t REG_SZ /d "7eb831fc-81c0-411b-bff0-176f7cda799d" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5bb62464-0905-4a39-b7e4-317edb6f0b33" /v "TitleId" /t REG_SZ /d "2066051089" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5cdff6ad-e34e-4062-877b-3fe82e7c8949" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5cdff6ad-e34e-4062-877b-3fe82e7c8949" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5cdff6ad-e34e-4062-877b-3fe82e7c8949" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5cdff6ad-e34e-4062-877b-3fe82e7c8949" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000ee6e08927d02adccf7e231fc8d8ec9e052dae83d6e1592104b69c6fe1a40d7c4000000000e80000000020000200000008626aa0a4e3ff37e8052722568ad0364c545f54a13bc9258ed4c81059a41003a20000000b33ec80113dc881d4fce217376401d9983bad5f8a0a1865b7f818f13d9d5a0ec40000000e57cf4f483c062de537d8c48b3a43aa180c446fa55b639b2e371bda512b6928a14f605dba58f395b51df5506253c626824870df390e8ca736bb793d4e4caa116" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5cdff6ad-e34e-4062-877b-3fe82e7c8949" /v "GameDVR_GameGUID" /t REG_SZ /d "9df8835d-3764-44af-ab79-eb100bd97425" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5cdff6ad-e34e-4062-877b-3fe82e7c8949" /v "TitleId" /t REG_SZ /d "1621796646" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5d93a35e-310b-4e76-8967-b97ae66016a2" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5d93a35e-310b-4e76-8967-b97ae66016a2" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5d93a35e-310b-4e76-8967-b97ae66016a2" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5d93a35e-310b-4e76-8967-b97ae66016a2" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000828969ffbe7bfd5f26069e50671e8bb95b551c387fcad084aa15f1169f382b8f000000000e8000000002000020000000635a028ff148698750e16bd3a1496278aec9d157830fb33c67e047e0a35d48af2000000021b6e1217091b23bf6f32762d2ca16475b7180aa163dd318593dad7ded9a56324000000097d0411706c209f9e9fb7d1b995640042f86e79fb0ffcc6ae661e2a713b61078a3c49e302f6754aec5c53aec9526fabb53ddc228495821c65a36bf864264b871" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5d93a35e-310b-4e76-8967-b97ae66016a2" /v "ExeParentDirectory" /t REG_SZ /d "Assetto Corsa" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5d93a35e-310b-4e76-8967-b97ae66016a2" /v "GameDVR_GameGUID" /t REG_SZ /d "6cfa5815-25cf-4dee-b61c-ac4c88b53778" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\5d93a35e-310b-4e76-8967-b97ae66016a2" /v "TitleId" /t REG_SZ /d "1732322725" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\6053cdf7-6d52-42c8-9967-a29a542b7ae1" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\6053cdf7-6d52-42c8-9967-a29a542b7ae1" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\6053cdf7-6d52-42c8-9967-a29a542b7ae1" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\6053cdf7-6d52-42c8-9967-a29a542b7ae1" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000e2726d36d4db62316e89dbe86d0713afa3786f7481cb30074fa4a5fedce70db8000000000e80000000020000200000007410aa4e3b3943aada0f15ae6c18cce178c0f4b905c7d6ee777862bb77939e4d20000000265f6b0bf596dbb210c33de536bc88960c1cbb7cd5a6bfbd8693dd003f1279d54000000090c43e7cdeff564ea053c0a90455b62d5fd956bd105b1e40b7d7bf0e029c0e2c502cbb5045f2afea909d2dd6708137497d0e9439423ebca735f77327dd5106e8" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\6053cdf7-6d52-42c8-9967-a29a542b7ae1" /v "GameDVR_GameGUID" /t REG_SZ /d "a78ce068-6b2c-4b51-9305-229303a1512a" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\6053cdf7-6d52-42c8-9967-a29a542b7ae1" /v "TitleId" /t REG_SZ /d "1644611974" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70c3139d-9c99-4038-ad15-1d6bf312fb15" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70c3139d-9c99-4038-ad15-1d6bf312fb15" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70c3139d-9c99-4038-ad15-1d6bf312fb15" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70c3139d-9c99-4038-ad15-1d6bf312fb15" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000009adcd8abd6338e2412ed2f5dc0b1842da1972b40ea9b4a512e31815085161068000000000e8000000002000020000000aaff27b059cf8a88ba4b0fa5a41c2095712151da880d633aac62e64f99ce5575300000004617b59d8bd8bcba1c6692500f6747547d5898702df8c9ffe31031b58b36161948484ea47bd82b793bd4f9f512036fc3400000003a13b89f787d72a9237c6e6f2097b9450a2e64a05a95e17e760b422ab542e9fd0a5be313634d5d0289b3e4c751cb859c1ae6f274c7dd66743f7de9a552eba890" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70c3139d-9c99-4038-ad15-1d6bf312fb15" /v "GameDVR_GameGUID" /t REG_SZ /d "6b15dfa7-66e4-4a62-a748-05cb4dadf867" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70c3139d-9c99-4038-ad15-1d6bf312fb15" /v "TitleId" /t REG_SZ /d "1787008472" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70c3139d-9c99-4038-ad15-1d6bf312fb15" /v "MatchedExeFullPath" /t REG_SZ /d "E:\COD WarZone\Call of Duty Modern Warfare\ModernWarfare.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70df813c-6159-4d82-b679-3b79c7aa6cb1" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70df813c-6159-4d82-b679-3b79c7aa6cb1" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70df813c-6159-4d82-b679-3b79c7aa6cb1" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70df813c-6159-4d82-b679-3b79c7aa6cb1" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000cca38c1d965f79d722805958e9d94a1f2c0b08db017c48281a12d2ec3de4499b000000000e800000000200002000000001e7427de70ec70c3544165a4a42a9adb6e8faa81d703df1ef680b9f99f4b1c110000000fea1a4d63f604f88f18c201082f75cdd40000000fa49fd7ec1eed8294f5696f3769851210c965cb01b149a31a537954ca8a233b97c139955ab66bc39f75a6809bea68da89b686479be9c812d3f13896eaed19ea7" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70df813c-6159-4d82-b679-3b79c7aa6cb1" /v "ExeParentDirectory" /t REG_SZ /d "Red Faction Guerrilla" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70df813c-6159-4d82-b679-3b79c7aa6cb1" /v "GameDVR_GameGUID" /t REG_SZ /d "3e70fc1f-7916-4016-ac8e-b59dddbff6e9" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\70df813c-6159-4d82-b679-3b79c7aa6cb1" /v "TitleId" /t REG_SZ /d "1995066354" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\73400fc2-5ae9-4532-86dd-29d81bae1132" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\73400fc2-5ae9-4532-86dd-29d81bae1132" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\73400fc2-5ae9-4532-86dd-29d81bae1132" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\73400fc2-5ae9-4532-86dd-29d81bae1132" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000d4b1cfac322a9636b898bc9e9398d9270a706113a520ff21ec3092ce51b94887000000000e80000000020000200000000ba3723336a0a15c0891602834cccfd9910edb9f23a5b2ff1d2a37daad82346830000000a9f46ad7e999c29ce0faf59d1d1e093e0aae5500a71d56afa61d246d994d1a8f79fb94d7d8bc734bfe13f69805bb96d4400000008fe6d531cce3a3fde7b96b330b7fa7b83a53250a667eff07c596f10822b0d9c04cb192d6fe1c9aae1f88a5e9352c8b76277e1225c94d7d5fa23a21883a064408" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\73400fc2-5ae9-4532-86dd-29d81bae1132" /v "GameDVR_GameGUID" /t REG_SZ /d "ba8cb5ec-5912-4170-87bb-ba98605e8318" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\73400fc2-5ae9-4532-86dd-29d81bae1132" /v "TitleId" /t REG_SZ /d "1956642556" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\73400fc2-5ae9-4532-86dd-29d81bae1132" /v "ProcessDependencies" /t REG_MULTI_SZ /d "audiodg.exe|1\0battle.net.exe|8\0battle.net helper.exe|8" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\77b4d6e3-85d7-4ae9-ad9b-52b42f98077f" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\77b4d6e3-85d7-4ae9-ad9b-52b42f98077f" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\77b4d6e3-85d7-4ae9-ad9b-52b42f98077f" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\77b4d6e3-85d7-4ae9-ad9b-52b42f98077f" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000e365c2dedb7aa80048139c2753ce5d733891e7f8889929eb77405da34b074648000000000e80000000020000200000003d5423fc55c3891e0af498bd039d6375ac49c426c3efae537ef3563ad095593c300000002092d1969ed4ccc6e608e28cf1035996ca841bed9f88d7850223f8b236f33384735db185fa7d9d868739c17b8e53b9c840000000cac55fa6eecbc31b2d0ac5772ee8782050f6027a080415825084c0cc0724db1f5513b81ed0f22cd0104f8890556bb6422ca9795601609aae5dc7beaa5aa6a735" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\77b4d6e3-85d7-4ae9-ad9b-52b42f98077f" /v "GameDVR_GameGUID" /t REG_SZ /d "53080e08-49fb-4312-9e1f-8fc378ea09a1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\77b4d6e3-85d7-4ae9-ad9b-52b42f98077f" /v "TitleId" /t REG_SZ /d "2089711717" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\7c6c29ed-6638-4b39-87c9-90749f34fd0f" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\7c6c29ed-6638-4b39-87c9-90749f34fd0f" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\7c6c29ed-6638-4b39-87c9-90749f34fd0f" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\7c6c29ed-6638-4b39-87c9-90749f34fd0f" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000b084d437973df586eefe73f040fa43348ec64eb5942639faeb12943ea9c8ce1f000000000e80000000020000200000006ad79d8212289819d5094a3426dc46b71f34cd4d6f262ec924af385b20b9dd6f2000000028fa4cb3ea12414e2b8b842a287b8f1f0d1ae23fc0b0caa0f9d2c248ad60facf4000000058c2cce7d4c0b4a28746e13fd765598b0cddae1b8b869a2170c744210a65016e5292920088979defdb6de4b2d2ebeace65750139b89e9f66fba8b743b46cc5d2" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\7c6c29ed-6638-4b39-87c9-90749f34fd0f" /v "GameDVR_GameGUID" /t REG_SZ /d "c9a828a1-eacc-46a4-9372-6a5c7dd052ae" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\7c6c29ed-6638-4b39-87c9-90749f34fd0f" /v "TitleId" /t REG_SZ /d "1862446374" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\7c6c29ed-6638-4b39-87c9-90749f34fd0f" /v "MatchedExeFullPath" /t REG_SZ /d "C:\Users\pc\AppData\Local\FiveM\FiveM.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\88bba3e3-6149-435f-8f03-2e763a6b28e5" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\88bba3e3-6149-435f-8f03-2e763a6b28e5" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\88bba3e3-6149-435f-8f03-2e763a6b28e5" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\88bba3e3-6149-435f-8f03-2e763a6b28e5" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000bbf0b749457861b6011e095a8abd591acc8169e950dbefda3f14b3a4a2d8fbc9000000000e8000000002000020000000ba63f57d769a7e565aea5c810b851c1bcb4b339eaf33eba8dc112744e2caf6cb10000000e5b4febbae83767b9197f4000cd4ceb740000000fc6bcc008bb511c3b79d17b7d0c5d17f546e7e1ca7e686897fd26c198fefd590b807d62da43436ad1b1bd1fbed980259c43c33d677df1153c87decc292062371" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\88bba3e3-6149-435f-8f03-2e763a6b28e5" /v "ExeParentDirectory" /t REG_SZ /d "Football Manager 2018" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\88bba3e3-6149-435f-8f03-2e763a6b28e5" /v "GameDVR_GameGUID" /t REG_SZ /d "df224822-4e38-4db8-b348-1a74168570ea" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\88bba3e3-6149-435f-8f03-2e763a6b28e5" /v "TitleId" /t REG_SZ /d "1621910926" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\89012e6d-35ec-4578-bdbd-1e9c2f91d561" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\89012e6d-35ec-4578-bdbd-1e9c2f91d561" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\89012e6d-35ec-4578-bdbd-1e9c2f91d561" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\89012e6d-35ec-4578-bdbd-1e9c2f91d561" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000008dcf91b9fed0dfb94f7625e598fb50dfc4711ff0a3f88afeba93d7d3a39af24f000000000e8000000002000020000000eb7c77b4f86942115f5557af80713f1d14e264e8ed648198bb9c3d99e78f07fa2000000062ec9094d0f54153a685bd257bdbbc84cc3f680712c1c26af7f776609ec25c634000000044f25d942d424f375984751d2e7ab9972c94ae3495c91ac0c6273223fee0e990538c1737ffe74496b291262aac9998dbfa6c7b163cba43005424e6766cc86181" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\89012e6d-35ec-4578-bdbd-1e9c2f91d561" /v "GameDVR_GameGUID" /t REG_SZ /d "2642baeb-a830-4329-b111-6be504a93e9a" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\89012e6d-35ec-4578-bdbd-1e9c2f91d561" /v "TitleId" /t REG_SZ /d "1698925306" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\8d4cda1b-ff25-4b90-b9eb-212e1939db2c" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\8d4cda1b-ff25-4b90-b9eb-212e1939db2c" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\8d4cda1b-ff25-4b90-b9eb-212e1939db2c" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\8d4cda1b-ff25-4b90-b9eb-212e1939db2c" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa10400000002000000000010660000000100002000000066701ad24efda278c278975fc2b7c1a609acdf0703b6bd9b71ebeca63e733d6b000000000e80000000020000200000007039383d4a30349739c461740ab70c4482417b3d6e78999456a4d62ecd3387633000000067b1630b78ea9fe47b87c4a411023ef3da2300ce49044d7c777ca9f74c8ac788a7719582706c766b64b169b8a7c5e890400000007511e6fc8bdc3d13a7651b07f557df16b6e9ea86cae38325b17b4b89b0de0a025e11cc81d834e9b8d3917b2b554561311f4bd4651ef5a080bf440d7b0046822c" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\8d4cda1b-ff25-4b90-b9eb-212e1939db2c" /v "GameDVR_GameGUID" /t REG_SZ /d "6834708e-ff37-4f47-8d9e-e009475696ea" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\8d4cda1b-ff25-4b90-b9eb-212e1939db2c" /v "TitleId" /t REG_SZ /d "2140933132" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\8d4cda1b-ff25-4b90-b9eb-212e1939db2c" /v "MatchedExeFullPath" /t REG_SZ /d "E:\Rocket League\rocketleague\Binaries\Win64\RocketLeague.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9253f3de-1abd-412c-8fca-25196b323e44" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9253f3de-1abd-412c-8fca-25196b323e44" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9253f3de-1abd-412c-8fca-25196b323e44" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9253f3de-1abd-412c-8fca-25196b323e44" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000007731527d66e83e8ce4772a45b0f80db134f628fbf59f3e92f6728d2ffeaad311000000000e80000000020000200000001a88e6857edeadcc9ac396dc47b4010d64b1a19b8003b744409c2ab631ecace520000000662454a6d9bcd23b3131345a02b23b84719200419b89f85e44b71c513909557d40000000e1a2e6ceba037348ac0a8fbe848721125cc4a7350467c907e834b6d0592fe71495f789e2de3886dbc5a964ee5fc6e15fe41258bdb691642f3ca898a06979a012" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9253f3de-1abd-412c-8fca-25196b323e44" /v "GameDVR_GameGUID" /t REG_SZ /d "36807058-7c11-4844-84fc-55062cd44bce" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9253f3de-1abd-412c-8fca-25196b323e44" /v "TitleId" /t REG_SZ /d "2013577527" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9b9b54e1-b0b2-42f8-b46a-63386dd30005" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9b9b54e1-b0b2-42f8-b46a-63386dd30005" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9b9b54e1-b0b2-42f8-b46a-63386dd30005" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9b9b54e1-b0b2-42f8-b46a-63386dd30005" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000001f57452de10d59a26408febc40944ac03248e2031d169efcbf5dce9697886d20000000000e800000000200002000000053bf69c14de9e1e9daf7cacacf428ba3de3c3355c0fff92571c57bc17cf45ef41000000063573dd0d4eda7a4ae2c81b8089dcd22400000002dbf6ddd729210604faa0c366a760644be4a2a608d59a1b76b68fabdede6f9440d2c27c7eaeb3b79cdcd5f8693c101cd56de767b0320a3b341ee3e4519fc5b47" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9b9b54e1-b0b2-42f8-b46a-63386dd30005" /v "ExeParentDirectory" /t REG_SZ /d "Trails of Cold Steel" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9b9b54e1-b0b2-42f8-b46a-63386dd30005" /v "GameDVR_GameGUID" /t REG_SZ /d "4b2e0e33-943e-4010-86ff-35270e2b0d83" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9d41f6f1-5618-4606-a8ec-1100921065fc" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9d41f6f1-5618-4606-a8ec-1100921065fc" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9d41f6f1-5618-4606-a8ec-1100921065fc" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9d41f6f1-5618-4606-a8ec-1100921065fc" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000d646212c2fb6aee789f011b02cea457aecc48847cf2149d45285f412948b865f000000000e80000000020000200000008e76e6790a5171e8c0158b3b5110c564f2cdcff8faba3e9953aab1b32771c4ab20000000345216961b7d9833cfe72134363133365b9ab299c46fae335e980d687542e4694000000026f93730969dd9f952e4ed68853bcdfdc665e1366fffd4fa6cd1f70e85b7d1faf4fb900755c2647b4ff5940856f2ee9697fb81d730b69075c8dbf67d0c46e6b1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9d41f6f1-5618-4606-a8ec-1100921065fc" /v "GameDVR_GameGUID" /t REG_SZ /d "d74e41c9-9b22-41e5-a4b8-4e303df73d38" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9d41f6f1-5618-4606-a8ec-1100921065fc" /v "TitleId" /t REG_SZ /d "2014204696" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9d41f6f1-5618-4606-a8ec-1100921065fc" /v "ProcessDependencies" /t REG_MULTI_SZ /d "audiodg.exe|1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9fc09f67-272f-43f3-8c0b-2557f99f08fd" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9fc09f67-272f-43f3-8c0b-2557f99f08fd" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9fc09f67-272f-43f3-8c0b-2557f99f08fd" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9fc09f67-272f-43f3-8c0b-2557f99f08fd" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000e33b7d4c792b9a6a8091a87df1d3b9e143d2fb2fdff06e631f8df6c6b5bed888000000000e800000000200002000000061671ae83bf38feaa888ae7bd30743189d64779f3996bcdb7f0f507d3e74c07d20000000aedf7ca4d131254dc118928153fadb9bcf0866fb49c440ba768f4380f24f359a4000000082e884d4315fedf90bbcb8a3c5b12a56b51b56b8eb7d90f2014d099fe1d9118bb12b310f1759449f2a49173f12d7788ccac2e6ddaa7dbf32d1d32de8e6195132" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9fc09f67-272f-43f3-8c0b-2557f99f08fd" /v "GameDVR_GameGUID" /t REG_SZ /d "5005d987-b8aa-4be5-bafe-e4db5fba423c" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\9fc09f67-272f-43f3-8c0b-2557f99f08fd" /v "TitleId" /t REG_SZ /d "2067772105" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a15993e5-3e93-4968-a526-b96ec64f3995" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a15993e5-3e93-4968-a526-b96ec64f3995" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a15993e5-3e93-4968-a526-b96ec64f3995" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a15993e5-3e93-4968-a526-b96ec64f3995" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000007c56f4d4bafe584788715db4bf16c8e21a635bbffc0ca9234952588ea0765f3e000000000e8000000002000020000000fd744903837f6fc468aa95914ce702e99e049a087a02dc9787a372c5c734b42310000000a4962be99c640172c3a45e114b804bb7400000009f2dc32db90e785aa81b9ed230c431b8fd6f120fc737a2d5b7db7aec5e95cb67fc6876c0b0673358983caa3739470f0442765adb79990c08c41cea70a4b41850" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a15993e5-3e93-4968-a526-b96ec64f3995" /v "ExeParentDirectory" /t REG_SZ /d "Battlefield" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a15993e5-3e93-4968-a526-b96ec64f3995" /v "GameDVR_GameGUID" /t REG_SZ /d "f6c9159e-723f-42e0-bbcd-e00f7c4ea056" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a15993e5-3e93-4968-a526-b96ec64f3995" /v "TitleId" /t REG_SZ /d "2040962988" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a987fbc1-fde0-406f-a039-922a6104ad2f" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a987fbc1-fde0-406f-a039-922a6104ad2f" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a987fbc1-fde0-406f-a039-922a6104ad2f" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a987fbc1-fde0-406f-a039-922a6104ad2f" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa10400000002000000000010660000000100002000000000ff626215e0be642554329f5ac104cbc1a68be2af9569c581a04f2d91ba8e70000000000e8000000002000020000000c168a6e465c299ea886c43f1a5c1355e0f29baa560ce8973a7f05283a2836493100000001f69ef04cd805342f6afa4018f0270f240000000f04369d1b25402d7cc1d1cda98768ac6bcef4d371aaa1ea119b372510ed3272fedf2fa8ec33a66d122cb700bb1626b0756996354fa85b224631b838f7f97269f" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a987fbc1-fde0-406f-a039-922a6104ad2f" /v "ExeParentDirectory" /t REG_SZ /d "assettocorsa" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a987fbc1-fde0-406f-a039-922a6104ad2f" /v "GameDVR_GameGUID" /t REG_SZ /d "b2683437-ff17-488a-ade2-5a8d743633a0" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\a987fbc1-fde0-406f-a039-922a6104ad2f" /v "TitleId" /t REG_SZ /d "1732322725" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\ae876636-f272-4eb2-aaa6-a110af0bd907" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\ae876636-f272-4eb2-aaa6-a110af0bd907" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\ae876636-f272-4eb2-aaa6-a110af0bd907" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\ae876636-f272-4eb2-aaa6-a110af0bd907" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000a5374cc32aad79527df1bdd6a6ed5a2b7818a394234daa9acc54e9c82b17b7a1000000000e8000000002000020000000f0c5dc3ebc33a37c33897bc28ac8f9224edecfef93091307cd3e1e9942ac640530000000272dc3dec90ef356793a14dd5525c0e71f9d165709d7ba9c690ced1b034da1b5b885ab519e3c5cd1ad06ae6cee2ff90640000000ddb4d48d1cbc562378b478595c431989e61ec83e85b421bb23355accf761d4f6d0384260c0dc9ca9307833b8aec83c2c4f7e8b4d5b30ba685d094cfcd9daf5f6" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\ae876636-f272-4eb2-aaa6-a110af0bd907" /v "GameDVR_GameGUID" /t REG_SZ /d "bfb4b9a9-febb-4fb7-9f83-2e4fed403916" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\ae876636-f272-4eb2-aaa6-a110af0bd907" /v "TitleId" /t REG_SZ /d "2036175044" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b184ff46-9cdc-4e94-b598-5e5db72274a2" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b184ff46-9cdc-4e94-b598-5e5db72274a2" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b184ff46-9cdc-4e94-b598-5e5db72274a2" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b184ff46-9cdc-4e94-b598-5e5db72274a2" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000161cbdadf5d39450a0bee3befc2ed95e044e5061bf848526f1914309c778864a000000000e80000000020000200000005ebb58bf54fb4ada2c3aa46c46b978f4541630b51534d47dc5056ca0ce632ad12000000030e09ada059a21b2b662ed7b2f5ff2a112efdba2bcad99f5ab874a3b72281702400000000a46f4881f10972bbaec181f40769a35caa0690525eb6a3fdd3392a267975c27c134e653cd162e4352d71081f2e975a4d191dbbbefe88b62b1d6446f7cbf0398" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b184ff46-9cdc-4e94-b598-5e5db72274a2" /v "GameDVR_GameGUID" /t REG_SZ /d "362c3b38-93be-4fb5-a043-2d32d134d003" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b184ff46-9cdc-4e94-b598-5e5db72274a2" /v "TitleId" /t REG_SZ /d "1904011994" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b184ff46-9cdc-4e94-b598-5e5db72274a2" /v "MatchedExeFullPath" /t REG_SZ /d "E:\Prototype-2-Radnet-Edition-Repack-Games.com\Prototype 2 - Radnet Edition\prototype2.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b1e0341d-a9d2-402c-a242-90ae9b02723c" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b1e0341d-a9d2-402c-a242-90ae9b02723c" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b1e0341d-a9d2-402c-a242-90ae9b02723c" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b1e0341d-a9d2-402c-a242-90ae9b02723c" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000852a4c80b5c2d4cdd14afa9c70884a1e966cc3bdc0eb507cb554423a135f9011000000000e8000000002000020000000b6625f0d49036c8449e70cbfd86e2442a45a88796b7acecc0fbc6b26069fb76540000000ab2666f1466dd49612a345fe39551b912c93aab16dbd30a5c9731cb026b29625f235039625f940c5ee9ff76f35ff60aa41853b90cf45de98d8b56780b8ed2e36400000005afcb0a69f82cf57da5268a5b93c8d2cf51e1d9142f8c568f86c418cf70508378a7bbd48138521c87e57b0288207f92f9385418e24325185d132c7ba6dcb7e40" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b1e0341d-a9d2-402c-a242-90ae9b02723c" /v "GameDVR_GameGUID" /t REG_SZ /d "4380af58-6d39-48e0-845c-c246ca123fb7" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b1e0341d-a9d2-402c-a242-90ae9b02723c" /v "TitleId" /t REG_SZ /d "1901314766" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b1e0341d-a9d2-402c-a242-90ae9b02723c" /v "MatchedExeFullPath" /t REG_SZ /d "G:\GAMES NEW\PUBG LITE\PUBGLite\Client\ShadowTrackerExtra\Binaries\Win64\PUBGLite-Win64-Shipping.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b8b48b38-1c19-4dd7-ae69-3ba5cbab0db0" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b8b48b38-1c19-4dd7-ae69-3ba5cbab0db0" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b8b48b38-1c19-4dd7-ae69-3ba5cbab0db0" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b8b48b38-1c19-4dd7-ae69-3ba5cbab0db0" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000003f67a43c44df0dd2c5dc1f315c022f11dc4cde1bcc0e181bb46e06338ca8c4b7000000000e800000000200002000000057f327fbf7631f54c150df0f21751affa55f6df02586642b1668a9665939f2a92000000062d10f66f450ebbe4602f83d1af4d23c27cc19791a6e6b7cbbf5ff523f84d7e4400000007401baf762fe4e0a8bb70b0027434fc71620b423afc7b40fb1ae7641cd15339f367c13e0f7f7d64654355801d426278a530903ea53c7a17bf1e961d3d85bfce3" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b8b48b38-1c19-4dd7-ae69-3ba5cbab0db0" /v "GameDVR_GameGUID" /t REG_SZ /d "ad4e885f-9469-42d5-9c0b-73bbb96fd569" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b8b48b38-1c19-4dd7-ae69-3ba5cbab0db0" /v "TitleId" /t REG_SZ /d "1628516715" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\b8b48b38-1c19-4dd7-ae69-3ba5cbab0db0" /v "MatchedExeFullPath" /t REG_SZ /d "E:\Origin APEX Legends\Apex\r5apex.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bba1d6d2-9a61-42e8-8600-e0dafb8fa1d6" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bba1d6d2-9a61-42e8-8600-e0dafb8fa1d6" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bba1d6d2-9a61-42e8-8600-e0dafb8fa1d6" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bba1d6d2-9a61-42e8-8600-e0dafb8fa1d6" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000005b12daaaa2927b59072c41aa26bb3fdcecc37a96d74dc3abcb59eadc18df23fe000000000e80000000020000200000005b5b458112a4dfba3047d3639aee304889cff8bdeace5bd8163fd1cfde36db9e200000003230850dccdcef31a43b46affc78fc03e2f158bc28d49c7c076ad28e3f1d3ee64000000099a958174535f85e80417aedf6a0069d87ba0b11bf1248846370eb08b031d7f6eb6a34e2d7e8a48c158df69d5e1855844bd5af653814638fd05341dd9d5513ad" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bba1d6d2-9a61-42e8-8600-e0dafb8fa1d6" /v "GameDVR_GameGUID" /t REG_SZ /d "d82d19c7-cf98-4dd1-92ee-b51acefac3ec" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bba1d6d2-9a61-42e8-8600-e0dafb8fa1d6" /v "TitleId" /t REG_SZ /d "2089711717" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bdf4f2dc-25d6-4cb4-8f2c-c268c4b0e339" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bdf4f2dc-25d6-4cb4-8f2c-c268c4b0e339" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bdf4f2dc-25d6-4cb4-8f2c-c268c4b0e339" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bdf4f2dc-25d6-4cb4-8f2c-c268c4b0e339" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000001544559b2b0790dec67dbafe7f8bc33ece740bff7532d08bfd28422b80ae46b5000000000e8000000002000020000000fa8f7175796b2759bb9959108667bf72debd152eee259b5ab31b4590bd81c5104000000059d37d5e763633816ffdd3c68b3149f1339b15bbd308542875539f7c7d85dad9a4453c5019d239b3a12cd34c48ae4ce6e18df0d6bf8a6afb1af7697e2c56897540000000e89640ea0cdc32173f52b4cccab71050bd0ae2240fc0596727a19aacefc30171aa90324923f0b86ebd6aa1c7a4a1cf7bea5f74df5309d7d58adb9ad7d6b1a102" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\bdf4f2dc-25d6-4cb4-8f2c-c268c4b0e339" /v "GameDVR_GameGUID" /t REG_SZ /d "c30126d9-4cac-461a-b331-faa613447906" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c197c13c-6b0c-4810-81d1-548ed723a399" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c197c13c-6b0c-4810-81d1-548ed723a399" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c197c13c-6b0c-4810-81d1-548ed723a399" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c197c13c-6b0c-4810-81d1-548ed723a399" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000bb3393250d77ed2dbc8fb15e0df335cadb67e0386cfb1aecc96f2b7b7a32edd3000000000e8000000002000020000000fb56066f64fa5ddbcaa150ddd4e59c1693c65382c71f518cdcd7e7f9fa0a42754000000090a2ea7402811b74f2ae8139e5454adeeb8f3aa54d40d04815315c41182b7e09fd089de96102fda7b7b44e7c341053ae0d1f6385776af46a303d76c7322b5fb0400000004b7a8c02bb0539598ab7d444a570620cf673601f7fa7d0f7c9a8299d345b3dd6e866104b52477bea7a9041549ed729ce1b936793d4ddafb00debf8b0cb6b62ca" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c197c13c-6b0c-4810-81d1-548ed723a399" /v "GameDVR_GameGUID" /t REG_SZ /d "a08ed448-4755-4afd-88ea-60480149ef7a" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c197c13c-6b0c-4810-81d1-548ed723a399" /v "TitleId" /t REG_SZ /d "1742142364" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c197c13c-6b0c-4810-81d1-548ed723a399" /v "ProcessDependencies" /t REG_MULTI_SZ /d "audiodg.exe|1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c1e4be0f-1b0f-4324-a064-adccbdb98dae" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c1e4be0f-1b0f-4324-a064-adccbdb98dae" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c1e4be0f-1b0f-4324-a064-adccbdb98dae" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c1e4be0f-1b0f-4324-a064-adccbdb98dae" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000003dce0db3bbd7e2590e052ed52b818fc6b45b6ca6e4f4561b753f18afaca134f8000000000e8000000002000020000000c31d6e904e70f596541f40c1a7497394a91d265a6059b3e73f141cf523ec59a63000000092c4dda0c06b61400e11de48084aaf714804ae90712deef1a04b6afade3da94cf7780aed971510a65c35c7ff979438f0400000008ec91f3bf88c2ced36111f6b3fa4a666f23477699b9c8849a1b598980c08cb39efc320445bebdce2a78851a078cb8df088cc1354c1ba6b58b9fa317a08aa47d6" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c1e4be0f-1b0f-4324-a064-adccbdb98dae" /v "GameDVR_GameGUID" /t REG_SZ /d "9cd0abff-d7f4-488e-ab4d-031067591dea" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c1e4be0f-1b0f-4324-a064-adccbdb98dae" /v "TitleId" /t REG_SZ /d "2121740635" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c83d8550-bfd3-4fe6-a5ed-256363e86756" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c83d8550-bfd3-4fe6-a5ed-256363e86756" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c83d8550-bfd3-4fe6-a5ed-256363e86756" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c83d8550-bfd3-4fe6-a5ed-256363e86756" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000dd054ac6c5d95b4f5babacc68c331c79b307fd03216ef76e2593863f77e86f46000000000e800000000200002000000035b190e15876bb3e37c8bcd09ee0ed557aa16f0fbeaf2fd76cdf8c3fdc1d5421200000004b277c821ac909330334de76101987258149faf9606c47567de7914c11733e7140000000570a184c0de68c0779cf372cd45a9907b0a79ba6c04863cb691be0da6c1dc88f06d206fe75b066e7a73c4da8c193ac955650dd70c6916c6e7137c531d9a83d9b" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c83d8550-bfd3-4fe6-a5ed-256363e86756" /v "GameDVR_GameGUID" /t REG_SZ /d "0e943a5f-4a49-4030-8ba2-1d51e7b60a08" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c83d8550-bfd3-4fe6-a5ed-256363e86756" /v "TitleId" /t REG_SZ /d "1956642556" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c83d8550-bfd3-4fe6-a5ed-256363e86756" /v "ProcessDependencies" /t REG_MULTI_SZ /d "audiodg.exe|1\0battle.net.exe|8\0battle.net helper.exe|8" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c9519863-23c7-4c40-9bc4-ce362db7e451" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c9519863-23c7-4c40-9bc4-ce362db7e451" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c9519863-23c7-4c40-9bc4-ce362db7e451" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c9519863-23c7-4c40-9bc4-ce362db7e451" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000008cecf44dd00e8884f0c705961bee22cf9dda5bf3f0a20b6f7311f7c71c74e44b000000000e800000000200002000000030df540181aa25b4c8c78729868f73863fb8336bc1e3117c1005dd3fd7eb7be020000000bbdcaf3d34ab1064594c568986ffc7cfce58abd764be903c9b8768c8ed08a48d400000007429fd427f2ff32065239c22d9960b3d3713bd6a9e9792a3f8825fa6253b5b1bfeb7b1999e5cebffe05f3ca9c81aab6c4b3a921280364643f0566f285ebf2bde" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c9519863-23c7-4c40-9bc4-ce362db7e451" /v "GameDVR_GameGUID" /t REG_SZ /d "b57c1fde-bc6f-4847-b086-205590b186fe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c9519863-23c7-4c40-9bc4-ce362db7e451" /v "TitleId" /t REG_SZ /d "1639119975" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\c9519863-23c7-4c40-9bc4-ce362db7e451" /v "MatchedExeFullPath" /t REG_SZ /d "E:\Among.Us.v2020.9.9s\Among Us.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\cc7a8a23-73ee-4311-b901-ac0934555ff8" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\cc7a8a23-73ee-4311-b901-ac0934555ff8" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\cc7a8a23-73ee-4311-b901-ac0934555ff8" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\cc7a8a23-73ee-4311-b901-ac0934555ff8" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000766d2cbd73f32df88bee28812f29a1db2344f4dea59b11c08e3d94cfe4aea4e4000000000e80000000020000200000004b83993140f7cdf953427e54364f4432dff389e133ff5826f61f367d1a4300a0200000004352a14616ade9b91cc8e1acacbc01183245d97446df3d4d214dc272caed941b40000000968ac6f1883e33f400573aa22ad0c2a04d33f812edc5ec5100fa6ad5931cb45a43a28fd1e614519d3d8e447b05ec5010d62714717ed0af73c77ac8d7a47df1ba" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\cc7a8a23-73ee-4311-b901-ac0934555ff8" /v "GameDVR_GameGUID" /t REG_SZ /d "c30f5807-f5c7-485b-b620-fbec6448c354" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\cc7a8a23-73ee-4311-b901-ac0934555ff8" /v "TitleId" /t REG_SZ /d "1635723607" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\cc7a8a23-73ee-4311-b901-ac0934555ff8" /v "ProcessDependencies" /t REG_MULTI_SZ /d "audiodg.exe|1\0battle.net.exe|8\0battle.net helper.exe|8" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\d34d89a7-68fc-4d19-90e7-3a6f206b7ca0" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\d34d89a7-68fc-4d19-90e7-3a6f206b7ca0" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\d34d89a7-68fc-4d19-90e7-3a6f206b7ca0" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\d34d89a7-68fc-4d19-90e7-3a6f206b7ca0" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000f7243cefb9b937ba367886ce3e2892fe28cf0c2aaef121728860cd2fd4357f6d000000000e8000000002000020000000457802b510bdad9175054f199208395fb18fb2b7112d1293a7ad5f0f0388b33230000000b0d108725e8a576b6a66bb88f6d2e8472758058f21b4c8ed75f5cb09b126a802efc0d483894476543de283a382129b9a40000000d9c31d066ffd44b9068a7a197d758c8371a8c4886751410aba6667f878a7ad74e55a7cde12b24bbd57dec28c86db8ad5a24a59ca2b4b39a81e0c889c269e275d" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\d34d89a7-68fc-4d19-90e7-3a6f206b7ca0" /v "GameDVR_GameGUID" /t REG_SZ /d "17ce277e-8b63-4b81-b9c8-0856374906d3" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\d34d89a7-68fc-4d19-90e7-3a6f206b7ca0" /v "TitleId" /t REG_SZ /d "1967200449" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\daff267a-d1b8-46cd-a81a-6d62df3e01bd" /v "Type" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\daff267a-d1b8-46cd-a81a-6d62df3e01bd" /v "Revision" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\daff267a-d1b8-46cd-a81a-6d62df3e01bd" /v "Flags" /t REG_DWORD /d "21" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\daff267a-d1b8-46cd-a81a-6d62df3e01bd" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb0100000047e5addb542ede4580e9545ed0ca78500400000002000000000010660000000100002000000038027a84f65779c781b8f6d2b51bbafb5693a0c323e1438a8c633c174e7cd14b000000000e8000000002000020000000cf2742785f603eaebdf4f12741669af4ecce029326347279995745404cdeda6e700000003cc3b8f6cc83156000e3ca1f24520074d1b624683e304ca2da0e1b9d96665c606e87d1fc5cf07c75319d9df1045a712ff5059e3910ca244e14faef5a4b1ea9f96faada0f4482de78c85eb1865d0daf200a5f607034d740733c996443667676148905551903331800b8e3d1f80a680cf4400000006bb174fde7ab158ca2aa5aa0422ac8f4336db173bea3f0cf4baf874457e1c49a23f0cb49d5cff7b72248d27f9c997c460a39c523256c1ad2e17a3927a163d205" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\df67af05-43cc-40b4-9665-a53aaf762185" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\df67af05-43cc-40b4-9665-a53aaf762185" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\df67af05-43cc-40b4-9665-a53aaf762185" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\df67af05-43cc-40b4-9665-a53aaf762185" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000002c90190a342d9bf938e388c11819906ff2a9c52ff42e4fe073a2dd69d3bc256b000000000e800000000200002000000072428f64acf4546d59ca9f94541357ed54760cb8dfe19a8092661ae29c5a019d40000000a8fc92784b2dfa3d23e6f82dd2d4cdccf446df9a9a73ef8e4f6ed0f8f5afc461845ec36576ae6bf4c6660b7ac5f16b51b6532be2a396d3f260d72c92dcce2c1f4000000053271e618d82c901064ebb7ee8b57e9ce2cbf7d88296aff8ad5c1573e9b1795f205bff08799eeab1500915188d8ec8e90576d8b3d0c42eb4c5039056a259795f" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\df67af05-43cc-40b4-9665-a53aaf762185" /v "GameDVR_GameGUID" /t REG_SZ /d "298d8e69-36b0-4fe9-86dd-90d75d8daad4" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\df67af05-43cc-40b4-9665-a53aaf762185" /v "TitleId" /t REG_SZ /d "1856764962" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\df67af05-43cc-40b4-9665-a53aaf762185" /v "MatchedExeFullPath" /t REG_SZ /d "E:\Valorant\Riot Games\VALORANT\live\ShooterGame\Binaries\Win64\VALORANT-Win64-Shipping.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e45e5935-d67d-4f1c-bccf-bacf6c43fd3c" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e45e5935-d67d-4f1c-bccf-bacf6c43fd3c" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e45e5935-d67d-4f1c-bccf-bacf6c43fd3c" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e45e5935-d67d-4f1c-bccf-bacf6c43fd3c" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000accfc29dc43025bf914cb5fdb7241834960a0297473fbb02002e9edd670bf82c000000000e8000000002000020000000a5a493782a40a1ee24bfe0b08bf763f2e64dd668307b2a2ee8929c9ac659d42c300000002696fa26aa65c34ec87017931c3665eba15acba0eb87efd6c77f013b8f5b132e6b14fd5c5be1315f46e69ed0a50e18f6400000003a95149f54eed0e3e571ceebacbba99ff26a51f3e2f2c3261c64d4e719cef60e5443d99adc96e8d6f1a54f94e707645a675c4d11e807319b9d4cb8c8418809a5" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e45e5935-d67d-4f1c-bccf-bacf6c43fd3c" /v "WorkingDirectory" /t REG_SZ /d "Genshin Impact Game" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e45e5935-d67d-4f1c-bccf-bacf6c43fd3c" /v "GameDVR_GameGUID" /t REG_SZ /d "a45347a2-1f0d-4c04-be2d-8f4af1cc5396" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e45e5935-d67d-4f1c-bccf-bacf6c43fd3c" /v "TitleId" /t REG_SZ /d "1962957406" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e45e5935-d67d-4f1c-bccf-bacf6c43fd3c" /v "MatchedExeFullPath" /t REG_SZ /d "E:\Genshinimpact\Genshin Impact Game\GenshinImpact.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e4d45d34-f695-4946-b390-aafd888b99ba" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e4d45d34-f695-4946-b390-aafd888b99ba" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e4d45d34-f695-4946-b390-aafd888b99ba" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e4d45d34-f695-4946-b390-aafd888b99ba" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa10400000002000000000010660000000100002000000051e2519ac3805838c1cfcbf2c84cf2f695e527f1f42758fc148d4d5c7d5cfd1b000000000e8000000002000020000000e2e77998d9094df1a3c7c8e4d53b65699dbcf128203e9b3c8eb4cc916506235e20000000b87972e674d792f30f06799eb30cf6b958453b92b7cd17f42e864dd5a7ac598540000000f96f569b51488b9d3239aafec3b1306462ad5848692beb81159942fbb8d93123dc32510c9fcb7e3e0e04ab06df6c347fb6b453d4cc7f490b17d9f41147c909ee" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e4d45d34-f695-4946-b390-aafd888b99ba" /v "GameDVR_GameGUID" /t REG_SZ /d "c3f4f46d-343f-4ea8-86dc-d098f7d37e8e" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e4d45d34-f695-4946-b390-aafd888b99ba" /v "TitleId" /t REG_SZ /d "1885819086" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e7644f6a-21c2-441c-97a8-13ed3ba581b3" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e7644f6a-21c2-441c-97a8-13ed3ba581b3" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e7644f6a-21c2-441c-97a8-13ed3ba581b3" /v "Flags" /t REG_DWORD /d "17" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e7644f6a-21c2-441c-97a8-13ed3ba581b3" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa10400000002000000000010660000000100002000000090ad5422929108c621147b2aaf7db30d9ff7181128be6de41e15ccfc33534857000000000e8000000002000020000000df7d0d0482fd0952e964a28b94e1a2741707d5426dc895912d116ab0966732182000000015db14819a71c9fcb074c5b5f130555e79e99e9a3cea4450e734d753830e228540000000b2187a6a40374c577e909d8b7ba47aad7354ee5a05de15a8a4e3713af6ad3fda2d11e01616fa4cbe27735a1df6171a363b9915cb817355a97351a3501951be3b" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e7644f6a-21c2-441c-97a8-13ed3ba581b3" /v "ExeParentDirectory" /t REG_SZ /d "GTAV" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e7644f6a-21c2-441c-97a8-13ed3ba581b3" /v "GameDVR_GameGUID" /t REG_SZ /d "60d5e8cc-84c4-48a1-b0f9-97ad3aaef80a" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e7644f6a-21c2-441c-97a8-13ed3ba581b3" /v "TitleId" /t REG_SZ /d "1862446374" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\e7644f6a-21c2-441c-97a8-13ed3ba581b3" /v "MatchedExeFullPath" /t REG_SZ /d "E:\Grand Theft Auto 5\GTAV\GTA5.exe" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\eaf3cd49-369a-40e7-9294-ca808398be54" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\eaf3cd49-369a-40e7-9294-ca808398be54" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\eaf3cd49-369a-40e7-9294-ca808398be54" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\eaf3cd49-369a-40e7-9294-ca808398be54" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000bb2ca4aa6db33ca596daa91e07368e9e212864a42175b1106648181e9c6a1aea000000000e800000000200002000000035c70844a5ac3b1fc2aa037a8edfb622607ce0a4f88d49dbe176b98b8deeafb2200000001fb03eda6fcc9e9aa372d546346b71c185f2a20279bbf84700b23f4b3d4a9cc040000000d5a83c90eae4820b1f9df490e0161f1658462b8bba4fd26559e56cf3cdc2b6e03bd74a542279cdda8112f3836e2eb236bfe9236725b95ea24c29ddea6518e19b" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\eaf3cd49-369a-40e7-9294-ca808398be54" /v "ExeParentDirectory" /t REG_SZ /d "GRID" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\eaf3cd49-369a-40e7-9294-ca808398be54" /v "GameDVR_GameGUID" /t REG_SZ /d "cc5724d4-30f5-462b-8072-c92d17b68c7c" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\eaf3cd49-369a-40e7-9294-ca808398be54" /v "TitleId" /t REG_SZ /d "1788842502" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000eaa9e5371468084e15832d97bba09c1a1635fde8e7dcc8932027da763679fe0b000000000e8000000002000020000000ac28d58d6b24bcc2af2ca77b73b4130fa17d8c1f91683bcd484e5056a1a0c7a730000000302e70e86e39f6f0dfa5a5757362a3b10311bf2b7acd615238c372ec466db6d6091938398d3cd92016c75f3b954c3ddc40000000396c5a939e89e17f1f9e2f0d188fe8b5dcf49840d90f0f67543bbafad6cdc9b1413a8111dc1ed0dc38819683193e9d015e0ec153d3fd4eb7809574299250240e" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /v "GameDVR_GameGUID" /t REG_SZ /d "c0898033-346c-4910-bbaa-302b00271b09" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /v "TitleId" /t REG_SZ /d "1847408598" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /v "ProcessDependencies" /t REG_MULTI_SZ /d "dwm.exe|8\0audiodg.exe|1\0battle.net.exe|8\0battle.net helper.exe|8" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /v "AGGProfile" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /v "AGCpuAlloc" /t REG_DWORD /d "6" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efcf187d-4945-4351-a98a-75e2174c9622" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efcf187d-4945-4351-a98a-75e2174c9622" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efcf187d-4945-4351-a98a-75e2174c9622" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efcf187d-4945-4351-a98a-75e2174c9622" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000007827db9cf74f3ee354a9562d8ddda269dbcb312278db8dbc30472e1f748c87b2000000000e8000000002000020000000ff009feb08f6d7fd59b5c987055b3840ce59fb50d7e5f263cbb6a4f3bf43a9e3300000005f3412b92a322c2f1144ce5da419f661cd0334f8ddab0b7982030550c786039d9190e3d07e875140c086d9bbd9a88e7840000000e692f89f8ed74b5eb2e0b7ec8dddcd2d524693ca62c22f037de354bcb4ec66ed204c940098e180c58e8c65c92ec863d31fe5ab16c568a3822bf2e5fee8083ca0" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efcf187d-4945-4351-a98a-75e2174c9622" /v "GameDVR_GameGUID" /t REG_SZ /d "a659d45b-c8a5-4387-9dea-7c1df35ac01c" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\efcf187d-4945-4351-a98a-75e2174c9622" /v "TitleId" /t REG_SZ /d "2066051089" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f09e4f3d-0532-4849-be15-84f788238f94" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f09e4f3d-0532-4849-be15-84f788238f94" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f09e4f3d-0532-4849-be15-84f788238f94" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f09e4f3d-0532-4849-be15-84f788238f94" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa10400000002000000000010660000000100002000000037b835da036dc33207405b52ff9331fa8839879acb4c9e65f7b2affdc92b014b000000000e800000000200002000000031f76d7cb95987ce8f5d0fdbe3aa1ebdbf9caf57b8f00c35acac377cd5eb70bb20000000e6228ab74c81d5e99faeb0c6700a0ce3fc2ce33a541f0b8898fcf7af479fb40a40000000c89a9ece63276ae4a82bb033ccaf29bfc1ea109e8995af8a578806b67787410fcdcb5344af0bddb29b5364db7671e9a62399853c95f9684106b0ba89c0ffe852" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f09e4f3d-0532-4849-be15-84f788238f94" /v "GameDVR_GameGUID" /t REG_SZ /d "554b6181-aab1-4c3e-b094-e6d3dbb5b1c7" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f09e4f3d-0532-4849-be15-84f788238f94" /v "TitleId" /t REG_SZ /d "1625658903" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f11b2656-13c5-4853-b40c-b19b585b1848" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f11b2656-13c5-4853-b40c-b19b585b1848" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f11b2656-13c5-4853-b40c-b19b585b1848" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f11b2656-13c5-4853-b40c-b19b585b1848" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000001e73e4c82ba1aef5e7c3c72b7b9c86d7e0cbd6bef6ae6f565e4108890507cab1000000000e8000000002000020000000e9abd925ebcdcaef695775ac41b5479d1abe5df956c47d1e679cf47deea921d11000000020b7e15df0f72ea44831af179a18298c400000001438002231724b7b64b8d2474aa3d395bac952e15afefdb2dfc11d137a19f66cc5bc6b8d102e2baa2c63ad3d785a715d99d7e5cc9d4cac80c8c2dac106282fb5" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f11b2656-13c5-4853-b40c-b19b585b1848" /v "ExeParentDirectory" /t REG_SZ /d "Football Manager 2016" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f11b2656-13c5-4853-b40c-b19b585b1848" /v "GameDVR_GameGUID" /t REG_SZ /d "a8f7ac30-5e5a-4576-9270-9128281651d0" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f11b2656-13c5-4853-b40c-b19b585b1848" /v "TitleId" /t REG_SZ /d "1840192853" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f32dcc88-b7b8-44f9-aa75-65c56b892571" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f32dcc88-b7b8-44f9-aa75-65c56b892571" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f32dcc88-b7b8-44f9-aa75-65c56b892571" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f32dcc88-b7b8-44f9-aa75-65c56b892571" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa10400000002000000000010660000000100002000000068dc6c87eab147d1eb0baed563170a1898c1c397bec1215048e4637cc45d80d6000000000e80000000020000200000007c8a89f77ac452cabeea16be65958a11f0495227a9f742219509c673e77aa97c3000000004be50d61c291c9ef72d6ca3e83db399ec0c22c394be0e7511fe8a598fcc8886da4218bf504cf9ed37296456e518abed40000000ac2d643f068dca838284b6b1e05043acb6d5f7025fdf7f0fe5d9f4a658feb275d830eb2de3b3416f9fb3f6cf3b0845b4c6c809f5739a9df5544563b4449258af" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f32dcc88-b7b8-44f9-aa75-65c56b892571" /v "GameDVR_GameGUID" /t REG_SZ /d "6b4a265d-d929-4b46-afd7-0da75f0dddcd" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f32dcc88-b7b8-44f9-aa75-65c56b892571" /v "TitleId" /t REG_SZ /d "1698925306" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f5c0fdf2-5311-4291-a813-3fc6fd0670b5" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f5c0fdf2-5311-4291-a813-3fc6fd0670b5" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f5c0fdf2-5311-4291-a813-3fc6fd0670b5" /v "Flags" /t REG_DWORD /d "561" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f5c0fdf2-5311-4291-a813-3fc6fd0670b5" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000008a43c2d67c7f48bcdfc64b822d2619be6b1e66065252b5a536c1acc4bd592926000000000e8000000002000020000000370b1153d3d5662262e58a22b9ee2d8e937b7e8701101012fedab16af61c636c100000003cf701741a7f7412ff1ab492dd89cb4f40000000a71e9021ab2e709c6fc293c863f3d3e7d44f53fa54dbde12de4cf9764861d80593532b81aeba4357390ae51814dcf68da6ae28e75a402cd8ea542e67a8c6f3a1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f5c0fdf2-5311-4291-a813-3fc6fd0670b5" /v "ExeParentDirectory" /t REG_SZ /d "Final Fantasy FFX" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f5c0fdf2-5311-4291-a813-3fc6fd0670b5" /v "GameDVR_GameGUID" /t REG_SZ /d "3e51bbe8-2433-4cb0-8c81-5c49d022afad" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f5c0fdf2-5311-4291-a813-3fc6fd0670b5" /v "TitleId" /t REG_SZ /d "1781682593" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f817cc32-56a9-40bd-b0d9-23eea5180be7" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f817cc32-56a9-40bd-b0d9-23eea5180be7" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f817cc32-56a9-40bd-b0d9-23eea5180be7" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f817cc32-56a9-40bd-b0d9-23eea5180be7" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa1040000000200000000001066000000010000200000003cb3df52064dbaf89bfb2d2899f81938d8200bc9d6ab97e5c97fe44d6242baf4000000000e8000000002000020000000108ca93f649200e49f2ee95c6b8190172f97d06925878661b427b6688dce90ba1000000070675e25b1eb9d924dd3196646873c42400000004f4216b189c94ab36cc23716a6ec8f5c7628bcf124c47095f82696b9ea0dd5c2af4201df518ecebbee3471d19c226dfbaf2a4759d91f0b5c711d676067e82a88" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f817cc32-56a9-40bd-b0d9-23eea5180be7" /v "ExeParentDirectory" /t REG_SZ /d "Football Manager 2017" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f817cc32-56a9-40bd-b0d9-23eea5180be7" /v "GameDVR_GameGUID" /t REG_SZ /d "59c1ed54-b5ed-462e-bfc0-533364b6eb1b" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\f817cc32-56a9-40bd-b0d9-23eea5180be7" /v "TitleId" /t REG_SZ /d "2068593342" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\fd061fe8-4abb-49a5-87dc-04b417fc9d58" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\fd061fe8-4abb-49a5-87dc-04b417fc9d58" /v "Revision" /t REG_DWORD /d "1995" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\fd061fe8-4abb-49a5-87dc-04b417fc9d58" /v "Flags" /t REG_DWORD /d "51" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\fd061fe8-4abb-49a5-87dc-04b417fc9d58" /v "Parent" /t REG_BINARY /d "01000000d08c9ddf0115d1118c7a00c04fc297eb010000005646f052f98c0242b48576641e122aa104000000020000000000106600000001000020000000fc81d8225783ddecd2ddbbffa724b4f0389c240ae9956eb78b233abf372145c0000000000e8000000002000020000000d0a997de3b9de7d40d9943a5da76fc160bf306fdf5ffadcdfb1be4d454e75d3c4000000033d3320ef5f834ce0405ff9ac5d61504c9fae3e2232a81abee576fa4353b61a8045e9f29d85c95f0f68db141b7be5fbcacebf93bd7488a04307fd5c8d2f3a2574000000024b91cd156274eb63164985bc3e453b03837563a28b02ecf1eef92aec856916e3c94cd2670ee0e74e8852cf2739852eb771ad7df12b56a06e0c97b94fb8c8a71" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\fd061fe8-4abb-49a5-87dc-04b417fc9d58" /v "GameDVR_GameGUID" /t REG_SZ /d "0dbef0c8-0e99-4215-a848-e66dcc1e552e" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\fd061fe8-4abb-49a5-87dc-04b417fc9d58" /v "TitleId" /t REG_SZ /d "1847408598" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\fd061fe8-4abb-49a5-87dc-04b417fc9d58" /v "ProcessDependencies" /t REG_MULTI_SZ /d "dwm.exe|8\0audiodg.exe|1\0battle.net.exe|8\0battle.net helper.exe|8" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\fd061fe8-4abb-49a5-87dc-04b417fc9d58" /v "AGGProfile" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore\Children\fd061fe8-4abb-49a5-87dc-04b417fc9d58" /v "AGCpuAlloc" /t REG_DWORD /d "6" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableBalloonTips" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f 
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t REG_DWORD /d "0" /f 
Reg.exe add "HKCU\System\GameConfigStore\Parents\0bc97dda792354c9738b56ce8b6486c71f23735b" /v "Children" /t REG_MULTI_SZ /d "70c3139d-9c99-4038-ad15-1d6bf312fb15" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\13db9297cda46cb056db3bc2ca1b76cb297c4bc9" /v "Children" /t REG_MULTI_SZ /d "11163eb8-ff97-4fc8-a4d1-1d46c9565579\05d93a35e-310b-4e76-8967-b97ae66016a2" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\15e1a4ba98e6b8d7ab5ed6b778e0c1319b265846" /v "Children" /t REG_MULTI_SZ /d "40aa1199-5ca0-4ee6-be13-eb5009af6889" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\164de021641dc218ccc9560b9223323ab5028c2b" /v "Children" /t REG_MULTI_SZ /d "e45e5935-d67d-4f1c-bccf-bacf6c43fd3c" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\17d98bb2acb993926de96803a5c39132efc65ae6" /v "Children" /t REG_MULTI_SZ /d "efb98d70-9539-42ef-aa1d-9dc1a4c393d4" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\18645e43f893a0388102a69294599ef555693e6a" /v "Children" /t REG_MULTI_SZ /d "9d41f6f1-5618-4606-a8ec-1100921065fc" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\19ca7875365b44cc1c8d081d2f9f7baa7225c118" /v "Children" /t REG_MULTI_SZ /d "405c1cab-14ed-4e85-97a8-ec71126aa2e7" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\1dac836e9d3d73374af08b598159d227ae66c385" /v "Children" /t REG_MULTI_SZ /d "b1e0341d-a9d2-402c-a242-90ae9b02723c" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\21d43df2829a486c9db797b7a369973eadf496a5" /v "Children" /t REG_MULTI_SZ /d "73400fc2-5ae9-4532-86dd-29d81bae1132" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\2bca56e235e511f19c933498c6dca99dc768874f" /v "Children" /t REG_MULTI_SZ /d "46fc0979-b6fb-4de8-b90d-253cc753d244" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\2ccad2ffd4b63b943db57c84977eb9eafc39407f" /v "Children" /t REG_MULTI_SZ /d "cc7a8a23-73ee-4311-b901-ac0934555ff8" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\3baec0d39784813923364ce0be05a0a5cadea9a6" /v "Children" /t REG_MULTI_SZ /d "40e28932-7ee7-404d-b262-77693fb6f631" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\3f73174dd51c9ac4b7c2d21e36cdf4f619b3dc0a" /v "Children" /t REG_MULTI_SZ /d "f09e4f3d-0532-4849-be15-84f788238f94" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\461a1d0e3274a67f935b9aa1a6542c2303de5b5d" /v "Children" /t REG_MULTI_SZ /d "bba1d6d2-9a61-42e8-8600-e0dafb8fa1d6" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\4e5a7f5000fd4c998166c2662d4b4194217171f6" /v "Children" /t REG_MULTI_SZ /d "c1e4be0f-1b0f-4324-a064-adccbdb98dae" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\54a192d374e9e0f0134509646ebf8797e6a9e951" /v "Children" /t REG_MULTI_SZ /d "37578440-a809-44bd-88fe-2f00932796b4" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\556f7542d20ee2ee986355b044240b4d83998589" /v "Children" /t REG_MULTI_SZ /d "008af23d-f4cc-4435-9422-b95fecf4b177" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\5751eb83e35f2c2a1cff00d464a314d51d61bc8d" /v "Children" /t REG_MULTI_SZ /d "456db1d1-339b-4a77-8b0b-6795a1699345\0a987fbc1-fde0-406f-a039-922a6104ad2f" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\6b7bb0624f10321f62d3e1907984037b693ec034" /v "Children" /t REG_MULTI_SZ /d "d34d89a7-68fc-4d19-90e7-3a6f206b7ca0" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\6ff4490185970e12c42bf9ff6edb6211715ae6f0" /v "Children" /t REG_MULTI_SZ /d "a15993e5-3e93-4968-a526-b96ec64f3995" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\7410f82bb530dfbe6916585ad3dec34738eee856" /v "Children" /t REG_MULTI_SZ /d "326c86ae-f3a9-4980-8b9e-1da326311c76" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\747b52f67b4650136507fee1134415172c89cb72" /v "Children" /t REG_MULTI_SZ /d "241e0838-282a-453c-bf0c-b453987e7fa3" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\760cbffe1bb3645cf041d74c5fd01959666e4b71" /v "Children" /t REG_MULTI_SZ /d "5bb62464-0905-4a39-b7e4-317edb6f0b33" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\78362f170001b9043c42ad7a29b7093e69a12e36" /v "Children" /t REG_MULTI_SZ /d "c197c13c-6b0c-4810-81d1-548ed723a399" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\784cd9ae7b605f77cbab744e674eaed0fadf9da4" /v "Children" /t REG_MULTI_SZ /d "50ef2ba5-7013-4e09-917e-2e77e806b4d4" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\7cc4477119972383c7fc71b5f96e02b364bba0a8" /v "Children" /t REG_MULTI_SZ /d "ae876636-f272-4eb2-aaa6-a110af0bd907" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\7ff175d986357b05f6f779b329e471b9bd3e1397" /v "Children" /t REG_MULTI_SZ /d "eaf3cd49-369a-40e7-9294-ca808398be54" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\818bbb92210157befde3d513732a0f68fcb21f22" /v "Children" /t REG_MULTI_SZ /d "b184ff46-9cdc-4e94-b598-5e5db72274a2" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\83d1c9503115e7a5bd770352f612762236d960a0" /v "Children" /t REG_MULTI_SZ /d "40406386-7428-4521-a6f9-2f0581086ddf" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\86ac5f666fad6fe265cd9f69fa56309e34359f05" /v "Children" /t REG_MULTI_SZ /d "9fc09f67-272f-43f3-8c0b-2557f99f08fd" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\9d706dfab071ca7347ab3a1414917e3b7e921565" /v "Children" /t REG_MULTI_SZ /d "7c6c29ed-6638-4b39-87c9-90749f34fd0f" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\9dd084799375aa6369c95c0e6dce89f6faa084ba" /v "Children" /t REG_MULTI_SZ /d "0731122e-f429-4e74-8501-842bc3d88850" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\9e5c30e60b97bc1279cd05f0922c71e64dc1855b" /v "Children" /t REG_MULTI_SZ /d "00e51963-7a20-47e8-86dd-c5061773edad" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\a50cecbc1813396c210d4878031f61788e7fa199" /v "Children" /t REG_MULTI_SZ /d "43c24735-989f-477c-8ced-dc705c0a60aa" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\a6ec42280ea39e6cfb7748477a1f50b3bd4168f6" /v "Children" /t REG_MULTI_SZ /d "c9519863-23c7-4c40-9bc4-ce362db7e451" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\a86e29e1b9b350d33c81de049a2f90d7d01300b6" /v "Children" /t REG_MULTI_SZ /d "8d4cda1b-ff25-4b90-b9eb-212e1939db2c" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\a921abdb05dbf53aab652322f6593dee42c2b1ed" /v "Children" /t REG_MULTI_SZ /d "4f561632-47cd-4c2b-93a9-e1da865f03ba" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\a9ddf809324ceacc524160285cfa19772e1bd810" /v "Children" /t REG_MULTI_SZ /d "77b4d6e3-85d7-4ae9-ad9b-52b42f98077f" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\aeea45e8f7554649a505fbab6d8dc9ecf551216d" /v "Children" /t REG_MULTI_SZ /d "fd061fe8-4abb-49a5-87dc-04b417fc9d58" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\b22d1f8f1f566b00e9043a2cade7c2134f29bb4e" /v "Children" /t REG_MULTI_SZ /d "df67af05-43cc-40b4-9665-a53aaf762185" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\b41b8262de472dbbdc8020df06aa2c0b7e3ea813" /v "Children" /t REG_MULTI_SZ /d "f32dcc88-b7b8-44f9-aa75-65c56b892571" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\b4806c5e824b322a99b84056515450922fe5640a" /v "Children" /t REG_MULTI_SZ /d "e4d45d34-f695-4946-b390-aafd888b99ba" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\ba53742a9490396f8c5033fde191afc9be8dee59" /v "Children" /t REG_MULTI_SZ /d "5cdff6ad-e34e-4062-877b-3fe82e7c8949" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\ba6a31c3a81dac0acfb3b70d1c3f2730049c020d" /v "Children" /t REG_MULTI_SZ /d "04cc06c9-e532-4b12-a143-77fc1cb3283a" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\bb86857323422599613eeec70a2c8fb69a1b5048" /v "Children" /t REG_MULTI_SZ /d "f5c0fdf2-5311-4291-a813-3fc6fd0670b5" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\beeaf57760b6078f2048d7ac5a1569c40a224ddb" /v "Children" /t REG_MULTI_SZ /d "b8b48b38-1c19-4dd7-ae69-3ba5cbab0db0" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\bf76d7aa2319c58db1fcc054a1d6ebc68d7ec02d" /v "Children" /t REG_MULTI_SZ /d "daff267a-d1b8-46cd-a81a-6d62df3e01bd" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\c864119dc43a344a0cea2e48e3152ff47bc2aea4" /v "Children" /t REG_MULTI_SZ /d "0a956050-9628-4220-b516-808e497417c6" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\c8f36f5d2b339324d4e0350447a928b0a59dedb8" /v "Children" /t REG_MULTI_SZ /d "6053cdf7-6d52-42c8-9967-a29a542b7ae1" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\c8f57eb7877c46cdc947e3858c73ae5a90b800a2" /v "Children" /t REG_MULTI_SZ /d "9b9b54e1-b0b2-42f8-b46a-63386dd30005" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\cd628eff300490dd25e28b5bd6867dd5b3a119af" /v "Children" /t REG_MULTI_SZ /d "e7644f6a-21c2-441c-97a8-13ed3ba581b3\037b0bb90-816e-4853-b8e4-b943541b2f03" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\d2dd1c0d911ca04f99087a96acbc876968e287bb" /v "Children" /t REG_MULTI_SZ /d "efcf187d-4945-4351-a98a-75e2174c9622" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\d30a8f0e5e4a0e9287cac0649e8567053f6228c4" /v "Children" /t REG_MULTI_SZ /d "c83d8550-bfd3-4fe6-a5ed-256363e86756" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\db731c30be44928da277be5eb0d3ed1b191da99c" /v "Children" /t REG_MULTI_SZ /d "70df813c-6159-4d82-b679-3b79c7aa6cb1" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\dccff1b68e615cd9388a94b302b7211469ed58dd" /v "Children" /t REG_MULTI_SZ /d "4787b2ac-d4ec-45b8-818a-bfaa6ff7daa3" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\e248deb5fd1953c61c576f79afec8755e3ce6b2b" /v "Children" /t REG_MULTI_SZ /d "3409f26f-7bae-42a6-9c74-99c544ce5476" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\e37cabb84155061d2de72ac9e8b633373e5f4e03" /v "Children" /t REG_MULTI_SZ /d "bdf4f2dc-25d6-4cb4-8f2c-c268c4b0e339" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\e65172718d545564b6d96726e22492027026b92a" /v "Children" /t REG_MULTI_SZ /d "3f43ed16-df66-4422-abd8-925b1350bb64" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\e8e54db2f478e83bccbe834d2ee69fc21c7b9991" /v "Children" /t REG_MULTI_SZ /d "9253f3de-1abd-412c-8fca-25196b323e44" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\ea33dbb01c010936a19f91c660f93b49001a49b9" /v "Children" /t REG_MULTI_SZ /d "89012e6d-35ec-4578-bdbd-1e9c2f91d561" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\ed8fd9401e0c084095e97928a94b5ced4a9f0dc0" /v "Children" /t REG_MULTI_SZ /d "f11b2656-13c5-4853-b40c-b19b585b1848\0f817cc32-56a9-40bd-b0d9-23eea5180be7\088bba3e3-6149-435f-8f03-2e763a6b28e5" /f
Reg.exe add "HKCU\System\GameConfigStore\Parents\fd13f746e7d2d69760b017363f621255c9b49ac8" /v "Children" /t REG_MULTI_SZ /d "0f715c27-e790-401f-b0a4-58a636f50f48" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "300" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "100" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "300" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AAF_NA" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AntiAlias_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ASTT_NA" /t REG_SZ /d "0" /f
sc stop DiagTrack
sc config DiagTrack start= disabled
sc stop dmwappushservice
sc config dmwappushservice start= disabled
sc stop diagnosticshub.standardcollector.service
sc config diagnosticshub.standardcollector.service start= disabled
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" /v "DisableMFUTracking" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\MicrosoftEdge\Main" /v "AllowPrelaunch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\JavaSoft" /v "SPONSORS" /t REG_SZ /d "DISABLE" /f
Reg.exe add "HKLM\Wow6432Node\SOFTWARE\JavaSoft" /v "SPONSORS" /t REG_SZ /d "DISABLE" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "8" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "8" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\CursorShadow" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DropShadow" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMAeroPeekEnabled" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMEnabled" /v "DefaultApplied" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMSaveThumbnailEnabled" /v "DefaultApplied" /t REG_SZ /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\FontSmoothing" /v "DefaultApplied" /t REG_SZ /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListBoxSmoothScrolling" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewAlphaSelect" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewShadow" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\SelectionFade" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimations" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ThumbnailsOrIcon" /v "DefaultApplied" /t REG_SZ /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation" /v "DefaultApplied" /t REG_SZ /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchSafeSearch" /t REG_DWORD /d 3 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d 3 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\SQMClient" /v "CorporateSQMURL" /t REG_SZ /d 127.0.0.1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Steps-Recorder" /v "Enabled" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Telemetry" /v "Enabled" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Inventory" /v "Enabled" /t REG_DWORD /d 0 /f 
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Compatibility-Troubleshooter" /v "Enabled" /t REG_DWORD /d 0 /f 
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Compatibility-Assistant/Trace" /v "Enabled" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Compatibility-Assistant/Compatibility-Infrastructure-Debug" /v "Enabled" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Compatibility-Assistant/Analytic" /v "Enabled" /t REG_DWORD /d 0 /f 
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Compatibility-Assistant" /v "Enabled" /t REG_DWORD /d 0 /f 
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
REG ADD "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /v "f!proactive-telemetry-inter_58073761d33f144b" /t REG_DWORD /d 0 /f
REG ADD "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /v "f!proactive-telemetry-event_8ac43a41e5030538" /t REG_DWORD /d 0 /f
REG ADD "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /v "f!proactive-telemetry.js" /t REG_DWORD /d 0 /f
REG ADD "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /v "f!dss-winrt-telemetry.js" /t REG_DWORD /d 0 /f
REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /t REG_DWORD /d 1 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
REG ADD "HKCR\lnkfile" /v "NeverShowExt" /f
REG ADD "HKCR\IE.AssocFile.URL" /v "NeverShowExt" /f
REG ADD "HKCR\IE.AssocFile.WEBSITE" /v "NeverShowExt" /f
REG ADD "HKCR\InternetShortcut" /v "NeverShowExt" /f
REG ADD "HKCR\Microsoft.Website" /v "NeverShowExt" /f
REG ADD "HKCR\piffile" /v "NeverShowExt" /f
REG ADD "HKCR\SHCmdFile" /v "NeverShowExt" /f
REG ADD "HKCR\LibraryFolder" /v "NeverShowExt" /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
REG ADD "HKCU\Control Panel\International" /v "iMeasure" /t REG_SZ /d "0" /f
REG ADD "HKCU\Control Panel\International" /v "iNegCurr" /t REG_SZ /d "1" /f
REG ADD "HKCU\Control Panel\International" /v "iTime" /t REG_SZ /d "1" /f
REG ADD "HKCU\Control Panel\International" /v "sShortDate" /t REG_SZ /d "dd.MM.yyyy" /f
REG ADD "HKCU\Control Panel\International" /v "sShortTime" /t REG_SZ /d "HH:mm" /f
REG ADD "HKCU\Control Panel\International" /v "sTimeFormat" /t REG_SZ /d "H:mm:ss" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
PowerShell -Command "Get-AppxPackage -allusers *3DBuilder* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Office.OneNote* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *people* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *solit* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Twitter* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WindowsSoundRecorder* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *zune* | Remove-AppxPackage"
Powershell.exe -command "& {Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage}
Powershell.exe -command "& {Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage}
Powershell.exe -command "& {Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage}
Powershell.exe -command "& {Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage}
Powershell -Command "New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force"
Powershell -Command "Get-Process explorer | Stop-Process"
Powershell -Command "winget uninstall "Windows web experience Pack"​
setlocal EnableExtensions DisableDelayedExpansion
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d 5 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /t REG_DWORD /v "Enabled" /d 0 /f
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t "REG_DWORD" /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v " SpyNetReporting" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v " SubmitSamplesConsent" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /d "0" /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\VSCommon\16.0\IntelliCode" /v "DisableRemoteAnalysis" /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\VSCommon\17.0\IntelliCode" /v "DisableRemoteAnalysis" /d 1 /f
PowerShell -ExecutionPolicy Unrestricted -Command "$settingKey='telemetry.enableTelemetry'; $settingValue=$false; $jsonFilePath = "^""$($env:APPDATA)\Code\User\settings.json"^""; if (!(Test-Path $jsonFilePath -PathType Leaf)) {; Write-Host "^""Skipping, no updates. Settings file was not at `"^""$jsonFilePath`"^""."^""; exit 0; }; try {; $fileContent = Get-Content $jsonFilePath -ErrorAction Stop; } catch {; throw "^""Error, failed to read the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; if ([string]::IsNullOrWhiteSpace($fileContent)) {; Write-Host "^""Settings file is empty. Treating it as default empty JSON object."^""; $fileContent = "^""{}"^""; }; try {; $json = $fileContent | ConvertFrom-Json; } catch {; throw "^""Error, invalid JSON format in the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; $existingValue = $json.$settingKey; if ($existingValue -eq $settingValue) {; Write-Host "^""Skipping, `"^""$settingKey`"^"" is already configured as `"^""$settingValue`"^""."^""; exit 0; }; $json | Add-Member -Type NoteProperty -Name $settingKey -Value $settingValue -Force; $json | ConvertTo-Json | Set-Content $jsonFilePath; Write-Host "^""Successfully applied the setting to the file: `"^""$jsonFilePath`"^""."^"""
PowerShell -ExecutionPolicy Unrestricted -Command "$settingKey='telemetry.enableCrashReporter'; $settingValue=$false; $jsonFilePath = "^""$($env:APPDATA)\Code\User\settings.json"^""; if (!(Test-Path $jsonFilePath -PathType Leaf)) {; Write-Host "^""Skipping, no updates. Settings file was not at `"^""$jsonFilePath`"^""."^""; exit 0; }; try {; $fileContent = Get-Content $jsonFilePath -ErrorAction Stop; } catch {; throw "^""Error, failed to read the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; if ([string]::IsNullOrWhiteSpace($fileContent)) {; Write-Host "^""Settings file is empty. Treating it as default empty JSON object."^""; $fileContent = "^""{}"^""; }; try {; $json = $fileContent | ConvertFrom-Json; } catch {; throw "^""Error, invalid JSON format in the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; $existingValue = $json.$settingKey; if ($existingValue -eq $settingValue) {; Write-Host "^""Skipping, `"^""$settingKey`"^"" is already configured as `"^""$settingValue`"^""."^""; exit 0; }; $json | Add-Member -Type NoteProperty -Name $settingKey -Value $settingValue -Force; $json | ConvertTo-Json | Set-Content $jsonFilePath; Write-Host "^""Successfully applied the setting to the file: `"^""$jsonFilePath`"^""."^"""
 -ExecutionPolicy Unrestricted -Command "$settingKey='workbench.enableExperiments'; $settingValue=$false; $jsonFilePath = "^""$($env:APPDATA)\Code\User\settings.json"^""; if (!(Test-Path $jsonFilePath -PathType Leaf)) {; Write-Host "^""Skipping, no updates. Settings file was not at `"^""$jsonFilePath`"^""."^""; exit 0; }; try {; $fileContent = Get-Content $jsonFilePath -ErrorAction Stop; } catch {; throw "^""Error, failed to read the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; if ([string]::IsNullOrWhiteSpace($fileContent)) {; Write-Host "^""Settings file is empty. Treating it as default empty JSON object."^""; $fileContent = "^""{}"^""; }; try {; $json = $fileContent | ConvertFrom-Json; } catch {; throw "^""Error, invalid JSON format in the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; $existingValue = $json.$settingKey; if ($existingValue -eq $settingValue) {; Write-Host "^""Skipping, `"^""$settingKey`"^"" is already configured as `"^""$settingValue`"^""."^""; exit 0; }; $json | Add-Member -Type NoteProperty -Name $settingKey -Value $settingValue -Force; $json | ConvertTo-Json | Set-Content $jsonFilePath; Write-Host "^""Successfully applied the setting to the file: `"^""$jsonFilePath`"^""."^"""
PowerShell -ExecutionPolicy Unrestricted -Command "$settingKey='update.mode'; $settingValue=manual; $jsonFilePath = "^""$($env:APPDATA)\Code\User\settings.json"^""; if (!(Test-Path $jsonFilePath -PathType Leaf)) {; Write-Host "^""Skipping, no updates. Settings file was not at `"^""$jsonFilePath`"^""."^""; exit 0; }; try {; $fileContent = Get-Content $jsonFilePath -ErrorAction Stop; } catch {; throw "^""Error, failed to read the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; if ([string]::IsNullOrWhiteSpace($fileContent)) {; Write-Host "^""Settings file is empty. Treating it as default empty JSON object."^""; $fileContent = "^""{}"^""; }; try {; $json = $fileContent | ConvertFrom-Json; } catch {; throw "^""Error, invalid JSON format in the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; $existingValue = $json.$settingKey; if ($existingValue -eq $settingValue) {; Write-Host "^""Skipping, `"^""$settingKey`"^"" is already configured as `"^""$settingValue`"^""."^""; exit 0; }; $json | Add-Member -Type NoteProperty -Name $settingKey -Value $settingValue -Force; $json | ConvertTo-Json | Set-Content $jsonFilePath; Write-Host "^""Successfully applied the setting to the file: `"^""$jsonFilePath`"^""."^"""
PowerShell -ExecutionPolicy Unrestricted -Command "$settingKey='update.showReleaseNotes'; $settingValue=$false; $jsonFilePath = "^""$($env:APPDATA)\Code\User\settings.json"^""; if (!(Test-Path $jsonFilePath -PathType Leaf)) {; Write-Host "^""Skipping, no updates. Settings file was not at `"^""$jsonFilePath`"^""."^""; exit 0; }; try {; $fileContent = Get-Content $jsonFilePath -ErrorAction Stop; } catch {; throw "^""Error, failed to read the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; if ([string]::IsNullOrWhiteSpace($fileContent)) {; Write-Host "^""Settings file is empty. Treating it as default empty JSON object."^""; $fileContent = "^""{}"^""; }; try {; $json = $fileContent | ConvertFrom-Json; } catch {; throw "^""Error, invalid JSON format in the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; $existingValue = $json.$settingKey; if ($existingValue -eq $settingValue) {; Write-Host "^""Skipping, `"^""$settingKey`"^"" is already configured as `"^""$settingValue`"^""."^""; exit 0; }; $json | Add-Member -Type NoteProperty -Name $settingKey -Value $settingValue -Force; $json | ConvertTo-Json | Set-Content $jsonFilePath; Write-Host "^""Successfully applied the setting to the file: `"^""$jsonFilePath`"^""."^"""
PowerShell -ExecutionPolicy Unrestricted -Command "$settingKey='extensions.autoCheckUpdates'; $settingValue=$false; $jsonFilePath = "^""$($env:APPDATA)\Code\User\settings.json"^""; if (!(Test-Path $jsonFilePath -PathType Leaf)) {; Write-Host "^""Skipping, no updates. Settings file was not at `"^""$jsonFilePath`"^""."^""; exit 0; }; try {; $fileContent = Get-Content $jsonFilePath -ErrorAction Stop; } catch {; throw "^""Error, failed to read the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; if ([string]::IsNullOrWhiteSpace($fileContent)) {; Write-Host "^""Settings file is empty. Treating it as default empty JSON object."^""; $fileContent = "^""{}"^""; }; try {; $json = $fileContent | ConvertFrom-Json; } catch {; throw "^""Error, invalid JSON format in the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; $existingValue = $json.$settingKey; if ($existingValue -eq $settingValue) {; Write-Host "^""Skipping, `"^""$settingKey`"^"" is already configured as `"^""$settingValue`"^""."^""; exit 0; }; $json | Add-Member -Type NoteProperty -Name $settingKey -Value $settingValue -Force; $json | ConvertTo-Json | Set-Content $jsonFilePath; Write-Host "^""Successfully applied the setting to the file: `"^""$jsonFilePath`"^""."^"""
PowerShell -ExecutionPolicy Unrestricted -Command "$settingKey='extensions.showRecommendationsOnlyOnDemand'; $settingValue=$true; $jsonFilePath = "^""$($env:APPDATA)\Code\User\settings.json"^""; if (!(Test-Path $jsonFilePath -PathType Leaf)) {; Write-Host "^""Skipping, no updates. Settings file was not at `"^""$jsonFilePath`"^""."^""; exit 0; }; try {; $fileContent = Get-Content $jsonFilePath -ErrorAction Stop; } catch {; throw "^""Error, failed to read the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; if ([string]::IsNullOrWhiteSpace($fileContent)) {; Write-Host "^""Settings file is empty. Treating it as default empty JSON object."^""; $fileContent = "^""{}"^""; }; try {; $json = $fileContent | ConvertFrom-Json; } catch {; throw "^""Error, invalid JSON format in the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; $existingValue = $json.$settingKey; if ($existingValue -eq $settingValue) {; Write-Host "^""Skipping, `"^""$settingKey`"^"" is already configured as `"^""$settingValue`"^""."^""; exit 0; }; $json | Add-Member -Type NoteProperty -Name $settingKey -Value $settingValue -Force; $json | ConvertTo-Json | Set-Content $jsonFilePath; Write-Host "^""Successfully applied the setting to the file: `"^""$jsonFilePath`"^""."^"""
PowerShell -ExecutionPolicy Unrestricted -Command "$settingKey='git.autofetch'; $settingValue=$false; $jsonFilePath = "^""$($env:APPDATA)\Code\User\settings.json"^""; if (!(Test-Path $jsonFilePath -PathType Leaf)) {; Write-Host "^""Skipping, no updates. Settings file was not at `"^""$jsonFilePath`"^""."^""; exit 0; }; try {; $fileContent = Get-Content $jsonFilePath -ErrorAction Stop; } catch {; throw "^""Error, failed to read the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; if ([string]::IsNullOrWhiteSpace($fileContent)) {; Write-Host "^""Settings file is empty. Treating it as default empty JSON object."^""; $fileContent = "^""{}"^""; }; try {; $json = $fileContent | ConvertFrom-Json; } catch {; throw "^""Error, invalid JSON format in the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; $existingValue = $json.$settingKey; if ($existingValue -eq $settingValue) {; Write-Host "^""Skipping, `"^""$settingKey`"^"" is already configured as `"^""$settingValue`"^""."^""; exit 0; }; $json | Add-Member -Type NoteProperty -Name $settingKey -Value $settingValue -Force; $json | ConvertTo-Json | Set-Content $jsonFilePath; Write-Host "^""Successfully applied the setting to the file: `"^""$jsonFilePath`"^""."^"""
PowerShell -ExecutionPolicy Unrestricted -Command "$settingKey='npm.fetchOnlinePackageInfo'; $settingValue=$false; $jsonFilePath = "^""$($env:APPDATA)\Code\User\settings.json"^""; if (!(Test-Path $jsonFilePath -PathType Leaf)) {; Write-Host "^""Skipping, no updates. Settings file was not at `"^""$jsonFilePath`"^""."^""; exit 0; }; try {; $fileContent = Get-Content $jsonFilePath -ErrorAction Stop; } catch {; throw "^""Error, failed to read the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; if ([string]::IsNullOrWhiteSpace($fileContent)) {; Write-Host "^""Settings file is empty. Treating it as default empty JSON object."^""; $fileContent = "^""{}"^""; }; try {; $json = $fileContent | ConvertFrom-Json; } catch {; throw "^""Error, invalid JSON format in the settings file: `"^""$jsonFilePath`"^"". Error: $_"^""; }; $existingValue = $json.$settingKey; if ($existingValue -eq $settingValue) {; Write-Host "^""Skipping, `"^""$settingKey`"^"" is already configured as `"^""$settingValue`"^""."^""; exit 0; }; $json | Add-Member -Type NoteProperty -Name $settingKey -Value $settingValue -Force; $json | ConvertTo-Json | Set-Content $jsonFilePath; Write-Host "^""Successfully applied the setting to the file: `"^""$jsonFilePath`"^""."^"""
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common" /v "QMEnable" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common" /v "QMEnable" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f
:: Disable scheduled task(s): `\Microsoft\Office\OfficeTelemetryAgentFallBack`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='OfficeTelemetryAgentFallBack'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Office\OfficeTelemetryAgentFallBack2016`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='OfficeTelemetryAgentFallBack2016'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Office\OfficeTelemetryAgentLogOn`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='OfficeTelemetryAgentLogOn'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Office\OfficeTelemetryAgentLogOn2016`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='OfficeTelemetryAgentLogOn2016'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Office\Office 15 Subscription Heartbeat`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='Office 15 Subscription Heartbeat'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable service(s): `AdobeARMservice`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'AdobeARMservice'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: Disable service(s): `adobeupdateservice`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'adobeupdateservice'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: Disable scheduled task(s): `\Adobe Acrobat Update Task`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='Adobe Acrobat Update Task'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable service(s): `dbupdate`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'dbupdate'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: Disable service(s): `dbupdatem`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'dbupdatem'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: Disable scheduled task(s): `\DropboxUpdateTaskMachineUA`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='DropboxUpdateTaskMachineUA'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\DropboxUpdateTaskMachineCore`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='DropboxUpdateTaskMachineCore'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventCDDVDMetadataRetrieval" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventMusicFileMetadataRetrieval" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventRadioPresetsRetrieval" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'WMPNetworkSvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
reg add "HKCU\Software\Piriform\CCleaner" /v "Monitoring" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "HelpImproveCCleaner" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "SystemMonitoring" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateAuto" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateCheck" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "CheckTrialOffer" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)HealthCheck" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)QuickClean" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)QuickCleanIpm" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)GetIpmForTrial" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdater" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdaterIpm" /t REG_DWORD /d 0 /f
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'Razer Game Scanner Service'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'RetailDemo'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "CreateDesktopShortcutDefault" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "CreateDesktopShortcut{2CD8A007-E189-409D-A2C8-9AF4EF3C72AA}????" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "CreateDesktopShortcut{65C35B14-6C1D-4122-AC46-7148CC9D6497}????" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "CreateDesktopShortcut{0D50BFEC-CD6A-4F9A-964C-C7416E3ACB10}????" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "CreateDesktopShortcut{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeEnhanceImagesEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ShowRecommendationsEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" /v "DisableMFUTracking" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" /v "DisableMFUTracking" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d "1" /f
Reg.exe delete "HKCR\*\shellex\ContextMenuHandlers\Sharing" /f
Reg.exe delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\Sharing" /f
Reg.exe delete "HKCR\Directory\shellex\ContextMenuHandlers\Sharing" /f
Reg.exe delete "HKCR\Directory\shellex\CopyHookHandlers\Sharing" /f
Reg.exe delete "HKCR\Directory\shellex\PropertySheetHandlers\Sharing" /f
Reg.exe delete "HKCR\Drive\shellex\ContextMenuHandlers\Sharing" /f
Reg.exe delete "HKCR\Drive\shellex\PropertySheetHandlers\Sharing" /f
Reg.exe delete "HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" /f
Reg.exe delete "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" /f
Reg.exe delete "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /f
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
Reg.exe delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f
Reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_IrisRecommendations" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Suggested" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT" /v "MUIVerb" /t REG_SZ /d "Appearance" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT" /v "Position" /t REG_SZ /d "Bottom" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT" /v "SubCommands" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\01DesktopBackground" /v "Icon" /t REG_SZ /d "imageres.dll,-110" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\01DesktopBackground" /v "MUIVerb" /t REG_SZ /d "Desktop Background" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\01DesktopBackground\Command" /ve /t REG_SZ /d "explorer.exe shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921} -Microsoft.Personalization\pageWallpaper" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\02Color" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\02Color" /v "MUIVerb" /t REG_SZ /d "Color" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\02Color\Command" /ve /t REG_SZ /d "explorer.exe shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921} -Microsoft.Personalization\pageColorization" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\03Sounds" /v "Icon" /t REG_SZ /d "mmsys.cpl" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\03Sounds" /v "MUIVerb" /t REG_SZ /d "Sounds" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\03Sounds\Command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl ,2" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\04Screen Saver" /v "Icon" /t REG_SZ /d "PhotoScreensaver.scr" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\04Screen Saver" /v "MUIVerb" /t REG_SZ /d "Screen Saver" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\04Screen Saver\Command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,screensaver,@screensaver" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\05DesktopIcons" /v "Icon" /t REG_SZ /d "desk.cpl" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\05DesktopIcons" /v "MUIVerb" /t REG_SZ /d "Change desktop icons" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\05DesktopIcons" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\05DesktopIcons\Command" /ve /t REG_SZ /d "rundll32 shell32.dll,Control_RunDLL desk.cpl,,0" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\06Cursors" /v "Icon" /t REG_SZ /d "main.cpl" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\06Cursors" /v "MUIVerb" /t REG_SZ /d "Change mouse pointers" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\06Cursors\Command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\07Display" /v "Icon" /t REG_SZ /d "display.dll,-1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\07Display" /v "MUIVerb" /t REG_SZ /d "Classic Display options" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\07Display" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Appearance_WAT\Shell\07Display\Command" /ve /t REG_SZ /d "control.exe desk.cpl,Settings,@Settings" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "3" /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool" /v "MUIVerb" /t REG_SZ /d "@SnippingTool.exe,-101" /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool" /v "SubCommands" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool" /v "Icon" /t REG_SZ /d "SnippingTool.exe" /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool" /v "Position" /t REG_SZ /d "Bottom" /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool\Shell\1SnippingTool" /v "MUIVerb" /t REG_SZ /d "@SnippingTool.exe,-101" /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool\Shell\1SnippingTool" /v "Icon" /t REG_SZ /d "SnippingTool.exe" /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool\Shell\1SnippingTool\command" /ve /t REG_SZ /d "SnippingTool.exe" /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool\Shell\2SnippingToolRegion" /v "MUIVerb" /t REG_SZ /d "@SnippingTool.exe,-15052" /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool\Shell\2SnippingToolRegion" /v "Icon" /t REG_SZ /d "SnippingTool.exe" /f
Reg.exe add "HKCR\DesktopBackground\Shell\SnippingTool\Shell\2SnippingToolRegion\command" /ve /t REG_SZ /d "SnippingTool.exe /clip" /f
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT" > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" > nul 2>&1 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" > nul 2>&1 
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Application Experience\StartupAppTask" > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" > nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable > nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" > nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /f
cls
echo Registry files were added!
timeout /t 3
echo sending back to main screen
goto menu

:delay
cls
echo You are improving your mouse and keyboard delay
call :IsAdmin
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShellState" /t REG_BINARY /d "240000003E28000000000000000000000000000001000000130000000000000072000000" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d "1" /f
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /s /f "Scaling"^| findstr "HKEY"') do reg.exe add "%%i" /v "Scaling" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Mouse" /v "ActiveWindowTracking" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "Beep" /t REG_SZ /d "No" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "DoubleClickHeight" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "DoubleClickSpeed" /t REG_SZ /d "500" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "DoubleClickWidth" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "ExtendedSounds" /t REG_SZ /d "No" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverHeight" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "400" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverWidth" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "6" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "10" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseTrails" /t REG_SZ /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDeviceBaseName" /t REG_SZ /d "KeyboardClass" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "SendOutputToAllPorts" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "WppRecorder_TraceGuid" /t REG_SZ /d "{09281f1f-f66e-485a-99a2-91638f782c49}" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "50" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "WppRecorder_TraceGuid" /t REG_SZ /d "{fc8df8fd-d105-40a9-af75-2eec294adf8d}" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "50" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "ConnectMultiplePorts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "MaximumPortsServiced" /t REG_DWORD /d "3" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "00000000000000000000000000000000000000000000000000000000000000000000640000000000" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "00000000000000000000000000000000000000000000000000000000000000000001500100000000" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "SnapToDefaultButton" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "SwapMouseButtons" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "AutoRepeatDelay" /t REG_SZ /d "200" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "AutoRepeatRate" /t REG_SZ /d "40" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "BounceTime" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "DelayBeforeAcceptance" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038010020000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
cls
echo Registry files for improving mouse and delay were added!
timeout /t 3
goto menu

:hard_clean
cls
echo You are clearing cache files (WAIT UNTIL PROCESSED)
net stop wuauserv
del /q /f /s %windir%\SoftwareDistribution\Download\*
net start wuauserv
if exist %windir%\Prefetch\ (
    del /q /f /s %windir%\Prefetch\*
    echo Cleared prefetch files!
) else (
    echo Prefetch directory not found or empty.
)
wsreset
echo Cleared windows store cache!
del /q /f /s %windir%\Logs\*
echo Cleared log cache!
if exist %windir%\Minidump\ (
    del /q /f /s %windir%\Minidump\*
    echo Cleared memory dump cache!
) else (
    echo 
net stop dosvc
del /q /f /s %windir%\SoftwareDistribution\DeliveryOptimization\*
net start dosvc
echo Cleared windows delivery optimiation cache!
del /q /f /s "%LocalAppData%\D3DSCache\*"
echo Cleared DirectX cache!
cls
echo ALL PC cache cleared!
timeout /t 3
goto menu
echo sending back to main screen
goto zMemory dump files directory not found or empty.
)


:hard_wifi_clean
cls
call :IsAdmin
echo You are clearing your dns cache and browser cache!
del /q /f /s "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*"
start /wait "" "C:\Program Files\Mozilla Firefox\firefox.exe" -P "default" -no-remote -safe-mode -jsconsole -clearcache
del /q /f /s "%AppData%\Opera Software\Opera GX Stable\Cache\*"
del /q /f /s "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\Cache\*"
ipconfig /flushdns
cls
echo You flushed all your internet cache!
timeout /t 3
goto menu

:about
cls
color 0E
mode 300
title Bhaggo's Quick Cleaner         
start https://www.youtube.com/@BhaggoYT?sub_confirmation=1
echo.* * * * * * * * * * * * * * * * * * * * * * * * * * 
echo * "______________                               ";* 
echo * "___  __ )__  /_______ _______ _______ ______ ";* 
echo * "__  __  |_  __ \  __ `/_  __ `/_  __ `/  __ \";* 
echo * "_  /_/ /_  / / / /_/ /_  /_/ /_  /_/ // /_/ /";* 
echo * "/_____/ /_/ /_/\__,_/ _\__, / _\__, / \____/ ";*
echo * "                      /____/  /____/         ";*  
echo.* * * * * * * * * * * * * * * * * * * * * * * * * * 

echo.
echo *********************************
color 09
echo.
echo !! PLEASE MAKE SURE YOU CREATE A REGISTRY BACKUP FILE AND A SYSTEM RESTORE POINT. ALSO MAKE SURE YOU RUN THIS PROGRAM IN ADMINISTRATOR !!
echo.
echo [1] creates a restore point (make sure to run this program in administrator mode before using this).
echo.
echo [2] clears all the cache built up on your computer (improves loading times but may result in some apps disappearing)
echo.
echo [3] adds registry files to your computer to improve responsiveness, loading times and debloats your computer of unwanted useless software.
echo.
echo [4] helps improve the delay of your mouse and keyboard by adding registry files to improve latency.
echo.
echo [5] clears all DNS cache built up on your computer.
echo.
echo [6] does a hard clean of files and cache built up on your computer (MAY DELETE SOME APPS AND GAMES!).
echo.
echo [7] does a hard clean of your browser cache and internet cache built up on your computer (MAY DELETE SOME APPS AND GAMES!).
echo.
echo *********************************
echo.
echo  MIT License with Additional Restrictions Copyright (c) 2024 Bhaggo
echo.
echo  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
echo.
echo  1. The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
echo.
echo  2. Any redistribution, reproduction, or reuse of the Software in its entirety or substantial portion, or the creation of derivative works, is strictly prohibited without the express written permission of the copyright holder.
echo.
echo  3. Videos, tutorials, or any other form of media that includes the demonstration or reproduction of the Software, in whole or in part, are strictly prohibited without the express written permission of the copyright holder.
echo.
echo  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
echo.
echo *********************************

pause
echo sending back to main screen
goto menu

:shutdown
cls
echo Your computer will shut down shortly..
timeeout /t 3
shutdown -s /t 0

:quit
cls
echo Be sure to restart or shutdown your computer if you haven't already!
timeeout /2
exit