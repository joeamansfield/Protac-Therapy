mkdir -p ../ProcessedData/val_protacs

for type in ../ProcessedData/sig_pairs/*_sig_pairs.txt; do
	prefix=$"../ProcessedData/sig_pairs/"
        suffix=$"_sig_pairs.txt"

        cancertype=${type#"$prefix"}
        cancertype=${cancertype%"$suffix"}

        awk 'NR == FNR{a[$0];next} $0 in a' OFS='\t' ../ProcessedData/existing_protacs.txt ../ProcessedData/sig_pairs/${cancertype%.*}_sig_pairs.txt > ../ProcessedData/val_protacs/${cancertype%.*}.txt

done
