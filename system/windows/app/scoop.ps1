. "$($PSScriptRoot)\..\common\utils.ps1"

# ENABLE RUNNING REMOTE POWERSHELL SCRIPT FOR CURRENT SUER

if(-not (Get-IsCanRunRemoteScriptByUser)) {
  Enable-RunRemoteScriptByUser | Out-Null
}

# CHECK AND INSTALL SCOOP
if(-not (Get-IsScoopInstalled)) {
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# INSTALL SCOOP BUCKET DEPENDENCIES
try {
  Get-Command git -ErrorAction Stop | Out-Null
} catch {
  scoop install git
}

# ADD SCOOP BUCKET
if(-not (Test-Path "$($Home)\scoop\buckets\main")) {
  scoop bucket add main
}

if(-not (Test-Path "$($Home)\scoop\buckets\versions")) {
  scoop bucket add versions
}

if(-not (Test-Path "$($Home)\scoop\buckets\nerd-fonts")) {
  scoop bucket add nerd-fonts
}

if(-not (Test-Path "$($Home)\scoop\buckets\extras")) {
  scoop bucket add extras
}

if(-not (Test-Path "$($Home)\scoop\buckets\java")) {
  scoop bucket add java
}
