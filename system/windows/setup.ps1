. "$($PSScriptRoot).\scripts\install\script.ps1"
. "$($PSScriptRoot).\scripts\setup\windows-terminal.ps1"

Write-Host "Setup Install"
Setup-Install

Write-Host "Setup Windows Terminal"
Setup-WindowsTerminal

