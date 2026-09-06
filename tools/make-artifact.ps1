# Build the Claude-artifact version of the drug guide from index.html.
#
# The Artifact publisher wraps the file in its own <!doctype>/<head>/<body> skeleton,
# so the artifact copy must NOT contain those tags, the PWA <head> boilerplate, or the
# service-worker registration. This strips all of that and re-prepends a <title>.
#
# Usage:  powershell -File tools\make-artifact.ps1   (from the repo root)
# Output: tools\artifact.html   -> publish that file to the artifact URL.

$repo = Split-Path $PSScriptRoot -Parent
$src  = Join-Path $repo "index.html"
$dst  = Join-Path $PSScriptRoot "artifact.html"

$s = [System.IO.File]::ReadAllText($src) -replace "`r`n", "`n"

# Keep from the first <style> reset onward (drops doctype/html/head + PWA meta).
$cut = $s.IndexOf('<style>*{box-sizing')
if ($cut -lt 0) { throw "reset <style> not found in index.html" }
$s = $s.Substring($cut)

$s = $s -replace "(?s)</style>\s*</head>\s*<body>\s*", "</style>`n`n"           # </head><body> seam
$s = $s -replace "(?s)<script>\s*/\* Offline support.*?</script>\s*", ""        # SW registration
$s = $s -replace "(?s)\s*</body>\s*</html>\s*$", "`n"                           # closing tags

if ($s -notmatch '(?i)<title>') { $s = "<title>Bilingual Nursing Drug Guide</title>`n" + $s }

[System.IO.File]::WriteAllText($dst, $s, (New-Object System.Text.UTF8Encoding($false)))

$entries = ([regex]::Matches($s, '(?m)^  cat:"')).Count
"wrote $dst  ($entries medications)"
if ($s -match '<!doctype|</head>|<body>|serviceWorker') { throw "skeleton not fully stripped" }
