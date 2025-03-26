function Install-VisualStudioBuildTools {
	try {
		$Path = "$(${env:ProgramFiles(x86)})/Microsoft Visual Studio/BuiltTools/"
    $File = "visual-studio-build-tools.exe"

    if(Test-Path -Path $Path) {
      return
    }

    if(Test-Path -Path "$($PSScriptRoot)/$File" -PathType leaf) {
      Start-Process "$($PSScriptRoot)/$File" -Wait
      return
    }
    
    $Path = "https://download.visualstudio.microsoft.com/download/pr/69e24482-3b48-44d3-af65-51f866a08313/99c7677154366062a43082921f40f3ce00ef2614dbf94db23b244dd13dc9443d/vs_BuildTools.exe"
    $Destination = "$($PSScriptRoot)/$($File)"
    curl -o $Destination $Path
    Start-Process "$($PSScriptRoot)/$File" -Wait
	} catch {
		Throw "visual studio build tools is not installed"
	} 
}

Install-VisualStudioBuildTools
