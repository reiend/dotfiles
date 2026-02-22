. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL GRADLE
try {
  Get-Command gradle -ErrorAction Stop | Out-Null
} catch {
  scoop install main/gradle
}
