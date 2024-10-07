
function Install-LektonMonoNerdFont {
  # load fonts in powershell below v7
  [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

	$FONT = "Lekton Nerd Font Mono"
	$Fonts = [System.Drawing.FontFamily]::Families

	if(($Fonts | where {$_.Name -eq $FONT})) {
		return
	}

  Write-Host "installing lekton mono nerd font"
  scoop install nerd-fonts/Lekton-NF-Mono
}

Install-LektonMonoNerdFont

