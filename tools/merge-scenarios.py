"""Rebuild the SCENARIOS array in index.html from every tools/data/scenarios*.js batch.

Each batch file holds one JS array literal (a leading /* comment */ is allowed).
Usage (from the repo root):  python tools/merge-scenarios.py
"""
import glob, os, re, sys

repo = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
idx_path = os.path.join(repo, "index.html")
files = sorted(glob.glob(os.path.join(repo, "tools", "data", "scenarios*.js")),
               key=lambda f: int(re.search(r"scenarios(\d+)", f).group(1)))
if not files:
    sys.exit("no tools/data/scenarios*.js files")

bodies, ids = [], []
for f in files:
    src = open(f, encoding="utf8").read()
    src = re.sub(r"^\s*/\*.*?\*/\s*", "", src, count=1, flags=re.S).strip()
    if not (src.startswith("[") and src.endswith("]")):
        sys.exit(f"{f}: expected a single array literal")
    inner = src[1:-1].strip().rstrip(",")
    bodies.append(inner)
    ids += re.findall(r'\bid:"([^"]+)"', inner)

dupes = sorted({i for i in ids if ids.count(i) > 1})
if dupes:
    sys.exit("duplicate scenario ids: " + ", ".join(dupes))

array = "[\n" + ",\n".join(bodies) + "\n]"
html = open(idx_path, encoding="utf8").read()
pat = re.compile(r"(/\* SCENARIOS-START \*/\nconst SCENARIOS = ).*?(;\n/\* SCENARIOS-END \*/)", re.S)
if not pat.search(html):
    sys.exit("SCENARIOS markers not found in index.html")
html = pat.sub(lambda m: m.group(1) + array + m.group(2), html, count=1)
open(idx_path, "w", encoding="utf8").write(html)
print(f"merged {len(ids)} scenarios from {len(files)} file(s)")
