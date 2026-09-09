# Inserts doseEn/doseHe (and optional inoEn/inoHe) after the routeHe line of each MEDS entry.
# Data source: scratchpad dose-*.json  { "GenericEn": { "d","dh"[,"i","ih"] }, ... }
param(
  [string]$Html = (Join-Path $PSScriptRoot "..\index.html"),
  [string]$DataDir = "$env:LOCALAPPDATA\Temp\claude\C--Users-Owner-OneDrive-Desktop-claude-code\d59ac3b2-af32-4dce-b842-8f1ed57ae19c\scratchpad"
)

$ErrorActionPreference = "Stop"
$text = [IO.File]::ReadAllText((Resolve-Path $Html))

# merge all part files
$data = @{}
Get-ChildItem -Path $DataDir -Filter "dose-*.json" | Sort-Object Name | ForEach-Object {
  $obj = [IO.File]::ReadAllText($_.FullName) | ConvertFrom-Json
  foreach ($p in $obj.PSObject.Properties) { $data[$p.Name] = $p.Value }
}
Write-Host ("Loaded {0} drug entries from {1} file(s)" -f $data.Count, (Get-ChildItem -Path $DataDir -Filter 'dose-*.json').Count)

function Esc([string]$s) { return $s.Replace('\','\\').Replace('"','\"') }

$applied = 0; $skipped = @(); $missing = @()
foreach ($name in $data.Keys) {
  $v = $data[$name]
  $ne = [regex]::Escape($name)
  # entry: from genericEn:"name", up to and including its routeHe:"...",
  $pat = '(genericEn:"' + $ne + '",[\s\S]*?routeHe:"(?:[^"\\]|\\.)*",)'
  $m = [regex]::Match($text, $pat)
  if (-not $m.Success) { $missing += $name; continue }
  if ($m.Value -match 'doseEn:') { $skipped += $name; continue }

  $ins = "`n  doseEn:`"" + (Esc $v.d) + "`", doseHe:`"" + (Esc $v.dh) + "`","
  if ($v.PSObject.Properties.Name -contains 'i' -and $v.i) {
    $ins += "`n  inoEn:`"" + (Esc $v.i) + "`", inoHe:`"" + (Esc $v.ih) + "`","
  }
  $text = $text.Substring(0, $m.Index + $m.Length) + $ins + $text.Substring($m.Index + $m.Length)
  $applied++
}

[IO.File]::WriteAllText((Resolve-Path $Html), $text, (New-Object Text.UTF8Encoding $false))

$doseCount = ([regex]::Matches($text, 'doseEn:')).Count
$doseHeCount = ([regex]::Matches($text, 'doseHe:')).Count
$inoCount = ([regex]::Matches($text, 'inoEn:')).Count
$inoHeCount = ([regex]::Matches($text, 'inoHe:')).Count
Write-Host ("applied={0}  already-present(skipped)={1}  not-found={2}" -f $applied, $skipped.Count, $missing.Count)
if ($skipped.Count) { Write-Host ("  skipped: " + ($skipped -join ', ')) }
if ($missing.Count) { Write-Host ("  NOT FOUND: " + ($missing -join ', ')) -ForegroundColor Red }
Write-Host ("totals in file:  doseEn={0} doseHe={1}  inoEn={2} inoHe={3}" -f $doseCount, $doseHeCount, $inoCount, $inoHeCount)
