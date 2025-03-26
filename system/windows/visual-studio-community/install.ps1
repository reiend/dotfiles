function Install-VisualStudioCommunity {
	try {
    $Path = "$($env:ProgramFiles)/Microsoft Visual Studio/2022/Community"
    $File = "visual-studio-community.exe"

    if(Test-Path -Path $Path) {
      return
    }

    if(Test-Path -Path "$($PSScriptRoot)/$File" -PathType leaf) {
      Start-Process "$($PSScriptRoot)/$File" -Wait
      return
    }
    
    $Destination = "$($PSScriptRoot)/$File"
    $Path = "https://c2rsetup.officeapps.live.com/c2r/downloadVS.aspx?sku=community&channel=Release&version=VS2022&source=VSLandingPage&cid=2030:e5d8b646062044bdafc59d8e6a250828"
    curl -o $Destination $Path
    Start-Process "$($PSScriptRoot)/$File" -Wait
	} catch {
		Throw "visual studio community is not installed"
	} 
}

Install-VisualStudioCommunity
