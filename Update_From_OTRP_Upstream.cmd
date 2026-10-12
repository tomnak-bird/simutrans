@echo off
setlocal EnableExtensions
pushd "%~dp0"

for /f "delims=" %%B in ('git branch --show-current') do set "CURRENT_BRANCH=%%B"
if not "%CURRENT_BRANCH%"=="local-development" (
    echo ERROR: Switch to local-development before running this updater.
    echo Current branch: %CURRENT_BRANCH%
    popd
    pause
    exit /b 4
)

for /f "delims=" %%S in ('git status --porcelain') do (
    echo ERROR: The working tree has uncommitted changes.
    echo Commit or stash them before updating from OTRP upstream.
    git status --short
    popd
    pause
    exit /b 2
)

echo Fetching the latest official OTRP history...
git fetch upstream --prune
if errorlevel 1 goto :failed

echo Merging upstream/OTRP-KUTAv6 into the current local branch...
git merge --no-edit upstream/OTRP-KUTAv6
if errorlevel 1 (
    echo.
    echo The merge stopped because manual conflict resolution is required.
    echo Do not delete the conflicted files. Ask Codex to resolve the merge.
    git status --short
    popd
    pause
    exit /b 3
)

echo Pushing the updated local-development branch to the personal fork...
git push origin local-development
if errorlevel 1 goto :failed

echo.
echo OTRP upstream update completed.
git log -1 --oneline --decorate
popd
pause
exit /b 0

:failed
echo.
echo Failed to fetch OTRP upstream. Check the network connection.
popd
pause
exit /b 1
