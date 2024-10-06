
function Get-NodeJs()  {
	try {
		$path = (Get-Command node -ErrorAction STOP).Path
	} catch {
		scoop install main/nodejs
	} 
}


