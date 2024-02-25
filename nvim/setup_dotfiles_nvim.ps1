function Setup-Neovim {
  try {
    Remove-Item "$env:LOCALAPPDATA\nvim" -Recurse -Force
    Copy-Item -Path "$env:USERPROFILE\Downloads\devs\dotfiles\nvim" -Destination "$env:LOCALAPPDATA\nvim" -Recurse
  } catch {
    Copy-Item -Path "$env:USERPROFILE\Downloads\devs\dotfiles\nvim" -Destination "$env:LOCALAPPDATA\nvim" -Recurse
  }
}

Setup-Neovim
