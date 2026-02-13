. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL OPENJDK
try {
  Get-Command java -ErrorAction Stop | Out-Null
} catch {
  scoop install java/openjdk21
}
