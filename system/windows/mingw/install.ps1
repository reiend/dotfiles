
function Install-MinGW {
	try {
		$path = (Get-Command g++ -ErrorAction Stop).Path
	} catch {
    Write-Host "installing mingw"
		scoop install main/mingw
	}
}

Install-MinGW

