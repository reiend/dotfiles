. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL TREE-SITTER
try {
  Get-Command tree-sitter -ErrorAction Stop | Out-Null
} catch {
  scoop install main/tree-sitter
}

