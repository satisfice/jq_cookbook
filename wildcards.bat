@echo off
rem This batch file takes a path name with wildcard characters as input and expands it
rem to a list of explicit file names. This can be used to feed JQ multiple files at once
rem more easily.
rem
rem usage: wildcards test*.json & jq "." %expanded_list% 
rem (replace "test*.json" with whatever you want)
rem
rem I got this from https://superuser.com/questions/460598/is-there-any-way-to-get-the-windows-cmd-shell-to-expand-wildcard-paths

set expanded_list=
for /f "tokens=*" %%F in ('dir /b /a:-d "%~1"') do call set expanded_list=%%expanded_list%% "%%F"
