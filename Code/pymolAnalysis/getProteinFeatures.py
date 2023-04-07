import requests
import os

pdbfiles = os.listdir('../ProcessedData/pymol/pdbfiles')

for file in pdbfiles:

    pdbid = file.upper().split('.')[0]

    with open('../ProcessedData/pymol/pdbfiles/' + file) as pdbfile:
        for line in pdbfile:
            if line.find('CHAIN: ') != -1:
                chains = line[line.find('CHAIN: ') + 7 : line.find(';')].split(',')
                break
            elif line == 'Unable to fetch':
                chains = []
                if pdbid not in os.listdir('../ProcessedData/pymol/proteinFeatures/'):
                    os.mkdir('../ProcessedData/pymol/proteinFeatures/' + pdbid)
                open('../ProcessedData/pymol/proteinFeatures/' + pdbid + '/' + pdbid + '.txt', 'w').write('Unable to fetch')
    print('Getting features for ', end=" ")
    for chain in chains:
        print(pdbid + chain.strip(), end=" ")
        submitResponse = requests.get('https://www.ncbi.nlm.nih.gov/Structure/bwrpsb/bwrpsb.cgi?queries=' + pdbid + chain.strip() + '&useid1=true&tdata=feats')
        id = submitResponse.text[submitResponse.text.find('cdsid') + 6 : submitResponse.text.find('#datatype') - 1]
        response = requests.get('https://www.ncbi.nlm.nih.gov/Structure/bwrpsb/bwrpsb.cgi?cdsid=' + id)
        while response.text[response.text.find('#status') + 8] != '0':
            response = requests.get('https://www.ncbi.nlm.nih.gov/Structure/bwrpsb/bwrpsb.cgi?cdsid=' + id)
        if pdbid not in os.listdir('../ProcessedData/pymol/proteinFeatures/'):
            os.mkdir('../ProcessedData/pymol/proteinFeatures/' + pdbid)
        open('../ProcessedData/pymol/proteinFeatures/' + pdbid + '/' + pdbid + chain.strip() + '.txt', 'w').write(response.text)

    open('../ProcessedData/pymol/proteinFeatures/' + pdbid + '/' + "status.txt", "w").write("Done")
    print('')
