function Get-Llvm()  {
	try {
		$path = (Get-Command clang++ -ErrorAction STOP).Path
	} catch {
		scoop install main/llvm
	} 
}

