function Install-Ninja {
	try {
		$path = (Get-Command ninja -ErrorAction STOP).Path
	} catch {
    Write-Host "installing ninja"
		scoop install main/ninja
	} 
}

Install-Ninja

