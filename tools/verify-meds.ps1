param([string]$Html = (Join-Path $PSScriptRoot "..\index.html"))
$t = [IO.File]::ReadAllText((Resolve-Path $Html))
$s = $t.IndexOf('const MEDS = [')
$i = $s + 13
$depth = 0; $inStr = $false; $esc = $false; $q = [char]0; $objs = 0
for (; $i -lt $t.Length; $i++) {
  $c = $t[$i]
  if ($inStr) {
    if ($esc) { $esc = $false }
    elseif ($c -eq '\') { $esc = $true }
    elseif ($c -eq $q) { $inStr = $false }
    continue
  }
  if ($c -eq '"' -or $c -eq [char]39) { $inStr = $true; $q = $c; continue }
  if ($c -eq '[') { $depth++ }
  elseif ($c -eq ']') { $depth--; if ($depth -eq 0) { break } }
  elseif ($c -eq '{') { if ($depth -eq 1) { $objs++ } }
}
$doseEn = ([regex]::Matches($t, 'doseEn:"')).Count
$doseHe = ([regex]::Matches($t, 'doseHe:"')).Count
$inoEn = ([regex]::Matches($t, 'inoEn:"')).Count
$inoHe = ([regex]::Matches($t, 'inoHe:"')).Count
Write-Host "objects=$objs depth=$depth"
Write-Host "doseEn=$doseEn doseHe=$doseHe inoEn=$inoEn inoHe=$inoHe"
