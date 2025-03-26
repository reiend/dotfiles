function Install-Cmake {
	try {
		$path = (Get-Command cmake -ErrorAction STOP).Path
	} catch {
    Write-Host "installing cmake"
		scoop install main/cmake
	} 
}

Install-Cmake
