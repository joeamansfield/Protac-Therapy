reinitialize
cd ../ProcessedData/pymol/pdbfiles/

python
pdbids = open('../val_pdb.csv').readlines()[0].split(',')

for id in pdbids:
    cmd.fetch(id, type='pdb')

python end