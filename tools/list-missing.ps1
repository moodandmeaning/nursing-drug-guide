param([string]$Html = (Join-Path $PSScriptRoot "..\index.html"))
$t = [IO.File]::ReadAllText((Resolve-Path $Html))
$rx = [regex]'cat:"(?<cat>(?:[^"\\]|\\.)*)",[\s\S]*?genericEn:"(?<g>(?:[^"\\]|\\.)*)",[\s\S]*?routeHe:"(?:[^"\\]|\\.)*",(?<next>[\s\S]{0,40})'
foreach ($m in $rx.Matches($t)) {
  if ($m.Groups['next'].Value -notmatch 'doseEn:') {
    "{0,-22} {1}" -f $m.Groups['cat'].Value, $m.Groups['g'].Value
  }
}
