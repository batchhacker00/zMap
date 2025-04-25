@echo off
setlocal enabledelayedexpansion
title zMap v2.0.1

for /f "tokens=2 delims=:" %%a in ( 'ipconfig ^| findstr /i "IPv4"' ) do (
    set "ip=%%a"
    goto :gotIP
)

:gotIP
set "ip=%ip:~1%"
for /f "tokens=1-3 delims=." %%a in ("%ip%") do set "iproot=%%a.%%b.%%c."

for /f "tokens=2" %%y in ( 'ping -a -n 1 -w 10 %ip% ^| find "[" ' ) do set mydns=%%y

echo YOU: %ip% [%mydns%]
echo ----------------------------


for /l %%i in (1,1,254) do (
    start /b cmd /c "ping -a -n 1 -w 10 %iproot%%%i | find "[" "
)

:waitloop
tasklist | find /i "ping.exe" >nul
if not errorlevel 1 (
    timeout /t 1 >nul
    goto :waitloop
)
echo ----------------------------
echo.
echo DONE
echo.
echo press any key to close
pause > nul
