. ".\scoop.ps1"
. ".\git.ps1"
. ".\nodejs.ps1"
. ".\mingw.ps1"
. ".\llvm.ps1"
. ".\utils.ps1"



function Start-Setup() {
	$YES = [Ref]0;
	$YES_TO_ALL = [Ref]1;
	$NO = [Ref]2;

	$isYesToAllChoices = [Ref]$false;
	$step = [Ref]0;
	$end = [Ref]5;

	Show-Step
	Start-Action -action Get-Scoop -title "Scoop" -question "Installing scoop"

	Show-Step
	Start-Action -action Get-Git -title "Git" -question "Installing git"
	
	Show-Step
	Start-Action -action Get-NodeJs -title "NodeJs" -question "Do you want to install nodejs?"

	Show-Step
	Start-Action -action Get-Mingw -title "Mingw" -question "Do you want to install mingw?"
	
	Show-Step
	Start-Action -action Get-Llvm -title "Llvm" -question "Do you want to install llvm?"

	Show-Finish
}


Start-Setup

