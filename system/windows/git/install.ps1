
function Install-Git()  {
	try {
		$path = (Get-Command git -ErrorAction STOP).Path
	} catch {
    Write-Host "installing git"
		scoop install main/git
	} 
}

Install-Git

