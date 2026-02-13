. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL PYTHON
try {
  Get-Command python -ErrorAction Stop | Out-Null
} catch {
  scoop install main/python
}

