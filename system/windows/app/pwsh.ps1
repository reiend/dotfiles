. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL PWSH
try {
	Get-Command pwsh -ErrorAction Stop | Out-Null
} catch {
  scoop install main/pwsh
}

# SETUP PWSH
$CustomPwshConfigPath = "$($PSScriptRoot)\..\..\..\config\pwsh\profile.ps1"
$SystemPwshConfigPath = "$($(Get-Command scoop).Path)\..\..\apps\pwsh\current"

if(Test-Path -Path "$($SystemPwshConfigPath)\profile.ps1") {
  Remove-Item "$($SystemPwshConfigPath)\profile.ps1"
}

Copy-Item $CustomPwshConfigPath -Destination $SystemPwshConfigPath

