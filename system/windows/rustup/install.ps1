
function Install-Ripgrep {
	try {
		$path = (Get-Command cargo -ErrorAction STOP).Path
	} catch {
    Write-Host "installing rustup"
    scoop install main/rustup
	} 
}

Install-Ripgrep

