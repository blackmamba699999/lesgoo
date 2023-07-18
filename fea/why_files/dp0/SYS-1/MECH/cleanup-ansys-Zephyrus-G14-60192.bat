@echo off
set LOCALHOST=%COMPUTERNAME%
if /i "%LOCALHOST%"=="Zephyrus-G14" (taskkill /f /pid 64948)
if /i "%LOCALHOST%"=="Zephyrus-G14" (taskkill /f /pid 63892)
if /i "%LOCALHOST%"=="Zephyrus-G14" (taskkill /f /pid 65040)
if /i "%LOCALHOST%"=="Zephyrus-G14" (taskkill /f /pid 60192)

del /F cleanup-ansys-Zephyrus-G14-60192.bat
