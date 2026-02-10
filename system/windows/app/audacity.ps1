if (-not (Test-Path "$($Env:ProgramFiles)\Audacity")) {
  winget install -e --id Audacity.Audacity
}
