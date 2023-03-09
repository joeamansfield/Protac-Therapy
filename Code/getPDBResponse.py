import json
import requests

id = json.load(open('../Data/PDB/jobid.json'))

status = requests.get('https://rest.uniprot.org/idmapping/status/' + id['jobId'])
status_dict = json.loads(status.text)

while len(status_dict['results']) == 0 and status.status_code == 200:
    status = requests.get('https://rest.uniprot.org/idmapping/status/' + id['jobId'])
    status_dict = json.loads(status.text)

response = requests.get('https://rest.uniprot.org/idmapping/results/' + id['jobId'])
response_dict = json.loads(response.text)

out = []

for entry in response_dict['results']:
    out.append(entry['to'])

open("../ProcessedData/pymol/val_pdb.csv", "w+").write(','.join(out))