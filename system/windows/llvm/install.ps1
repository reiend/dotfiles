
function Install-LLVM {
	try {
		$path = (Get-Command clang++ -ErrorAction STOP).Path
	} catch {
    Write-Host "installing llvm"
		scoop install main/llvm
	} 
}

Install-LLVM

