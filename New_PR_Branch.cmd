@echo off
setlocal EnableExtensions
pushd "%~dp0"

if "%~1"=="" (
    echo Usage: New_PR_Branch.cmd short-topic-name
    echo Example: New_PR_Branch.cmd fix-city-building-crash
    popd
    pause
    exit /b 2
)

for /f "delims=" %%S in ('git status --porcelain') do (
    echo ERROR: The working tree has uncommitted changes.
    echo Commit or stash them before creating a PR branch.
    git status --short
    popd
    pause
    exit /b 3
)

git fetch upstream --prune
if errorlevel 1 goto :failed

git switch -c "pr/%~1" upstream/OTRP-KUTAv6
if errorlevel 1 goto :failed

echo.
echo Created PR branch: pr/%~1
echo Make one focused change, test it, and commit it on this branch.
popd
pause
exit /b 0

:failed
echo.
echo Failed to create the PR branch.
popd
pause
exit /b 1
