# CHECK TERMINAL ICONS
function Get-IsTerminalIconsInstalled {
  foreach($Module in (Get-Module -ListAvailable)) {
    if(-not ($Module.Name -eq "Terminal-Icons")) {
      continue
    }

    return $True
  }

  return $False
}

# INSTALL TERMINAL ICONS
if(-not (Get-IsTerminalIconsInstalled)) {
  scoop install terminal-icons
}

