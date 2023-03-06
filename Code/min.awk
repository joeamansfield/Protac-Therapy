
for type in ../ProcessedData/sig_pairs/*_vals.txt; do
	prefix=$"../ProcessedData/sig_pairs/"
	suffix=$"_sig_pairs_vals.txt"

	cancertype=${type#"$prefix"}
	cancertype=${cancertype%"$suffix"}

	sort -gk2 -gk5 ../ProcessedData/sig_pairs/${cancertype%.*}_sig_pairs_vals.txt | head -5 | awk 'NR==1 {print $1};{print $4}' > ../ProcessedData/sig_pairs/most_sig/${cancertype%.*}_most_sig.txt
	
	echo "${cancertype}"

done  

	
