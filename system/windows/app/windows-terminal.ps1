. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}


# INSTALL AND SETUP WINDOWS TERMINAL IF ON WINDOWS 10
if(Get-IsWindows10) {
  try {
    Get-Command WindowsTerminal -ErrorAction Stop | Out-Null
  } catch {
    scoop install extras/windows-terminal
  }

  $CustomWindowsTerminalConfigPath = "$($PSScriptRoot)\..\..\..\config\windows-terminal\settings.json"
  $SystemWindowsTerminalConfigPath = "$((Get-Command scoop).Path)\..\..\apps\windows-terminal\current\settings"

  Remove-Item "$($SystemWindowsTerminalConfigPath)\settings.json"
  Copy-Item $CustomWindowsTerminalConfigPath -Destination $SystemWindowsTerminalConfigPath

  return
}

# INSTALL AND SETUP WINDOWS TERMINAL ON WINDOWS 11
if(Get-IsWindows11) {
  $CustomWindowsTerminalConfigPath = "$($PSScriptRoot)\..\..\..\config\windows-terminal\settings.json"
  $SystemWindowsTerminalConfigPath =  "$($env:LOCALAPPDATA)\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

  Remove-Item "$($SystemWindowsTerminalConfigPath)\settings.json"
  Copy-Item $CustomWindowsTerminalConfigPath -Destination $SystemWindowsTerminalConfigPath
  return
}

