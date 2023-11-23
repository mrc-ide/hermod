@echo off
REM automatically generated
ECHO generated on host: {{hostname}}
ECHO generated on date: {{date}}
ECHO hermod version: {{hermod_version}}
ECHO running on: %COMPUTERNAME%

REM variables that get pulled in here
REM * hermod_drive - the drive alone (e.g., Q:)
REM * hermod_root - the absolute path incl. drive to folder with hermod/
REM * hermod_workdir - the absolute path on drive to working directory

call setr64_{{r_version}}.bat

REM If Java is wanted, then call setJava64.
REM If called with blank, it adds default JRE.

IF '{{use_java}}'=='TRUE' (
  call setJava64.bat {{java_home}}
)

{{network_shares_create}}

{{hermod_drive}}
cd {{hermod_workdir}}
ECHO working directory: %CD%

set R_LIBS_USER={{r_libs_user}}

ECHO this is a single task

@REM The quoting here is necessary for paths with spaces.
ECHO on
Rscript -e "hermod::hermod_task_eval('{{hermod_task_id}}')" > "{{hermod_root}}\hermod\tasks\{{hermod_task_id}}\log" 2>&1

@ECHO off
%SystemDrive%
set ErrorCode=%ERRORLEVEL%

{{network_shares_delete}}

set ERRORLEVEL=%ErrorCode%

if %ERRORLEVEL% neq 0 (
  ECHO Error running task
  EXIT /b %ERRORLEVEL%
)

@ECHO Quitting