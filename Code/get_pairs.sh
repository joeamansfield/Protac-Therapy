awk ' {print $1, $2}' ../Data/E3Subs_known.txt > ./tmp.txt

awk '!/-$/' ./tmp.txt > ../ProcessedData/E3Sub_pairs.txt

rm ./tmp.txt
