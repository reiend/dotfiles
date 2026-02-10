. "$($PSScriptRoot)\..\common\constants.ps1"

function Get-IsExitCodeSuccess {
  return ($LASTEXITCODE -Match $Null) -Or ($LASTEXITCODE -Match $ExitCodeSuccess)
}

function Get-IsScoopInstalled {
  try {
    Get-Command scoop -ErrorLevel Stop | Out-Null
    return $True
  } catch {
    return $False
  }
}

function Get-IsCanRunRemoteScriptByUser {
  try {
    return (Get-ExecutionPolicy -Scope CurrentUser) -eq "RemoteSigned"
  } catch {
    return $False
  }
}

function Enable-RunRemoteScriptByUser {
  try {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    return $True
  } catch {
    return $False
  }
}

function Get-IsWindows11 {
  return (Get-CimInstance Win32_OperatingSystem).Caption -Match "11"
}

function Get-IsWindows10 {
  return (Get-CimInstance Win32_OperatingSystem).Caption -Match "10"
}
