@echo off
REM automatically generated
ECHO generated on host: {{hostname}}
ECHO generated on date: {{date}}
ECHO hermod version: {{hermod_version}}
ECHO running on: %COMPUTERNAME%

REM variables that get pulled in here
REM * hermod_root_drive - the drive alone (e.g., Q:)
REM * hermod_root_path - the relative path incl. drive to folder with hermod/

call setr64_{{r_version}}.bat

{{network_shares_create}}

{{hermod_root_drive}}
cd {{hermod_root_path}}
ECHO working directory: %CD%

set R_LIBS_USER=\\fi--didef3.dide.ic.ac.uk\tmp\hermod-testing

ECHO this is a single task

@REM The quoting here is necessary for paths with spaces.
ECHO on
Rscript -e "hermod::hermod_task_eval('{{hermod_task_id}}')" > "hermod\tasks\{{hermod_task_id}}\log" 2>&1

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