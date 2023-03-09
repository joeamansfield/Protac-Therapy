
#these folders will be removed
mkdir -p ../ProcessedData/subset_steps/temp_data
mkdir -p ../ProcessedData/subset_steps/tt_data
mkdir -p ../ProcessedData/subset_steps/subset_data

#this folder will have the final subset files
mkdir -p ../ProcessedData/subset_data

#changes the file to tab delimited, transposes the table to have genes as first column, and removes the _transcriptomics suffix from the name
for type in ../Data/CPTAC/*; do 
	cancertype=${type##*/}
	sed 's/\,/\t/g' ../Data/CPTAC/${cancertype%.*}.csv > ../ProcessedData/subset_steps/temp_data/${cancertype%.*}_tmp.csv
	awk -f ./test.awk ../ProcessedData/subset_steps/temp_data/${cancertype%.*}_tmp.csv > ../ProcessedData/subset_steps/tt_data/${cancertype%.*}_tt.csv

	awk -F'\t' '{sub(/_transcriptomics$/,"",$1)}1' OFS='\t' ../ProcessedData/subset_steps/tt_data/${cancertype%.*}_tt.csv > ../ProcessedData/subset_steps/tt_data/${cancertype%.*}_rm.csv
        rm ../ProcessedData/subset_steps/tt_data/${cancertype%.*}_tt.csv
        mv ../ProcessedData/subset_steps/tt_data/${cancertype%.*}_rm.csv ../ProcessedData/subset_steps/tt_data/${cancertype%.*}_tt.csv
	
	echo "formatted ${cancertype%.*}"
done

#subsets the files by E3 ligases and target proteins from our lists
for type in ../ProcessedData/subset_steps/tt_data/*; do
        cancertype=${type##*/}
        awk 'NR < 3' ../ProcessedData/subset_steps/tt_data/${cancertype%.*}.csv > ../ProcessedData/subset_steps/subset_data/${cancertype%.*}_hdrs.csv
        awk 'NR == FNR{a[$0];next} $1 in a' ../ProcessedData/subset_list.txt ../ProcessedData/subset_steps/tt_data/${cancertype%.*}.csv > ../ProcessedData/subset_steps/subset_data/${cancertype%.*}_subset.csv
        cat ../ProcessedData/subset_steps/subset_data/${cancertype%.*}_hdrs.csv ../ProcessedData/subset_steps/subset_data/${cancertype%.*}_subset.csv > ../ProcessedData/subset_steps/subset_data/${cancertype%.*}_subset_hdrs.csv

        cp ../ProcessedData/subset_steps/subset_data/${cancertype%.*}_subset_hdrs.csv ../ProcessedData/subset_data/${cancertype%.*}_subset.csv
	
	echo "subset ${cancertype%.*}"
done

#clean up extra intermediary folders
rm -r ../ProcessedData/subset_steps

