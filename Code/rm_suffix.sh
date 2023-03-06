
for type in ../ProcessedData/pvalues/*; do 
	cancertype=${type##*/}
	awk -F, '{sub(/_transcriptomics$/,"",$1)}1' ../ProcessedData/pvalues/${cancertype%.*}.txt > ../ProcessedData/pvalues/${cancertype%.*}_clean.txt
	rm ../ProcessedData/pvalues/${cancertype%.*}.txt
	mv ../ProcessedData/pvalues/${cancertype%.*}_clean.txt ../ProcessedData/pvalues/${cancertype%.*}.txt

	echo "${cancertype%.*}"
done
