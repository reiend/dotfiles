
function Install-Neovim {
	try {
		$path = (Get-Command nvim -ErrorAction STOP).Path
	} catch {
    Write-Host "installing neovim"
		scoop install main/neovim
	} 
}

Install-Neovim

