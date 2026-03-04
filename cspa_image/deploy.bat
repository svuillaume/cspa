@echo off
REM Security Assessment Docker Deployment Script for Windows
REM This script helps deploy the security assessment application

echo.
echo ================================================================================================
echo  Hybrid and Multi-Cloud Security Assessment - Docker Deployment
echo ================================================================================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not installed. Please install Docker Desktop first.
    echo        Visit: https://www.docker.com/products/docker-desktop/
    pause
    exit /b 1
)

echo [OK] Docker is installed
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not running. Please start Docker Desktop.
    pause
    exit /b 1
)

echo [OK] Docker is running
echo.

REM Menu
echo Select deployment method:
echo   1. Docker Compose (Recommended)
echo   2. Docker CLI
echo   3. Stop and remove containers
echo   4. View logs
echo   5. Exit
echo.
set /p choice="Enter choice [1-5]: "

if "%choice%"=="1" goto compose
if "%choice%"=="2" goto cli
if "%choice%"=="3" goto stop
if "%choice%"=="4" goto logs
if "%choice%"=="5" goto end
goto invalid

:compose
echo.
echo Starting with Docker Compose...
docker-compose up -d
if %errorlevel% neq 0 (
    echo ERROR: Failed to start with Docker Compose
    pause
    exit /b 1
)
echo.
echo [SUCCESS] Application is running!
echo [LINK] Access at: http://localhost:8080
goto done

:cli
echo.
echo Building and starting with Docker CLI...
docker build -t security-assessment .
docker run -d -p 8080:80 --name security-assessment-app security-assessment
if %errorlevel% neq 0 (
    echo ERROR: Failed to start container
    pause
    exit /b 1
)
echo.
echo [SUCCESS] Application is running!
echo [LINK] Access at: http://localhost:8080
goto done

:stop
echo.
echo Stopping containers...
docker-compose down 2>nul
docker stop security-assessment-app 2>nul
docker rm security-assessment-app 2>nul
echo [SUCCESS] Containers stopped and removed
goto done

:logs
echo.
echo Viewing logs (Ctrl+C to exit)...
docker logs -f security-assessment-app
goto done

:invalid
echo.
echo ERROR: Invalid choice
pause
exit /b 1

:done
echo.
echo ================================================================================================
echo Deployment complete!
echo ================================================================================================
pause
goto :eof

:end
echo Goodbye!
