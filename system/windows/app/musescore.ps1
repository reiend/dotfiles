if (-not (Test-Path "$($Env:ProgramFiles)\MuseScore 4")) {
  winget install -e --id Musescore.Musescore
}
