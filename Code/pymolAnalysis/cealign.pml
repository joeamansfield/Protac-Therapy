reinitialize
cd ../ProcessedData/pymol/pdbfiles/

python

import itertools

pdbids = []
pdbMap = {}
uniprot_to_hugo = {}
hugo_to_pdb = {}
E3_to_substrate = {}
compareList = []

with open('../val_pdb.tsv') as file:
    for line in file:
        split = line.strip().split('\t')
        pdbids.append(split[1])
        pdbMap[split[0]] = split[1]

with open('../uniprot_to_hugo.tsv') as file:
    for line in file:
        split = line.strip().split(' ')
        uniprot_to_hugo[split[0]] = split[1]

for key, value in pdbMap.items():
    if uniprot_to_hugo.keys().__contains__(key):
        hugo_to_pdb[uniprot_to_hugo[key]] = value
    else:
        print(key + " not matched")

with open('../protein_features_table.tsv') as file:
    for line in file:
        split = line.split('\t')
        if split[2] != 'Substrates':
            substrateList = split[2].split(',')
            compareList.append(substrateList)

for item in compareList:
    for prot1, prot2 in itertools.combinations(item, 2):
        if hugo_to_pdb.keys().__contains__(prot1) and hugo_to_pdb.keys().__contains__(prot2):
            print(prot1 + ' ' + prot2)
            cmd.fetch(hugo_to_pdb[prot1], type='pdb')
            cmd.fetch(hugo_to_pdb[prot2], type='pdb')
            cmd.show_as('cartoon', 'all')
            result = cmd.cealign(hugo_to_pdb[prot1], hugo_to_pdb[prot2])
            cmd.orient()
            cmd.png('../../../Figures/Pymol/' + prot1 + '_' + prot2 + '_cealign.png')
            cmd.delete('all')
            cmd.reinitialize

#cmd.cealign('1LM8', '1C9Q')

python end