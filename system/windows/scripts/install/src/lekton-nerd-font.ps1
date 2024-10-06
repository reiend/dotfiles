function Get-LektonNerdFont() {
	$fonts = [System.Drawing.FontFamily]::Families
	$FONT = "Lekton Nerd Font"

	if(($fonts | where {$_.Name -eq $FONT})) {
		Write-Host "Lekton Nerd Font is Installed"
		return
	}

	scoop install nerd-fonts/Lekton-NF
}
