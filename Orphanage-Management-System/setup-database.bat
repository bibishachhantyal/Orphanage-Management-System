@echo off
title Setup MySQL database
cd /d "%~dp0"

if not exist "C:\xampp\mysql\bin\mysql.exe" (
    echo ERROR: XAMPP MySQL not found at C:\xampp\mysql\bin\mysql.exe
    echo Install XAMPP or edit this script with your MySQL path.
    pause
    exit /b 1
)

echo Creating database and tables...
"C:\xampp\mysql\bin\mysql.exe" -u root < database.sql
if errorlevel 1 (
    echo database.sql failed. Check MySQL is running in XAMPP.
    pause
    exit /b 1
)

if exist upgrade.sql (
    echo Applying upgrade.sql...
    "C:\xampp\mysql\bin\mysql.exe" -u root < upgrade.sql
)

echo.
echo Done. Database: orphanagesystem_db
echo Demo logins (password Admin@123 for all):
echo   admin     - Administrator
echo   donor     - Donor
echo   volunteer - Volunteer
echo   bibisha   - User
echo.
pause
