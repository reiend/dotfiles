
function Install-Ripgrep {
	try {
		$path = (Get-Command rg -ErrorAction STOP).Path
	} catch {
    Write-Host "installing ripgrep"
		scoop install main/ripgrep
	} 
}

Install-Ripgrep

