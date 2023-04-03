import json
import requests

id = json.load(open('../Data/PDB/jobid.json'))

status = requests.get('https://rest.uniprot.org/idmapping/status/' + id['jobId'])
status_dict = json.loads(status.text)

while len(status_dict['results']) == 0 and status.status_code == 200:
    status = requests.get('https://rest.uniprot.org/idmapping/status/' + id['jobId'])
    status_dict = json.loads(status.text)

response = requests.get('https://rest.uniprot.org/idmapping/results/' + id['jobId'] + '?size=500')
response_dict = json.loads(response.text)

completeEntries = []
completeEntries.extend(response_dict['results'])

totalEntries = int(response.headers['X-Total-Results']) - 500
while totalEntries > 0:
    nextLink = response.headers['link'].split(';')[0][1:-1]
    totalEntries -= 500
    response = requests.get(nextLink)
    response_dict = json.loads(response.text)
    completeEntries.extend(response_dict['results'])
      
completeEntriesDict = {}

for entry in completeEntries:
    if not completeEntriesDict.keys().__contains__(entry['from']):
        completeEntriesDict[entry['from']] = entry['to']

with open("../ProcessedData/pymol/val_pdb.tsv", "w+") as ofile:
    for key, value in completeEntriesDict.items():
        ofile.write(key + '\t' + value + '\n')
