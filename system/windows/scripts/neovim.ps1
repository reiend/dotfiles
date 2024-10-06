function Get-Neovim()  {
	try {
		$path = (Get-Command nvim -ErrorAction STOP).Path
	} catch {
		scoop install main/nvim
	} 
}

