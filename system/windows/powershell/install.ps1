
function Install-Powershell {
	try {
		$path = (Get-Command pwsh -ErrorAction STOP).Path
	} catch {
    Write-Host "installing powershell"
		scoop install main/pwsh
	} 
}

Install-Powershell

