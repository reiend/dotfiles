
function Set-Neovim {
	param(
		$ConfigPathFolder = "$($PSScriptRoot)\..\..\..\shared\nvim",
		$ConfigRootPathFolder = "$($env:LOCALAPPDATA)\nvim"
	)

	try {
		$path = (Get-Command nvim -ErrorAction STOP).Path

		if($path.GetType().Name -ne "String") {
			return
		}

		if(Test-Path -Path $ConfigRootPathFolder) {
			Remove-Item $ConfigRootPathFolder -Recurse -Force

			Copy-Item -Path $ConfigPathFolder -Destination $ConfigRootPathFolder -Recurse
			return
		}

		Copy-Item -Path $ConfigPathFolder -Destination $ConfigRootPathFolder -Recurse
	} catch {
		Throw "neovim is not installed"
	} 
}

Set-Neovim

