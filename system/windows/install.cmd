@ECHO off

set "INSTALL_PATH=%~dp0"

REM PACKAGE MANAGER
powershell -File "%INSTALL_PATH%app\scoop.ps1"

REM FONTS
powershell -file "%INSTALL_PATH%font\iosevka-nf.ps1"

REM TERMINAL APPS
powershell -File "%INSTALL_PATH%app\neovim.ps1"
powershell -file "%INSTALL_PATH%app\glaze-wm.ps1"
powershell -File "%INSTALL_PATH%app\terminal-icons.ps1"
powershell -File "%INSTALL_PATH%app\pwsh.ps1"
powershell -File "%INSTALL_PATH%app\windows-terminal.ps1"
powershell -File "%INSTALL_PATH%app\ripgrep.ps1"
powershell -File "%INSTALL_PATH%app\llvm.ps1"
powershell -File "%INSTALL_PATH%app\openjdk.ps1"
powershell -File "%INSTALL_PATH%app\python.ps1"
powershell -File "%INSTALL_PATH%app\mingw.ps1"
powershell -File "%INSTALL_PATH%app\tree-sitter.ps1"

REM GUI APPS
powershell -File "%INSTALL_PATH%app\blender.ps1"
powershell -File "%INSTALL_PATH%app\musescore.ps1"
powershell -File "%INSTALL_PATH%app\lmms.ps1"
powershell -File "%INSTALL_PATH%app\audacity.ps1"
