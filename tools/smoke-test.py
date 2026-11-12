"""Headless-Edge smoke test: python tools/smoke-test.py query1 query2 ...
Loads index.html, types each query into search, prints the count line and first matches, plus JS errors."""
import sys, os, json, subprocess, tempfile, re, html
qs = sys.argv[1:] or ['metoprolol']
t = open('index.html', encoding='utf8').read()
js = r"""window.addEventListener('error',e=>{const p=document.createElement('pre');p.id='jserr';p.textContent='JSERR '+e.message+' line '+e.lineno;document.body.appendChild(p);});
window.addEventListener('DOMContentLoaded',()=>setTimeout(()=>{const out=[];try{const s=document.getElementById('search');
for(const q of %s){s.value=q;s.dispatchEvent(new Event('input'));
const n=[...document.querySelectorAll('#list .generic-en')].slice(0,3).map(e=>e.textContent);
out.push(q+' => '+n.join(', '));}
s.value='';s.dispatchEvent(new Event('input'));out.push('cards: '+document.querySelectorAll('#list .card').length+' / MEDS '+MEDS.length);
}catch(e){out.push('ERR '+e.message);}
const p=document.createElement('pre');p.id='testout';p.textContent=out.join('\n');document.body.appendChild(p);},500));""" % json.dumps(qs, ensure_ascii=False)
d = tempfile.mkdtemp()
f = os.path.join(d, 't.html')
open(f, 'w', encoding='utf8').write(t.replace('<head>', '<head><script>' + js + '</script>', 1))
edge = r'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
dom = subprocess.run([edge, '--headless=new', '--disable-gpu', '--virtual-time-budget=8000', '--dump-dom', 'file:///' + f.replace(os.sep, '/')],
                     capture_output=True).stdout.decode('utf8', 'replace')
if '<pre id=' not in dom:
    i=dom.find('testout'); print('no test output; dom length', len(dom), 'testout at', i, dom[i-100:i+300] if i>=0 else dom[-400:])
for m in re.findall(r'<pre id="(?:testout|jserr)">(.*?)</pre>', dom, re.S):
    print(html.unescape(m))
