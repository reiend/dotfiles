
function Set-GlazeWM {
	param(
		$ConfigPathFile = "$($PSScriptRoot)\config.yaml",
		$ConfigRootPathFile = "$($home)\.glaze-wm\config.yaml"
		$ConfigRootPathFolder = "$($home)\.glaze-wm"
	)

	try {
		$path = (Get-Command glazewm -ErrorAction STOP).Path

		if($path.GetType().Name -ne "String") {
			return
		}

		if(!(Test-Path -Path $ConfigRootPathFolder)) {
      mkdir $ConfigRootPathFolder
		}

		if(Test-Path -Path $ConfigRootPathFile) {
			Remove-Item  $ConfigRootPathFile -Recurse -Force
			Copy-Item -Path $ConfigPathFile -Destination $ConfigRootPathFile -Recurse
			return
		}

		Copy-Item -Path $ConfigPathFile -Destination $ConfigRootPathFile -Recurse
	} catch {
		Throw "glazewm is not installed"
	} 
}

Set-GlazeWM

