awk '/H.sapiens/' ../Data/literature.E3.txt > ../ProcessedData/hsapiens_temp.txt

awk 'NR == FNR{a[$1];next} $6 in a{print $2, $6}' ../ProcessedData/merged_types_validated.txt ../ProcessedData/hsapiens_temp.txt | awk 'NR>1{a[$0]++} END{for(b in a) print b}' > ../ProcessedData/pymol/E3_val_uniprot.tsv
awk 'NR == FNR{a[$2];next} $7 in a{print $3, $7}' ../ProcessedData/merged_types_validated.txt ../ProcessedData/hsapiens_temp.txt | awk 'NR>1{a[$0]++} END{for(b in a) print b}' > ../ProcessedData/pymol/substrate_val_uniprot.tsv
awk 'NR == FNR{a[$1];next} $6 in a{print $2, $6}' ../ProcessedData/merged_types_potential.txt ../ProcessedData/hsapiens_temp.txt | awk 'NR>1{a[$0]++} END{for(b in a) print b}' > ../ProcessedData/pymol/E3_pot_uniprot.tsv
awk 'NR == FNR{a[$2];next} $7 in a{print $3, $7}' ../ProcessedData/merged_types_potential.txt ../ProcessedData/hsapiens_temp.txt | awk 'NR>1{a[$0]++} END{for(b in a) print b}' > ../ProcessedData/pymol/substrate_pot_uniprot.tsv

cat ../ProcessedData/pymol/E3_val_uniprot.tsv ../ProcessedData/pymol/substrate_val_uniprot.tsv > ../ProcessedData/pymol/uniprot_to_hugo_val.tsv
cat ../ProcessedData/pymol/E3_pot_uniprot.tsv ../ProcessedData/pymol/substrate_pot_uniprot.tsv > ../ProcessedData/pymol/uniprot_to_hugo_pot.tsv
cat ../ProcessedData/pymol/uniprot_to_hugo_val.tsv ../ProcessedData/pymol/uniprot_to_hugo_pot.tsv > ../ProcessedData/pymol/uniprot_to_hugo.tsv

awk '{print $1}' ../ProcessedData/pymol/uniprot_to_hugo.tsv > ../ProcessedData/pymol/temp.tsv
sed ':a;N;$!ba;s/\n/,/g' ../ProcessedData/pymol/temp.tsv > ../ProcessedData/pymol/val_uniprot.csv

rm ../ProcessedData/hsapiens_temp.txt
rm ../ProcessedData/pymol/temp.tsv
rm ../ProcessedData/pymol/E3_val_uniprot.tsv
rm ../ProcessedData/pymol/substrate_val_uniprot.tsv
rm ../ProcessedData/pymol/E3_pot_uniprot.tsv
rm ../ProcessedData/pymol/substrate_pot_uniprot.tsv