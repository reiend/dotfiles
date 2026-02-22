. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL SPRING BOOT
try {
  Get-Command spring -ErrorAction Stop | Out-Null
} catch {
  scoop install extras/springboot
}
