
function Install-IosevkaNerdFontMono {
  # load fonts in powershell below v7
  [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

	$FONT = "Iosevka NFM"
	$Fonts = [System.Drawing.FontFamily]::Families

	if(($Fonts | where {$_.Name -eq $FONT})) {
		return
	}

  Write-Host "installing iosevka nerd font mono"
  scoop bucket add nerd-fonts
  scoop install nerd-fonts/Iosevka-NF-Mono
}

Install-IosevkaNerdFontMono

