param([string]$Html = (Join-Path $PSScriptRoot "..\index.html"))
$t = [IO.File]::ReadAllText((Resolve-Path $Html))
$rx = [regex]'cat:"(?<cat>[^"]*)",\s*\r?\n\s*classEn:"(?<c>(?:[^"\\]|\\.)*)",(?<b>(?:(?!\bcat:")[\s\S])*?)\r?\n\s*genericEn:"(?<g>(?:[^"\\]|\\.)*)",(?<b2>(?:(?!\bcat:")[\s\S])*?)\r?\n\s*moaEn:"'
$n = 0
foreach ($m in $rx.Matches($t)) {
  if ($m.Groups['b2'].Value -notmatch 'memHookEn:') {
    $n++
    "[{0}] {1}" -f $m.Groups['cat'].Value, ($m.Groups['g'].Value -replace '\\"','"')
  }
}
Write-Host "MISSING: $n"
