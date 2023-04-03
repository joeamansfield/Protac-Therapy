mkdir -p ../ProcessedData/sig_pairs/table2


for type in ../ProcessedData/sig_pairs/potential_protacs/*; do
	prefix=$"../ProcessedData/sig_pairs/potential_protacs/"

	cancertype=${type#"$prefix"}

	awk 'NR == 1{a[$1];next} $1 in a' <(sort -gk2 -gk4 ../ProcessedData/sig_pairs/potential_protacs/${cancertype%.*}) <(sort -gk2 -gk4 ../ProcessedData/sig_pairs/potential_protacs/${cancertype%.*}) | head -5 | sort -u | awk 'NR==1 {print "E3\tP-Value\n" $1, $2 "\n\nSubstrate\tP-Value"}; {print $1, $3, $4};' OFS='\t' > ../ProcessedData/sig_pairs/table2/${cancertype%.*}_most_sig.txt

done  

	
