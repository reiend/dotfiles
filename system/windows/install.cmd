@ECHO off

REM PACKAGE MANAGER
powershell -File ".\app\scoop.ps1"

REM FONTS
powershell -file ".\font\iosevka-nf.ps1"

REM TERMINAL APPS
powershell -File ".\app\neovim.ps1"
powershell -file ".\app\glaze-wm.ps1"
powershell -file ".\app\terminal-icons.ps1"
powershell -file ".\app\pwsh.ps1"
powershell -file ".\app\windows-terminal.ps1"
powershell -file ".\app\ripgrep.ps1"

REM GUI APPS
powershell -file ".\app\blender.ps1"
powershell -file ".\app\musescore.ps1"
powershell -file ".\app\lmms.ps1"
powershell -file ".\app\audacity.ps1"

pause
