param([string]$Html = (Join-Path $PSScriptRoot "..\index.html"))
$t = [IO.File]::ReadAllText((Resolve-Path $Html))
$rx = [regex]'genericEn:"(?<g>(?:[^"\\]|\\.)*)",(?:(?!genericEn:)[\s\S])*?\n\s*inoEn:"(?<i>(?:[^"\\]|\\.)*)",'
foreach ($m in $rx.Matches($t)) {
  $g = $m.Groups['g'].Value
  $i = $m.Groups['i'].Value -replace '\\"','"'
  "=== $g`n$i`n"
}
Write-Host ("TOTAL: " + $rx.Matches($t).Count)
