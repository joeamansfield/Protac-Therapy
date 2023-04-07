dir=../ProcessedData/pymol/
if [ ! -d "$dir"]
then
     mkdir ../ProcessedData/pymol/
fi

var=`cat ../ProcessedData/pymol/val_uniprot.csv`
curl --form 'from=UniProtKB_AC-ID' \
     --form 'to=PDB' \
     --form "ids=$var" \
     https://rest.uniprot.org/idmapping/run > ../ProcessedData/pymol/jobid.json