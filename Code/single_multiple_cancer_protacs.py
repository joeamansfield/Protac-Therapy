import os

merged_types_data = "../ProcessedData/merged_types.txt"

scp_output = "../ProcessedData/single_cancer_protacs.txt"
mcp_output = "../ProcessedData/multiple_cancer_protacs.txt"

scp_counter = 0
mcp_counter = 0


with open(merged_types_data) as m, open(scp_output, "w") as scp_o, open(mcp_output, "w") as mcp_o:
	for line in m:
		(E3, target , cancer_types) = line.split()
		cancer_list = cancer_types.split(",")
		if len(cancer_list) == 1:
			scp_o.write(line)
			scp_counter += 1
											
		else:
			mcp_o.write(line)
			mcp_counter +=1
	
	print(scp_counter)
	print(mcp_counter)
