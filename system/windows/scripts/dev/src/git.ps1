function Get-Git()  {
	try {
		$path = (Get-Command git -ErrorAction STOP).Path
	} catch {
		scoop install main/git
	} 
}

