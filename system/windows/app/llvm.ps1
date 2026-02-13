. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL LLVM

try {
  Get-Command clang -ErrorAction Stop | Out-Null
} catch {
  scoop install main/llvm
}
