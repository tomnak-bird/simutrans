@echo off
setlocal EnableExtensions
pushd "%~dp0"

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
