@echo off
title Hope Haven - Orphanage Management System
cd /d "%~dp0"

echo ============================================
echo  Hope Haven - Starting server
echo ============================================
echo.

where mvn >nul 2>&1
if errorlevel 1 (
    echo ERROR: Maven is not installed or not in PATH.
    echo Install Maven: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)

where java >nul 2>&1
if errorlevel 1 (
    echo ERROR: Java JDK is not installed or not in PATH.
    echo Install JDK 17 or newer: https://adoptium.net/
    pause
    exit /b 1
)

if not exist "C:\xampp\mysql\bin\mysql.exe" (
    echo WARNING: XAMPP MySQL not found at C:\xampp
    echo Start MySQL manually before using the app.
) else (
    echo Checking MySQL...
    "C:\xampp\mysql\bin\mysql.exe" -u root -e "SELECT 1" >nul 2>&1
    if errorlevel 1 (
        echo.
        echo ERROR: MySQL is not running.
        echo Open XAMPP Control Panel and click START next to MySQL.
        echo.
        pause
        exit /b 1
    )
    "C:\xampp\mysql\bin\mysql.exe" -u root -e "USE orphanagesystem_db" >nul 2>&1
    if errorlevel 1 (
        echo Database missing. Run setup-database.bat first.
        pause
        exit /b 1
    )
    echo MySQL OK - database found.
)

echo.
echo Building project...
call mvn -q package -DskipTests
if errorlevel 1 (
    echo BUILD FAILED. Read the error above.
    pause
    exit /b 1
)

echo.
echo ============================================
echo  Server starting on:
echo  http://localhost:8081/orphanage/
echo.
echo  Login: admin  /  1234
echo  Press Ctrl+C to stop the server
echo ============================================
echo.

call mvn cargo:run

pause
