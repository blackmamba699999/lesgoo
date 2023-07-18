@echo off
set LOCALHOST=%COMPUTERNAME%
if /i "%LOCALHOST%"=="Zephyrus-G14" (taskkill /f /pid 63464)
if /i "%LOCALHOST%"=="Zephyrus-G14" (taskkill /f /pid 66180)
if /i "%LOCALHOST%"=="Zephyrus-G14" (taskkill /f /pid 65096)
if /i "%LOCALHOST%"=="Zephyrus-G14" (taskkill /f /pid 58944)

del /F cleanup-ansys-Zephyrus-G14-58944.bat
