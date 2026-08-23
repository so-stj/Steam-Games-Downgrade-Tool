@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

title Steam Depot Version Downloader

REM ============================================================
REM Steam Depot Version Downloader
REM ============================================================
REM
REM This script downloads specific Steam Depot manifests using
REM SteamCMD and builds the selected game version in a separate
REM output directory.
REM
REM IMPORTANT:
REM
REM   1. This script does NOT modify your existing Steam game
REM      installation.
REM
REM   2. SteamCMD downloads the selected Depot manifests into
REM      an isolated working directory.
REM
REM   3. The downloaded Depots are then combined into the
REM      configured output directory.
REM
REM   4. Normally, you only need to edit the
REM      "USER CONFIGURATION" section below.
REM
REM ============================================================


REM ============================================================
REM USER CONFIGURATION
REM ============================================================
REM
REM ============================================================
REM IMPORTANT:
REM
REM This is the main configuration section.
REM
REM Users should normally ONLY edit the values in this section.
REM
REM Do NOT modify the script logic below unless you understand
REM how SteamCMD and this batch script work.
REM
REM ============================================================


REM ------------------------------------------------------------
REM Game name
REM ------------------------------------------------------------
REM
REM Display name of the game.
REM
REM This is only used for display and output directory naming.
REM It does NOT have to exactly match the Steam store name.
REM
REM Examples:
REM
REM   Skyrim Special Edition
REM   Fallout 4
REM   Cyberpunk 2077
REM
set "GAME_NAME=Skyrim Special Edition"


REM ------------------------------------------------------------
REM Target version
REM ------------------------------------------------------------
REM
REM Human-readable name for the version you want to download.
REM
REM IMPORTANT:
REM
REM This value does NOT tell SteamCMD which version to download.
REM The actual version is determined by the Manifest IDs below.
REM
REM Examples:
REM
REM   1.6.1170
REM   1.5.97
REM   1.2.3
REM
set "VERSION_NAME=1.6.1170"


REM ------------------------------------------------------------
REM Steam AppID
REM ------------------------------------------------------------
REM
REM The Steam AppID identifies the game/application.
REM
REM You can find the AppID on SteamDB or other Steam metadata
REM sources.
REM
REM Example:
REM
REM   Skyrim Special Edition
REM   AppID = 489830
REM
set "APPID=489830"


REM ============================================================
REM DEPOT CONFIGURATION
REM ============================================================
REM
REM A Steam application can consist of one or more Depots.
REM
REM Depot:
REM   A collection of files belonging to a Steam application.
REM
REM Manifest:
REM   A specific state/version of a Depot.
REM
REM IMPORTANT:
REM
REM The game version is determined by the Manifest IDs.
REM The VERSION_NAME above is only a human-readable label.
REM
REM ============================================================


REM ------------------------------------------------------------
REM Number of Depots
REM ------------------------------------------------------------
REM
REM Set this to the number of Depots you want to download.
REM
REM Examples:
REM
REM   1 Depot:
REM       set "DEPOT_COUNT=1"
REM
REM   2 Depots:
REM       set "DEPOT_COUNT=2"
REM
REM   3 Depots:
REM       set "DEPOT_COUNT=3"
REM
REM IMPORTANT:
REM
REM DEPOT_COUNT must match the number of configured Depot
REM entries below.
REM
set "DEPOT_COUNT=3"


REM ------------------------------------------------------------
REM Depot 1
REM ------------------------------------------------------------
REM
REM DEPOT1_ID:
REM   Steam Depot ID.
REM
REM DEPOT1_MANIFEST:
REM   Manifest ID for the exact Depot version you want.
REM
REM Example:
REM
REM   Depot ID:
REM       489831
REM
REM   Manifest ID:
REM       8442952117333549665
REM
set "DEPOT1_ID=489831"
set "DEPOT1_MANIFEST=8442952117333549665"


REM ------------------------------------------------------------
REM Depot 2
REM ------------------------------------------------------------
set "DEPOT2_ID=489832"
set "DEPOT2_MANIFEST=8042843504692938467"


REM ------------------------------------------------------------
REM Depot 3
REM ------------------------------------------------------------
set "DEPOT3_ID=489833"
set "DEPOT3_MANIFEST=1914580699073641964"


REM ============================================================
REM OPTIONAL VERIFICATION
REM ============================================================
REM
REM The following settings specify files that should exist after
REM the Depot files have been combined.
REM
REM These checks are optional but recommended.
REM
REM Example:
REM
REM   SkyrimSE.exe
REM   Data\Skyrim.esm
REM
REM If your game uses a different executable or file structure,
REM change these values.
REM
REM ============================================================


REM ------------------------------------------------------------
REM Main executable
REM ------------------------------------------------------------
REM
REM Set the name of the main executable that should exist in the
REM final output directory.
REM
REM Example:
REM
REM   SkyrimSE.exe
REM
set "VERIFY_FILE1=SkyrimSE.exe"


REM ------------------------------------------------------------
REM Additional verification file
REM ------------------------------------------------------------
REM
REM Set another important file that should exist after download.
REM
REM You can specify a relative path.
REM
REM Example:
REM
REM   Data\Skyrim.esm
REM
set "VERIFY_FILE2=Data\Skyrim.esm"


REM ============================================================
REM END OF USER CONFIGURATION
REM ============================================================
REM
REM Normally, do not edit anything below this line.
REM
REM ============================================================


REM ============================================================
REM INTERNAL SCRIPT CONFIGURATION
REM ============================================================

set "ROOT=%~dp0"

REM Official Valve SteamCMD Windows download URL.
set "STEAMCMD_URL=https://client-update.steamstatic.com/installer/steamcmd.zip"

REM Local SteamCMD directory.
set "STEAMCMD_LOCAL=%ROOT%SteamCMD"

REM Temporary SteamCMD ZIP file.
set "STEAMCMD_ZIP=%ROOT%steamcmd.zip"

REM Isolated SteamCMD working directory.
set "WORK_DIR=%ROOT%DepotWork"

REM Final output directory.
set "OUTPUT_DIR=%ROOT%Output\%GAME_NAME%_%VERSION_NAME%"


REM ============================================================
REM LANGUAGE SELECTION
REM ============================================================

:LANGUAGE

cls

echo ============================================================
echo   Steam Depot Version Downloader
echo ============================================================
echo.
echo   1. English
echo   2. Japanese
echo.

choice /C 12 /N /M "Select Language [1-2]: "

if errorlevel 2 (
    set "LANG=JP"
    goto START
)

if errorlevel 1 (
    set "LANG=EN"
    goto START
)


REM ============================================================
REM START
REM ============================================================

:START

cls

echo ============================================================
echo   Steam Depot Version Downloader
echo ============================================================
echo.
echo   Game:
echo     %GAME_NAME%
echo.
echo   Version:
echo     %VERSION_NAME%
echo.
echo   AppID:
echo     %APPID%
echo.
echo   Depot count:
echo     %DEPOT_COUNT%
echo.

if "%LANG%"=="JP" (
    echo SteamCMD is being detected...
) else (
    echo Searching for SteamCMD...
)

echo.

goto FIND_STEAMCMD


REM ============================================================
REM STEAMCMD DETECTION
REM ============================================================

:FIND_STEAMCMD

set "STEAMCMD="

REM ------------------------------------------------------------
REM 1. Check the same directory as this BAT file.
REM ------------------------------------------------------------

if exist "%ROOT%steamcmd.exe" (
    set "STEAMCMD=%ROOT%steamcmd.exe"
    goto STEAMCMD_FOUND
)


REM ------------------------------------------------------------
REM 2. Check the local SteamCMD directory.
REM ------------------------------------------------------------

if exist "%STEAMCMD_LOCAL%\steamcmd.exe" (
    set "STEAMCMD=%STEAMCMD_LOCAL%\steamcmd.exe"
    goto STEAMCMD_FOUND
)


REM ------------------------------------------------------------
REM 3. Check PATH.
REM ------------------------------------------------------------

for /f "delims=" %%S in ('where steamcmd.exe 2^>nul') do (
    if not defined STEAMCMD (
        set "STEAMCMD=%%S"
    )
)

if defined STEAMCMD goto STEAMCMD_FOUND


REM ------------------------------------------------------------
REM 4. Check common installation locations.
REM ------------------------------------------------------------

if exist "%ProgramFiles%\SteamCMD\steamcmd.exe" (
    set "STEAMCMD=%ProgramFiles%\SteamCMD\steamcmd.exe"
    goto STEAMCMD_FOUND
)

if exist "%ProgramFiles(x86)%\SteamCMD\steamcmd.exe" (
    set "STEAMCMD=%ProgramFiles(x86)%\SteamCMD\steamcmd.exe"
    goto STEAMCMD_FOUND
)

if exist "%USERPROFILE%\SteamCMD\steamcmd.exe" (
    set "STEAMCMD=%USERPROFILE%\SteamCMD\steamcmd.exe"
    goto STEAMCMD_FOUND
)


REM ------------------------------------------------------------
REM SteamCMD was not found.
REM ------------------------------------------------------------

goto STEAMCMD_NOT_FOUND


REM ============================================================
REM STEAMCMD FOUND
REM ============================================================

:STEAMCMD_FOUND

cls

echo ============================================================
echo   SteamCMD Found
echo ============================================================
echo.
echo Path:
echo.
echo %STEAMCMD%
echo.

goto PREPARE_WORK


REM ============================================================
REM STEAMCMD NOT FOUND
REM ============================================================

:STEAMCMD_NOT_FOUND

cls

echo ============================================================
echo   SteamCMD Not Found
echo ============================================================
echo.

echo SteamCMD was not found on this system.
echo.
echo SteamCMD will be downloaded from the official Valve
echo distribution server.
echo.
echo URL:
echo %STEAMCMD_URL%
echo.


if not exist "%STEAMCMD_LOCAL%" (
    mkdir "%STEAMCMD_LOCAL%"
)


if exist "%STEAMCMD_ZIP%" (
    del /q "%STEAMCMD_ZIP%" >nul 2>&1
)


echo.
echo Downloading SteamCMD...
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
"$ErrorActionPreference='Stop'; $ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri '%STEAMCMD_URL%' -OutFile '%STEAMCMD_ZIP%'"

if errorlevel 1 (
    echo.
    echo [ERROR] Failed to download SteamCMD.
    echo.
    pause
    exit /b 1
)


echo.
echo Extracting SteamCMD...
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
"$ErrorActionPreference='Stop'; Expand-Archive -LiteralPath '%STEAMCMD_ZIP%' -DestinationPath '%STEAMCMD_LOCAL%' -Force"

if errorlevel 1 (
    echo.
    echo [ERROR] Failed to extract SteamCMD.
    echo.
    pause
    exit /b 1
)


del /q "%STEAMCMD_ZIP%" >nul 2>&1

set "STEAMCMD=%STEAMCMD_LOCAL%\steamcmd.exe"


if not exist "%STEAMCMD%" (
    echo.
    echo [ERROR] steamcmd.exe was not found after extraction.
    echo.
    pause
    exit /b 1
)


goto PREPARE_WORK


REM ============================================================
REM PREPARE WORK DIRECTORY
REM ============================================================

:PREPARE_WORK

if not exist "%WORK_DIR%" (
    mkdir "%WORK_DIR%"
)

if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

goto LOGIN


REM ============================================================
REM STEAM LOGIN
REM ============================================================

:LOGIN

cls

echo ============================================================
echo   Steam Login
echo ============================================================
echo.
echo Enter your Steam username.
echo.
echo Your password and Steam Guard code will be entered
echo interactively by SteamCMD.
echo.

set "STEAM_USER="

set /p "STEAM_USER=Steam username: "

if not defined STEAM_USER (
    echo.
    echo [ERROR] Steam username is empty.
    echo.
    pause
    exit /b 1
)

goto DOWNLOAD


REM ============================================================
REM DOWNLOAD DEPOTS
REM ============================================================

:DOWNLOAD

cls

echo ============================================================
echo   Downloading Steam Depots
echo ============================================================
echo.

echo Game:
echo   %GAME_NAME%
echo.
echo Version:
echo   %VERSION_NAME%
echo.
echo AppID:
echo   %APPID%
echo.


REM ------------------------------------------------------------
REM Build the SteamCMD command.
REM ------------------------------------------------------------

set "STEAMCMD_COMMAND=+login "%STEAM_USER%""

if "%DEPOT_COUNT%" GEQ "1" (
    set "STEAMCMD_COMMAND=!STEAMCMD_COMMAND! +download_depot %APPID% %DEPOT1_ID% %DEPOT1_MANIFEST%"
)

if "%DEPOT_COUNT%" GEQ "2" (
    set "STEAMCMD_COMMAND=!STEAMCMD_COMMAND! +download_depot %APPID% %DEPOT2_ID% %DEPOT2_MANIFEST%"
)

if "%DEPOT_COUNT%" GEQ "3" (
    set "STEAMCMD_COMMAND=!STEAMCMD_COMMAND! +download_depot %APPID% %DEPOT3_ID% %DEPOT3_MANIFEST%"
)

if "%DEPOT_COUNT%" GEQ "4" (
    set "STEAMCMD_COMMAND=!STEAMCMD_COMMAND! +download_depot %APPID% %DEPOT4_ID% %DEPOT4_MANIFEST%"
)

if "%DEPOT_COUNT%" GEQ "5" (
    set "STEAMCMD_COMMAND=!STEAMCMD_COMMAND! +download_depot %APPID% %DEPOT5_ID% %DEPOT5_MANIFEST%"
)


echo SteamCMD will now start.
echo.
echo Enter your Steam password and Steam Guard code when
echo requested by SteamCMD.
echo.
pause


pushd "%WORK_DIR%"

"%STEAMCMD%" ^
+login "%STEAM_USER%" ^
+download_depot %APPID% %DEPOT1_ID% %DEPOT1_MANIFEST% ^
+download_depot %APPID% %DEPOT2_ID% %DEPOT2_MANIFEST% ^
+download_depot %APPID% %DEPOT3_ID% %DEPOT3_MANIFEST% ^
+quit

set "STEAMCMD_EXIT=%ERRORLEVEL%"

popd


if not "%STEAMCMD_EXIT%"=="0" (
    echo.
    echo [ERROR] SteamCMD returned error code %STEAMCMD_EXIT%.
    echo.
    pause
    exit /b 1
)


goto CHECK_DEPOTS


REM ============================================================
REM CHECK DOWNLOADED DEPOTS
REM ============================================================

:CHECK_DEPOTS

cls

echo ============================================================
echo   Depot Verification
echo ============================================================
echo.

set "DEPOT_ROOT=%WORK_DIR%\steamapps\content\app_%APPID%"


if "%DEPOT_COUNT%" GEQ "1" (
    if not exist "%DEPOT_ROOT%\depot_%DEPOT1_ID%" goto DEPOT_ERROR
)

if "%DEPOT_COUNT%" GEQ "2" (
    if not exist "%DEPOT_ROOT%\depot_%DEPOT2_ID%" goto DEPOT_ERROR
)

if "%DEPOT_COUNT%" GEQ "3" (
    if not exist "%DEPOT_ROOT%\depot_%DEPOT3_ID%" goto DEPOT_ERROR
)


echo All configured Depots were found.
echo.

goto BUILD


REM ============================================================
REM DEPOT ERROR
REM ============================================================

:DEPOT_ERROR

echo.
echo [ERROR] One or more required Depots were not found.
echo.
echo Expected location:
echo %DEPOT_ROOT%
echo.

pause
exit /b 1


REM ============================================================
REM BUILD OUTPUT
REM ============================================================

:BUILD

cls

echo ============================================================
echo   Building Game Version
echo ============================================================
echo.

echo Output:
echo %OUTPUT_DIR%
echo.


if "%DEPOT_COUNT%" GEQ "1" (
    echo Copying Depot %DEPOT1_ID%...
    robocopy ^
    "%DEPOT_ROOT%\depot_%DEPOT1_ID%" ^
    "%OUTPUT_DIR%" ^
    /E /COPY:DAT /DCOPY:DAT /R:2 /W:2 /NFL /NDL /NJH /NJS >nul

    if errorlevel 8 goto COPY_ERROR
)


if "%DEPOT_COUNT%" GEQ "2" (
    echo Copying Depot %DEPOT2_ID%...
    robocopy ^
    "%DEPOT_ROOT%\depot_%DEPOT2_ID%" ^
    "%OUTPUT_DIR%" ^
    /E /COPY:DAT /DCOPY:DAT /R:2 /W:2 /NFL /NDL /NJH /NJS >nul

    if errorlevel 8 goto COPY_ERROR
)


if "%DEPOT_COUNT%" GEQ "3" (
    echo Copying Depot %DEPOT3_ID%...
    robocopy ^
    "%DEPOT_ROOT%\depot_%DEPOT3_ID%" ^
    "%OUTPUT_DIR%" ^
    /E /COPY:DAT /DCOPY:DAT /R:2 /W:2 /NFL /NDL /NJH /NJS >nul

    if errorlevel 8 goto COPY_ERROR
)


goto VERIFY


REM ============================================================
REM COPY ERROR
REM ============================================================

:COPY_ERROR

echo.
echo [ERROR] Failed to copy one or more Depots.
echo.

pause
exit /b 1


REM ============================================================
REM VERIFY OUTPUT
REM ============================================================

:VERIFY

cls

echo ============================================================
echo   Output Verification
echo ============================================================
echo.


if defined VERIFY_FILE1 (
    if not exist "%OUTPUT_DIR%\%VERIFY_FILE1%" (
        echo [ERROR] Verification file not found:
        echo %VERIFY_FILE1%
        goto VERIFY_ERROR
    )

    echo %VERIFY_FILE1% : OK
)


if defined VERIFY_FILE2 (
    if not exist "%OUTPUT_DIR%\%VERIFY_FILE2%" (
        echo [ERROR] Verification file not found:
        echo %VERIFY_FILE2%
        goto VERIFY_ERROR
    )

    echo %VERIFY_FILE2% : OK
)


echo.
goto COMPLETE


REM ============================================================
REM VERIFICATION ERROR
REM ============================================================

:VERIFY_ERROR

echo.
echo [ERROR] Output verification failed.
echo.
echo Output:
echo %OUTPUT_DIR%
echo.

pause
exit /b 1


REM ============================================================
REM COMPLETE
REM ============================================================

:COMPLETE

cls

echo ============================================================
echo   COMPLETE
echo ============================================================
echo.

echo The selected Steam Depot version has been downloaded
echo and built successfully.
echo.
echo Game:
echo   %GAME_NAME%
echo.
echo Version:
echo   %VERSION_NAME%
echo.
echo AppID:
echo   %APPID%
echo.
echo Output:
echo   %OUTPUT_DIR%
echo.

echo ============================================================
echo   Important
echo ============================================================
echo.
echo Your existing Steam installation was not modified.
echo.
echo You may delete the following directories when they are
echo no longer required:
echo.
echo   SteamCMD\
echo   DepotWork\
echo.

echo ============================================================
echo.

pause

exit /b 0