@echo off
setlocal enabledelayedexpansion
title xTalon


:main

set succ=[34m[+][0m

for /f "tokens=2 delims=:" %%d in ( ' ipconfig ^| findstr /i "IPv4" ' ) do set myip=%%d
for /f "tokens=2 delims=:" %%a in ( ' ipconfig ^| findstr /i "IPv4" ' ) do set ip=%%a 
rem take our local ip address

set ip=%ip:~1%
rem takes the first 3 number of our ip saving it on iproot variable
for /f "tokens=1-3 delims=." %%a in ( "%ip%" ) do set iproot=%%a.%%b.%%c.

echo you:%myip%
echo ---------------------------------

for /l %%i in ( 1,1,254 ) do (
rem finds others ip address and dns/domain-name associated to it, by 1 to 254 
for /f "tokens=2" %%b in ( 'ping -a -n 1 -w 10 %iproot%%%i ^| find "[" ' ) do (

echo DNS:[%%b] IP:%iproot%%%i %succ% 

)
)

pause > nul && press nay key to close
