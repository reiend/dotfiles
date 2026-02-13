. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL MINGW
try {
  Get-Command gcc -ErrorAction Stop | Out-Null
} catch {
  scoop install main/mingw
}
