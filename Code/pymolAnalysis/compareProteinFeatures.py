import os

pdbids = []
pdbMap = {}
uniprot_to_hugo = {}
hugo_to_pdb = {}
E3_to_substrate = {}

with open('../ProcessedData/pymol/val_pdb.tsv') as file:
    for line in file:
        split = line.strip().split('\t')
        pdbids.append(split[1])
        pdbMap[split[0]] = split[1]

with open('../ProcessedData/pymol/uniprot_to_hugo.tsv') as file:
    for line in file:
        split = line.strip().split(' ')
        uniprot_to_hugo[split[0]] = split[1]

for key, value in pdbMap.items():
    if uniprot_to_hugo.keys().__contains__(key):
        hugo_to_pdb[uniprot_to_hugo[key]] = value
    else:
        print(key + " not matched")

with open('../ProcessedData/merged_types_validated.txt') as file:
    for line in file:
        split = line.strip().split('\t')
        if E3_to_substrate.keys().__contains__(split[0]):
            E3_to_substrate[split[0]].append(split[1])
        else:
            E3_to_substrate[split[0]] = [split[1]]

with open('../ProcessedData/merged_types_potential.txt') as file:
    for line in file:
        split = line.strip().split('\t')
        if E3_to_substrate.keys().__contains__(split[0]):
            E3_to_substrate[split[0]].append(split[1])
        else:
            E3_to_substrate[split[0]] = [split[1]]

open('../ProcessedData/pymol/protein_features_table.tsv', 'w').write('E3\tShared Feature\tSubstrates\n')

for key, value in E3_to_substrate.items():
    motifs = {}
    if len(value) > 1:
        for prot in value:
            # print(key + " " + prot)
            if hugo_to_pdb.keys().__contains__(prot):
                protpdb = hugo_to_pdb[prot]
                dir = os.listdir('../ProcessedData/pymol/proteinFeatures/' + protpdb + '/')
                for file in dir:
                    input = open('../ProcessedData/pymol/proteinFeatures/' + protpdb + '/' + file).readlines()
                    if input != 'Unable to fetch':
                        queries = input[8:]
                        if len(queries) > 0:
                            for query in queries:
                                split = query.strip().split('\t')
                                if motifs.keys().__contains__(split[2]) and not motifs[split[2]].__contains__(prot):
                                    motifs[split[2]].append(prot)
                                else:
                                    motifs[split[2]] = [prot]
    new_motifs = {}
    for feature, substrates in motifs.items():
        if len(substrates) > 1:
            new_motifs[feature] = substrates

    with open('../ProcessedData/pymol/protein_features_table.tsv', 'a') as file:
        for feature, substrates in new_motifs.items():
            file.write(key + '\t' + feature + '\t' + ','.join(substrates) + '\n')