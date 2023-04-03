mkdir ../ProcessedData/sig_pairs/most_sig


for type in ../ProcessedData/sig_pairs/val_protacs/*; do
	prefix=$"../ProcessedData/sig_pairs/val_protacs/"

	cancertype=${type#"$prefix"}

	cat ../ProcessedData/sig_pairs/val_protacs/${cancertype%.*} ../ProcessedData/sig_pairs/potential_protacs/${cancertype%.*} | sort -gk2 -gk4 | head -5 | awk 'NR==1 {print $1};{print $3}' > ../ProcessedData/sig_pairs/most_sig/${cancertype%.*}_most_sig.txt
	
	echo "${cancertype}"

done  

	
