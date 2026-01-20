@echo off
set CXROOT=C:\CX

if not exist %CXROOT% (
    echo CX folder not found. Copy CX to C:\CX
    exit /b 1
)

schtasks /create ^
 /tn "CX-Win11-Upgrade" ^
 /sc ONSTART ^
 /ru SYSTEM ^
 /rl HIGHEST ^
 /tr "powershell.exe -ExecutionPolicy Bypass -File C:\CX\payload\scripts\upgrade.ps1" ^
 /f

echo CX Windows 11 Upgrade Task Installed Successfully
exit /b 0
