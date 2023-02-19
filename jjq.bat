@if not "%1" == "--help" goto run 
	@type %~dp0help.txt
	@echo Available scripts:
	@dir /b %~dp0*.jq
	@goto end
:run
@if "%3" == "" goto twoargs
	@jq -r -f %~dp0%1.jq --arg myvar %2 -- %3
	@goto :end
:twoargs
	@jq -r -f %~dp0%1.jq %2
	@goto :end
:end