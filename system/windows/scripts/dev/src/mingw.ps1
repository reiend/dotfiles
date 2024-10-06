function Get-Mingw() {
	try {
		$path = (Get-Command g++ -ErrorAction Stop).Path
	} catch {
		scoop install main/mingw
	}

}
