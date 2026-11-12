"""Append batch files (tools/data/batchN*.js - comma-separated MEDS object literals) to the MEDS array.
Usage: python tools/merge-batch.py tools/data/batch1a.js tools/data/batch1b.js
Skips any entry whose genericEn is already in MEDS."""
import re, sys
p = 'index.html'
t = open(p, encoding='utf8').read()
s = t.index('const MEDS = ['); e = t.index('\n];', s)
existing = set(re.findall(r'genericEn:"([^"]+)"', t[s:e]))
added = []
chunks = []
for f in sys.argv[1:]:
    body = open(f, encoding='utf8').read().strip().rstrip(',')
    for ent in re.split(r'\n\},\s*\n\{', body):
        ent = ent.strip()
        if not ent.startswith('{'): ent = '{' + ent
        if not ent.endswith('}'): ent = ent + '\n}'
        g = re.search(r'genericEn:"([^"]+)"', ent).group(1)
        if g in existing: print('SKIP duplicate', g); continue
        existing.add(g); added.append(g); chunks.append(ent)
head = t[:e].rstrip()
sep = '\n' if head.endswith(',') else ',\n'   # MEDS may already end with a trailing comma
t = head + sep + ',\n'.join(chunks) + t[e:]
open(p, 'w', encoding='utf8', newline='').write(t)
print('added', len(added), '->', len(existing), 'total')
fams = set(re.findall(r'classFamilyEn:"([^"]+)"', '\n'.join(chunks)))
cg = t[t.index('const CLASS_GROUPS = {'):]
cg = cg[:cg.index('};')]
missing = [f for f in fams if '"' + f + '":' not in cg]
print('class families missing from CLASS_GROUPS:', missing)
