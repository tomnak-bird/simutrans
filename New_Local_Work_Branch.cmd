@echo off
setlocal EnableExtensions
pushd "%~dp0"

if "%~1"=="" (
    echo Usage: New_Local_Work_Branch.cmd short-topic-name
    echo Example: New_Local_Work_Branch.cmd improve-toolbar-state
    popd
    pause
    exit /b 2
)

for /f "delims=" %%S in ('git status --porcelain') do (
    echo ERROR: The working tree has uncommitted changes.
    echo Commit or stash them before creating a work branch.
    git status --short
    popd
    pause
    exit /b 3
)

git switch local-development
if errorlevel 1 goto :failed

git pull --ff-only origin local-development
if errorlevel 1 goto :failed

git switch -c "work/%~1"
if errorlevel 1 goto :failed

echo.
echo Created personal work branch: work/%~1
echo Implement, commit, build, and test the change on this branch.
popd
pause
exit /b 0

:failed
echo.
echo Failed to create the personal work branch.
popd
pause
exit /b 1
