reinitialize
cd ../ProcessedData/pymol/pdbfiles/

python

import os

pdbids = []

with open('../val_pdb.tsv') as file:
    for line in file:
        split = line.strip().split('\t')
        pdbids.append(split[1])

for id in pdbids:
    cmd.fetch(id, type='pdb')
    if id.lower() + '.pdb' not in os.listdir():
        open(id.lower() + '.pdb', 'w').write('Unable to fetch')
    
python end