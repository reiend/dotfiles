
function Install-WindowsTerminal {
	try {
		$path = (Get-Command WindowsTerminal -ErrorAction STOP).Path
	} catch {
    Write-Host "installing windows terminal"
		
		scoop bucket add extras
		scoop install extras/windows-terminal
	} 
}

Install-WindowsTerminal

