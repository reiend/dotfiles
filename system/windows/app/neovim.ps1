. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# INSTALL NEOVIM
try {
  Get-Command nvim -ErrorAction Stop | Out-Null
} catch {
  scoop install main/neovim
}

# SETUP NEOVIM
$CustomNvimConfigPath =  "$($PSScriptRoot)\..\..\..\config\nvim"
$SystemNvimConfigPath =  "$($env:LOCALAPPDATA)\nvim"

if(Test-Path -Path $SystemNvimConfigPath) {
  Remove-Item $SystemNvimConfigPath -Recurse
  Copy-Item $CustomNvimConfigPath -Destination $SystemNvimConfigPath -Recurse
} else {
  Copy-Item $CustomNvimConfigPath -Destination $SystemNvimConfigPath -Recurse
}
