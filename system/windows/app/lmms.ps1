if (-not (Test-Path "$($Env:ProgramFiles)\LMMS")) {
  winget install -e --id LMMS.LMMS
}
