function Get-Scoop() {
	try {
		$path = (Get-Command scoop -ErrorAction Stop).Path
	} catch {
		Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
		Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

		scoop bucket add main
		scoop bucket add extras
	}

}
