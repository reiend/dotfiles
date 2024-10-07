
function Install-NodeJS {
	try {
		$path = (Get-Command node -ErrorAction STOP).Path
	} catch {
    Write-Host "installing nodejs"
		scoop install main/nodejs
	} 
}

Install-NodeJS

