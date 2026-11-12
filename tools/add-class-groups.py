"""Add CLASS_GROUPS entries: python tools/add-class-groups.py "New family=Existing family" ...
The new family gets the same broad group as the existing one."""
import sys
p='index.html'; t=open(p,encoding='utf8').read()
for arg in sys.argv[1:]:
    new, like = arg.split('=')
    if '"'+new+'":[' in t: print('exists', new); continue
    key='  "'+like+'":'
    i=t.index(key); line=t[i:t.index('\n',i)]
    grp=line.split(':',1)[1].rstrip(',')
    t=t[:i]+'  "'+new+'":'+grp+',\n'+t[i:]
    print('added', new)
open(p,'w',encoding='utf8',newline='').write(t)
