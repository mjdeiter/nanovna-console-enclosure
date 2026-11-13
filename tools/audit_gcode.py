import re, sys, collections
def audit(path):
    layer=0; z=0.0; typ='-'; F=0
    types_by_layer=collections.defaultdict(collections.OrderedDict)
    maxF=collections.defaultdict(int)
    temps=[]; fans=[]; hops=collections.Counter(); retracts=0
    for ln in open(path,errors='replace'):
        s=ln.strip()
        if s.startswith(';LAYER_CHANGE'): layer+=1; continue
        if s.startswith(';Z:'): z=float(s[3:]); continue
        if s.startswith(';TYPE:'): typ=s[6:]; types_by_layer[layer].setdefault(typ,0.0); continue
        if s.startswith(';'): continue
        mc=re.match(r'^(G[0-9]+|M[0-9]+)\b',s)
        if not mc: continue
        c=mc.group(1)
        if c in('M104','M109','M140','M190'):
            m=re.search(r'S([0-9.]+)',s); temps.append((layer,c,float(m.group(1)) if m else None))
        elif c=='M106':
            m=re.search(r'S([0-9.]+)',s); fans.append((layer,float(m.group(1)) if m else None))
        elif c=='M107': fans.append((layer,0.0))
        elif c in('G0','G1'):
            e=re.search(r'\bE(-?[0-9.]+)',s); f=re.search(r'\bF([0-9.]+)',s); zz=re.search(r'\bZ(-?[0-9.]+)',s)
            if f: F=float(f.group(1))
            if e:
                ev=float(e.group(1))
                if ev<0: retracts+=1
                elif ev>0 and re.search(r'[XY]',s):
                    types_by_layer[layer][typ]=types_by_layer[layer].get(typ,0.0)+ev
                    maxF[typ]=max(maxF[typ],F)
            if zz and layer>0:
                zv=float(zz.group(1))
                if zv>z+1e-6: hops[round(zv-z,3)]+=1
    return dict(types=types_by_layer,maxF=maxF,temps=temps,fans=fans,hops=hops,retracts=retracts,layers=layer)
def report(p, layers=(1,2,3,4,10,11,12,13,14,15,16)):
    a=audit(p)
    print('FILE',p,'| layers',a['layers'],'| retractions',a['retracts'])
    print('temp cmds (layer,cmd,S) first 14:',a['temps'][:14])
    print('   last 4:',a['temps'][-4:])
    fv=collections.OrderedDict()
    for L,S in a['fans']: fv.setdefault(S,[]).append(L)
    print('M106 values -> first layers seen:',{k:v[:3] for k,v in fv.items()},'| S153=60%, S178=70%')
    print('Z-lift sizes (mm above layer Z) -> count:',dict(a['hops'].most_common(6)))
    print('max F by type (mm/min; 3600 = 60 mm/s):',{k:int(v) for k,v in sorted(a['maxF'].items())})
    for L in layers:
        if L in a['types']: print('  layer %3d:'%L, ', '.join('%s %.0fmm'%(k,v) for k,v in a['types'][L].items()))
    allt=set()
    for d in a['types'].values(): allt.update(d.keys())
    print('all extrusion types present:',sorted(allt))
if __name__=='__main__':
    report(sys.argv[1])
