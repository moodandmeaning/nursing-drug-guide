param(
  [Parameter(Mandatory=$true)][string]$DataDir,
  [string]$Html
)
if (-not $Html) { $Html = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) "..\index.html" }
$ErrorActionPreference = "Stop"
$path = (Resolve-Path $Html)
$text = [IO.File]::ReadAllText($path)

$data = @{}
Get-ChildItem -Path $DataDir -Filter "mem-*.json" | Sort-Object Name | ForEach-Object {
  $obj = [IO.File]::ReadAllText($_.FullName) | ConvertFrom-Json
  foreach ($p in $obj.PSObject.Properties) { $data[$p.Name] = $p.Value }
}
Write-Host "Loaded $($data.Count) entries from $((Get-ChildItem -Path $DataDir -Filter 'mem-*.json').Count) file(s)"

function Esc([string]$s) { return $s.Replace('\','\\').Replace('"','\"') }

$applied = 0; $skipped = @(); $missing = @()
foreach ($name in $data.Keys) {
  $v = $data[$name]
  $ne = [regex]::Escape($name)
  $pat = '(genericEn:"' + $ne + '",(?:(?!genericEn:)[\s\S])*?\r?\n)(?<indent>[ \t]*)moaEn:"'
  $m = [regex]::Match($text, $pat)
  if (-not $m.Success) { $missing += $name; continue }
  $insertAt = $m.Groups[1].Index + $m.Groups[1].Length
  if ($m.Groups[1].Value -match 'memHookEn:') { $skipped += $name; continue }
  $ind = $m.Groups['indent'].Value
  $ins = $ind + 'memHookEn:"' + (Esc $v.hk) + '", memHookHe:"' + (Esc $v.hkh) + '",' + "`r`n" +
         $ind + 'memEn:"' + (Esc $v.m) + '", memHe:"' + (Esc $v.mh) + '",' + "`r`n"
  $text = $text.Substring(0, $insertAt) + $ins + $text.Substring($insertAt)
  $applied++
}
[IO.File]::WriteAllText($path, $text, (New-Object Text.UTF8Encoding $false))
$hk = ([regex]::Matches($text, 'memHookEn:"')).Count
$mm = ([regex]::Matches($text, 'memEn:"')).Count
Write-Host "applied=$applied  skipped=$($skipped.Count)  missing=$($missing.Count)"
if ($missing.Count) { Write-Host ("  MISSING: " + ($missing -join ", ")) }
Write-Host "totals in file: memHookEn=$hk memEn=$mm"
