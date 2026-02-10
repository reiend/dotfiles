if (-not (Test-Path "$($Env:ProgramFiles)\Blender Foundation")) {
  winget install -e --id BlenderFoundation.Blender
}

