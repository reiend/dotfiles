
function Install-FZF {
	try {
		$path = (Get-Command fzf -ErrorAction Stop).Path
	} catch {
    Write-Host "installing fzf"
		scoop install main/fzf
	}
}

Install-FZF

