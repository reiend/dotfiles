function Update-Neovim {
  try {
    Remove-Item "$env:USERPROFILE\Downloads\devs\dotfiles\nvim" -Recurse
    Copy-Item -Path "$env:LOCALAPPDATA\nvim" -Destination "$env:USERPROFILE\Downloads\devs\dotfiles\nvim" -Recurse
  } catch {
    Copy-Item -Path "$env:LOCALAPPDATA\nvim" -Destination "$env:USERPROFILE\Downloads\devs\dotfiles\nvim" -Recurse
  }
}

Update-Neovim
