function Get-WindowsTerminal()  {
	try {
		$path = (Get-Command WindowsTerminal -ErrorAction STOP).Path

	} catch {
		scoop install extras/windows-terminal
	} 
}


