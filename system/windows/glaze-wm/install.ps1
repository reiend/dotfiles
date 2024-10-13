
function Install-GlazeWM {
	try {
		$path = (Get-Command glazewm -ErrorAction STOP).Path
	} catch {
    Write-Host "installing glaze-wm"
		scoop install main/glazewm
	} 
}

Install-GlazeWM

