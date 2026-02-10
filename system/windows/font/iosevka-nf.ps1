. "$($PSScriptRoot)\..\common\utils.ps1"

# CHECK SCOOP
if(-not (Get-IsScoopInstalled)) {
  return
}

# CHECK IOSEVKA NERD FONT
function Get-IsIosevkaNerdFontInstalled {
  [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
  $Fonts = [System.Drawing.FontFamily]::Families

  foreach($Font in $Fonts) {
    if($Font.Name -eq "Iosevka NFM") {

      Write-Output "iosevka nerd font mono is already installed"
      return $True
    }
  }

  return $False
}

# INSTALL IOSEVKA NERD FONT
if(-not (Get-IsIosevkaNerdFontInstalled)) {
  scoop install nerd-fonts/Iosevka-NF-Mono
}

