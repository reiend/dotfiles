
function Install-Scoop {
	try {
		$path = (Get-Command scoop -ErrorAction Stop).Path
	} catch {
    Write-Host "Installing Scoop"

		Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
		Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

		scoop bucket add main
		scoop bucket add extras
		scoop bucket add nerd-fonts
	}
}

Install-Scoop

