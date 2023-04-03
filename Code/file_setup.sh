# filter E3_Subs download for human genes
awk -F'\t' '/H.sapiens/{print $6, $7, $8, $9, $11, $14}' OFS='\t' ../Data/literature.E3.txt > ../Data/E3Subs_known.txt

# create existing protacs file 
awk -F',' 'NR>1{print $4, $3}' ../Data/Protac.csv | awk '{print $1, $2}' OFS='\t' | sort -u | tr -d '"' > ../ProcessedData/existing_protacs.txt

# create E3 - target pairs file
cat <(awk ' {print $1, $2}' OFS='\t' ../Data/E3Subs_known.txt | awk '!/-$/') ../ProcessedData/existing_protacs.txt | sort -u > ../ProcessedData/E3Sub_pairs_full.txt

# create E3 list
awk '{print $1}' ../ProcessedData/E3Sub_pairs_full.txt | sort -u > ../ProcessedData/E3List.txt

# create target protein list
awk '{print $2}' ../ProcessedData/E3Sub_pairs_full.txt | sort -u > ../ProcessedData/targetProteinList.txt

# create subset list
cat ../ProcessedData/E3List.txt ../ProcessedData/targetProteinList.txt | sort -u > ../ProcessedData/subset_list.txt
