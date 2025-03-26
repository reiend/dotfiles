
function Set-WindowsTerminal {
	param(
		$ConfigPathFile = "$($PSScriptRoot)\settings.json",
		$ConfigRootPathFile = "$($home)\scoop\apps\windows-terminal\current\settings\settings.json"
	)

	try {
		$path = (Get-Command WindowsTerminal -ErrorAction STOP).Path

		if($path.GetType().Name -ne "String") {
			return
		}

		if(Test-Path -Path $ConfigRootPathFile) {
			Remove-Item  $ConfigRootPathFile -Recurse -Force
			Copy-Item -Path $ConfigPathFile -Destination $ConfigRootPathFile -Recurse
			return
		}

		Copy-Item -Path $ConfigPathFile -Destination $ConfigRootPathFile -Recurse
	} catch {
		Throw "windows terminal is not installed"
	} 
}

Set-WindowsTerminal

