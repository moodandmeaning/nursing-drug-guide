param([string]$Html = (Join-Path $PSScriptRoot "..\index.html"), [string]$Cat = "")
$t = [IO.File]::ReadAllText((Resolve-Path $Html))
$rx = [regex]'cat:"(?<cat>[^"]*)",\s*\r?\n\s*classEn:"(?<c>(?:[^"\\]|\\.)*)",(?:(?!genericEn:)[\s\S])*?genericEn:"(?<g>(?:[^"\\]|\\.)*)",(?:(?!\bcat:")[\s\S])*?\r?\n\s*seEn:"(?<se>(?:[^"\\]|\\.)*)",'
$n = 0
foreach ($m in $rx.Matches($t)) {
  if ($Cat -and $m.Groups['cat'].Value -ne $Cat) { continue }
  $n++
  $g = $m.Groups['g'].Value -replace '\\"','"'
  $c = $m.Groups['c'].Value -replace '\\"','"'
  $se = $m.Groups['se'].Value -replace '\\"','"'
  "[$($m.Groups['cat'].Value)] $g`n  class: $c`n  SE: $se`n"
}
Write-Host "COUNT: $n"
