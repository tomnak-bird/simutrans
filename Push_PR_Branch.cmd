@echo off
setlocal EnableExtensions EnableDelayedExpansion
pushd "%~dp0"

for /f "delims=" %%B in ('git branch --show-current') do set "CURRENT_BRANCH=%%B"
if not defined CURRENT_BRANCH (
    echo ERROR: No current branch was detected.
    popd
    pause
    exit /b 2
)

echo !CURRENT_BRANCH!| findstr /b /c:"pr/" >nul
if errorlevel 1 (
    echo ERROR: The current branch is not a pr/ branch: !CURRENT_BRANCH!
    popd
    pause
    exit /b 3
)

for /f "delims=" %%S in ('git status --porcelain') do (
    echo ERROR: The working tree has uncommitted changes.
    git status --short
    popd
    pause
    exit /b 4
)

git push -u origin "!CURRENT_BRANCH!"
if errorlevel 1 (
    echo.
    echo Push failed. Confirm that the GitHub fork exists and authentication is available.
    popd
    pause
    exit /b 1
)

echo.
echo Pushed !CURRENT_BRANCH! to the personal fork.
echo The branch is ready for a pull request to teamhimeh/simutrans:OTRP-KUTAv6.
popd
pause
exit /b 0
