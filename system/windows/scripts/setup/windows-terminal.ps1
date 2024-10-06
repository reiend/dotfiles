function Setup-WindowsTerminal {
	param(
		$item = "$($PSScriptRoot).\..\..\windows-terminal\settings.json",
		$settings = "$($home)\scoop\persist\windows-terminal\settings"
	)

	Write-Host "windows terminal setup - in progress"
	try {
		$path = (Get-Command WindowsTerminal -ErrorAction STOP).Path

		if($path.GetType().Name -ne "String") {
			return
		}

		if(Test-Path -Path $settings) {
			Remove-Item $settings -Recurse -Force
			mkdir $settings | Out-Null

			Copy-Item -Path $item -Destination $settings -Recurse
			echo "windows terminal setup - success"
			return
		}

		Copy-Item -Path $item -Destination $settings -Recurse
		echo "windows terminal setup - success"
	} catch {
		echo "windows terminal setup - error"
		Throw "Windows Terminal not installed"
	} 
}
