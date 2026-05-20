@echo off
title Stop Hope Haven server
echo Stopping Java/Tomcat processes that may lock the project...
echo.

for /f "tokens=2" %%a in ('tasklist /FI "IMAGENAME eq java.exe" /NH 2^>nul') do (
    echo Stopping java.exe PID %%a
    taskkill /PID %%a /F >nul 2>&1
)

timeout /t 2 /nobreak >nul
echo Done. You can now run: mvn package cargo:run
echo Or double-click run.bat
pause
