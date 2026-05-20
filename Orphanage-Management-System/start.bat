@echo off
cd /d "%~dp0"
title Hope Haven - Start

echo [1/2] Building WAR file...
call mvn package -DskipTests
if errorlevel 1 (
    echo BUILD FAILED.
    pause
    exit /b 1
)

if not exist "target\orphanage.war" (
    echo ERROR: target\orphanage.war was not created.
    pause
    exit /b 1
)

echo [2/2] Starting Tomcat on http://localhost:8081/orphanage/
echo Login: admin / 1234
echo Press Ctrl+C to stop.
echo.

call mvn cargo:run
pause
