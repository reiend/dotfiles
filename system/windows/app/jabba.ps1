. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL JABBA
try {
  Get-Command jabba -ErrorAction Stop | Out-Null
} catch {
  scoop install main/jabba
}
