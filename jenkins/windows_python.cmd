@REM Copyright (c) Microsoft. All rights reserved.
@REM Licensed under the MIT license. See LICENSE file in the project root for full license information.

@echo off
setlocal

set build-root=%~dp0..
rem // resolve to fully qualified path
for %%i in ("%build-root%") do set build-root=%%~fi

REM -- Python --
cd %build-root%\build_all\windows
if "%1" equ "--use-cmake" (
   echo Building client using cmake
   call build_client.cmd --use-websockets %2 %3
) else (
  echo Building client using Nuget packages
  call build.cmd --run-ut
)
if errorlevel 1 exit /b 1

cd %build-root%\device\tests
call python iothub_client_e2e.py
if errorlevel 1 exit /b 1

cd %build-root%\service\tests
call python iothub_service_client_e2e.py
if errorlevel 1 exit /b 1

cd %build-root%
