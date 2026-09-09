param(
  [string]$Html = (Join-Path $PSScriptRoot "..\index.html"),
  [string]$Data = (Join-Path $PSScriptRoot "..\..\..\..\AppData\Local\Temp\claude\C--Users-Owner-OneDrive-Desktop-claude-code\d59ac3b2-af32-4dce-b842-8f1ed57ae19c\scratchpad\inodir.json")
)
$ErrorActionPreference = "Stop"
$path = (Resolve-Path $Html)
$text = [IO.File]::ReadAllText($path)
$map = @{}
$obj = [IO.File]::ReadAllText((Resolve-Path $Data)) | ConvertFrom-Json
foreach ($p in $obj.PSObject.Properties) { $map[$p.Name] = $p.Value }

$applied = 0; $skipped = @(); $missing = @()
foreach ($name in $map.Keys) {
  $val = $map[$name]
  $ne = [regex]::Escape($name)
  # locate the drug object, then its inoEn line, without crossing into the next object
  $pat = '(genericEn:"' + $ne + '",(?:(?!genericEn:)[\s\S])*?\r?\n)(?<indent>[ \t]*)inoEn:"'
  $m = [regex]::Match($text, $pat)
  if (-not $m.Success) { $missing += $name; continue }
  $insertAt = $m.Groups[1].Index + $m.Groups[1].Length
  $ahead = $text.Substring($insertAt, [Math]::Min(60, $text.Length - $insertAt))
  if ($ahead -match 'inoDir:') { $skipped += $name; continue }
  $indent = $m.Groups['indent'].Value
  $ins = $indent + 'inoDir:"' + $val + '",' + "`r`n"
  $text = $text.Substring(0, $insertAt) + $ins + $text.Substring($insertAt)
  $applied++
}
[IO.File]::WriteAllText($path, $text, (New-Object Text.UTF8Encoding $false))
$total = ([regex]::Matches($text, 'inoDir:"')).Count
Write-Host "applied=$applied skipped=$($skipped.Count) missing=$($missing.Count)"
if ($skipped.Count) { Write-Host ("  skipped: " + ($skipped -join ", ")) }
if ($missing.Count) { Write-Host ("  MISSING: " + ($missing -join ", ")) }
Write-Host "inoDir total in file: $total"
