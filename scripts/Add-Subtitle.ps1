<#
.SYNOPSIS
  Writes a film-style subtitle at the bottom of a gallery picture.
.DESCRIPTION
  White text with a black outline, centred, near the bottom edge, over the picture as Pickle took it.
  Mechanical and repeatable: same picture and text give the same file. The text of each picture is in
  PUBLICATION.md ("Gallery subtitles"); the picture without the subtitle stays in the run evidence.
  Needs ffmpeg on PATH. Not for pictures that show an interface window.
.EXAMPLE
  powershell -File scripts/Add-Subtitle.ps1 -In Tests/Pickle/Evidence/<run>/gallery-1-the-hall.png -Out Art/Gallery/1-indoors.png -Text "Daisy has been in the hall since dawn."
#>
param(
  [Parameter(Mandatory = $true)][string]$In,
  [Parameter(Mandatory = $true)][string]$Out,
  [Parameter(Mandatory = $true)][string]$Text,
  [string]$Font = 'C:/Windows/Fonts/arial.ttf',
  [int]$SizePercent = 4
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $In)) { throw "Input picture not found: $In" }
if (-not (Test-Path -LiteralPath $Font)) { throw "Font not found: $Font" }
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) { throw 'ffmpeg is not on PATH' }
$tmp = Join-Path ([IO.Path]::GetTempPath()) ("subtitle-" + [guid]::NewGuid().ToString('N') + '.txt')
[IO.File]::WriteAllText($tmp, $Text, (New-Object Text.UTF8Encoding($false)))
try {
  # drawtext takes the text from a file (no quoting of apostrophes or commas) and the paths with a escaped colon.
  $esc = { param($p) ($p -replace '\\', '/') -replace ':', '\:' }
  $fontEsc = & $esc $Font
  $txtEsc = & $esc $tmp
  $filter = "drawtext=fontfile='$fontEsc':textfile='$txtEsc':fontcolor=white:fontsize=h*$SizePercent/100:borderw=3:bordercolor=black:x=(w-text_w)/2:y=h-text_h-h*0.06"
  & ffmpeg -y -loglevel error -i $In -vf $filter -frames:v 1 $Out
  if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed with exit code $LASTEXITCODE" }
} finally {
  Remove-Item -LiteralPath $tmp -ErrorAction SilentlyContinue
}
Write-Host "subtitle written: $Out"
