. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL GLAZEWM DEPENDENCIES
# INSTALL REBAR
try {
  Get-Command zebar -ErrorAction Stop | Out-Null
} catch {
  scoop install extras/zebar
}

#INSTALL GLAZEWM
try {
  Get-Command glazewm -ErrorAction Stop | Out-Null
} catch {
  scoop install extras/glazewm
}
