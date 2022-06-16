@echo off
setlocal EnableDelayedExpansion
set vMajor=0
set vMinor=0
set vPatch=0
set dirName=

@REM Find latest blender version among stable ones
for /f %%a in ('dir /a:d /b %~dp0\stable') do (
	for /f "delims=+-; tokens=2" %%b in ("%%a") do (
		for /f "delims=.; tokens=1,2,3" %%c in ("%%b") do (
			if !vMajor! lss %%c (
				set forceUpdate=1
			) else if !vMajor! equ %%c (
				if !vMinor! lss %%d (
					set forceUpdate=1
				) else if !vMinor! equ %%d (
					if !vPatch! lss %%e (
						set forceUpdate=1
					)
				)
			)
			if defined forceUpdate (
				set vMajor=%%c
				set vMinor=%%d
				set vPatch=%%e
				set dirName=%~dp0stable\%%a
			)
			set forceUpdate=
		)
	)
)

set file=%1
if "!file!" neq "" (
	set file=%file:"=%
)

if "!file!"=="" (
	start "" "!dirName!\blender.exe"
) else (
	start "" "!dirName!\blender.exe" "!file!"
)
