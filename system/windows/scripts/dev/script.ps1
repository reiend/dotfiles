. "$($PSScriptRoot).\src\scoop.ps1"
. "$($PSScriptRoot).\src\git.ps1"
. "$($PSScriptRoot).\src\neovim.ps1"
. "$($PSScriptRoot).\src\windows-terminal.ps1"
. "$($PSScriptRoot).\src\pwsh.ps1"
. "$($PSScriptRoot).\src\nodejs.ps1"
. "$($PSScriptRoot).\src\mingw.ps1"
. "$($PSScriptRoot).\src\llvm.ps1"
. "$($PSScriptRoot).\..\utils\script.ps1"

function Start-Dev() {
	$YES = [Ref]0;
	$YES_TO_ALL = [Ref]1;
	$NO = [Ref]2;

	$isYesToAllChoices = [Ref]$false;
	$step = [Ref]0;
	$end = [Ref]8;

	Show-Step
	Start-Action -action Get-Scoop -title "Scoop" -message "Installing scoop"

	Show-Step
	Start-Action -action Get-Git -title "Git" -message "Installing git"

	Show-Step
	Start-Action -action Get-Git -title "Neovim" -message "Do you want to install neovim?"

	Show-Step
	Start-Action -action Get-WindowsTerminal -title "Windows Terminal" -message "Do you want to install windows terminal?"

	Show-Step
	Start-Action -action Get-Pwsh -title "Windows Terminal" -message "Do you want to install pwsh"

	Show-Step
	Start-Action -action Get-NodeJs -title "NodeJs" -message "Do you want to install nodejs?"

	Show-Step
	Start-Action -action Get-Mingw -title "Mingw" -message "Do you want to install mingw?"

	Show-Step
	Start-Action -action Get-Llvm -title "Llvm" -message "Do you want to install llvm?"

	Show-Finish
}

Start-Dev

