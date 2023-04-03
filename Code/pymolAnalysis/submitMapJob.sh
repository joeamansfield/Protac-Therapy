var=`cat ../ProcessedData/pymol/val_uniprot.csv`
curl --form 'from=UniProtKB_AC-ID' \
     --form 'to=PDB' \
     --form "ids=$var" \
     https://rest.uniprot.org/idmapping/run > ../Data/PDB/jobid.json