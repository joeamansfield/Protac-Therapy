
awk 'NR == FNR{a[$1];next} $6 in a{print $2}' ../ProcessedData/val_protacs/merged_types.txt ../Data/literature.E3.txt | awk 'NR>1{a[$1]++} END{for(b in a) print b}' > ../ProcessedData/pymol/E3_val_uniprot.tsv
awk 'NR == FNR{a[$2];next} $7 in a{print $3}' ../ProcessedData/val_protacs/merged_types.txt ../Data/literature.E3.txt | awk 'NR>1{a[$1]++} END{for(b in a) print b}' > ../ProcessedData/pymol/substrate_val_uniprot.tsv

cat ../ProcessedData/pymol/E3_val_uniprot.tsv ../ProcessedData/pymol/substrate_val_uniprot.tsv > ../ProcessedData/pymol/temp.tsv

sed ':a;N;$!ba;s/\n/,/g' ../ProcessedData/pymol/temp.tsv > ../ProcessedData/pymol/val_uniprot.csv

rm ../ProcessedData/pymol/temp.tsv
rm ../ProcessedData/pymol/E3_val_uniprot.tsv
rm ../ProcessedData/pymol/substrate_val_uniprot.tsv