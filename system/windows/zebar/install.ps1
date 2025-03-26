
function Install-Ripgrep {
	try {
		$path = (Get-Command zebar -ErrorAction STOP).Path
	} catch {
    Write-Host "installing zebar"
    scoop install extras/zebar
	} 
}

Install-Ripgrep

