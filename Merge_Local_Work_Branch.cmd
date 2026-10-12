@echo off
setlocal EnableExtensions EnableDelayedExpansion
pushd "%~dp0"

for /f "delims=" %%B in ('git branch --show-current') do set "WORK_BRANCH=%%B"
if not defined WORK_BRANCH (
    echo ERROR: No current branch was detected.
    popd
    pause
    exit /b 2
)

echo !WORK_BRANCH!| findstr /b /c:"work/" >nul
if errorlevel 1 (
    echo ERROR: Run this while on the tested work/ branch to be merged.
    echo Current branch: !WORK_BRANCH!
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

git switch local-development
if errorlevel 1 goto :failed

git pull --ff-only origin local-development
if errorlevel 1 goto :failed

git merge --no-ff "!WORK_BRANCH!" -m "Merge !WORK_BRANCH! into personal mainline"
if errorlevel 1 (
    echo.
    echo The merge stopped because manual conflict resolution is required.
    echo Keep the conflicted files and ask Codex to resolve and test the merge.
    git status --short
    popd
    pause
    exit /b 5
)

git push origin local-development
if errorlevel 1 goto :failed

echo.
echo Merged !WORK_BRANCH! into local-development and pushed the personal mainline.
echo The work branch was retained.
popd
pause
exit /b 0

:failed
echo.
echo The personal-mainline update failed. No work branch was deleted.
popd
pause
exit /b 1
