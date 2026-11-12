"""Update the drug count everywhere and bump the service-worker cache version.
Usage: python tools/finish-batch.py"""
import re, datetime
t = open('index.html', encoding='utf8').read()
s = t.index('const MEDS = ['); e = t.index('\n];', s)
n = len(re.findall(r'genericEn:"', t[s:e]))
def sub(path, pat, rep):
    x = open(path, encoding='utf8').read()
    y = re.sub(pat, rep, x)
    open(path, 'w', encoding='utf8', newline='').write(y)
sub('index.html', r'nursing students - \d+ drugs\.', 'nursing students - %d drugs.' % n)
sub('manifest.webmanifest', r'\d+ drugs\.', '%d drugs.' % n)
sub('README.md', r'\*\*\d+ medications\*\*', '**%d medications**' % n)
sw = open('sw.js', encoding='utf8').read()
today = datetime.date.today().isoformat()
m = re.search(r'ndg-(\d{4}-\d{2}-\d{2})-(\d+)', sw)
ver = 'ndg-%s-%02d' % (today, int(m.group(2)) + 1 if m.group(1) == today else 1)
open('sw.js', 'w', encoding='utf8', newline='').write(sw.replace(m.group(0), ver))
print(n, 'medications; cache', ver)
