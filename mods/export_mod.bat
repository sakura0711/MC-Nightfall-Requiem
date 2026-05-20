@echo off
setlocal EnableDelayedExpansion

set "folder=C:\Users\user\curseforge\minecraft\Instances\test\mods"
set "out=C:\Users\user\curseforge\minecraft\Instances\test\mods\mods_list.txt"

if not exist "%out%" type nul > "%out%"

rem 取得目前日期時間（格式：yyyy-MM-dd HH:mm:ss）
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format \"yyyy-MM-dd HH:mm:ss\""') do set "now=%%i"

rem 找出目前最後一個版本號的尾數
set "lastNum=0"
for /f "tokens=2 delims=." %%a in ('findstr /r /c:"v0\.0\.[0-9][0-9]*" "%out%"') do (
    for /f "tokens=1 delims= " %%b in ("%%a") do set "lastNum=%%b"
)

set /a addCount=0

for /f "delims=" %%F in ('dir /b /a-d "%folder%\*.jar"') do (
    set "name=%%~nF"
    findstr /i /c:"- !name!" "%out%" >nul
    if errorlevel 1 (
        set /a addCount+=1
        set /a ver=lastNum+addCount
        set "newLine!addCount!=- !name! v0.0.!ver!"
    )
)

if %addCount% gtr 0 (
    >> "%out%" echo.
    >> "%out%" echo ==================== [%now%] ====================
    for /l %%N in (1,1,%addCount%) do (
        >> "%out%" echo !newLine%%N!
    )
)

endlocal