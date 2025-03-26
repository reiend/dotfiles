function Set-Powershell {
	param(
		$ConfigPathFile = "$($PSScriptRoot)\profile.ps1",
		$ConfigRootPathFile = "$($home)\scoop\apps\pwsh\current\profile.ps1"
	)

	try {
		$path = (Get-Command pwsh -ErrorAction STOP).Path

		if($path.GetType().Name -ne "String") {
			return
		}

		if(Test-Path -Path $ConfigRootPathFile) {
			Remove-Item $ConfigRootPathFile -Recurse -Force

			Copy-Item -Path $ConfigPathFile -Destination $ConfigRootPathFile -Recurse
			return
		}

		Copy-Item -Path $ConfigPathFile -Destination $ConfigRootPathFile -Recurse
	} catch {
		Throw "powershell is not installed"
	} 
}

Set-Powershell

