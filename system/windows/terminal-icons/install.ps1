
function Install-TerminalIcons {
	try {
		$path = (Get-Module Terminal-Icons -ErrorAction STOP).Path

		if($path.GetType().Name -ne "String") {
			return
		}
	} catch {
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force -Scope CurrentUser
	}
}

Install-TerminalIcons

