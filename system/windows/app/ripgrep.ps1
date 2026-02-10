. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL RIPGREP
try {
  Get-Command rg -ErrorAction Stop | Out-Null
} catch {
  scoop install main/ripgrep
}
