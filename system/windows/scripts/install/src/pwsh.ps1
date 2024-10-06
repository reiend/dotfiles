function Get-Pwsh()  {
	try {
		$path = (Get-Command pwsh -ErrorAction STOP).Path
	} catch {
		scoop install main/pwsh
	} 
}


