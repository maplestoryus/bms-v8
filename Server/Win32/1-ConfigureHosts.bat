@echo off

SET NEWLINE=^& echo.

FIND /C /I "bmsdb" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1 bmsdb>>%WINDIR%\System32\drivers\etc\hosts

FIND /C /I "bms_server" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1 bms_server>>%WINDIR%\System32\drivers\etc\hosts

echo "Maple Story host entries configured."