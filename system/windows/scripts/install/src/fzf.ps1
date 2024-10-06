function Get-Fzf() {
	try {
		$path = (Get-Command fzf -ErrorAction Stop).Path
	} catch {
		scoop install main/fzf
	}

}
