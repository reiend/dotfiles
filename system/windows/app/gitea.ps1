. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL GITEA
try {
  Get-Command gitea -ErrorAction Stop | Out-Null
} catch {
  scoop install main/gitea
}
