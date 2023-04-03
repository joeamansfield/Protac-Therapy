import os
import pandas as pd

single_cancer_protacs_file = "../ProcessedData/single_cancer_protacs.txt"


output_file = "../ProcessedData/single_cancer_protacs_pval.txt"

with open(single_cancer_protacs_file) as s, open(output_file, "w") as o:
	for line in s: # single protac count = 16
		(scp_E3,scp_target,scp_cancer_type) = line.split()
		for filename in os.listdir(sig_pairs_dir):
			if filename.endswith("_vals.txt"): #file name ending with _vals.txt = 6
				cancer_type = filename.split("_sig")[0]
				if cancer_type == scp_cancer_type: # should be only 1a
					file = os.path.join(sig_pairs_dir, filename)
					with open(file) as f:
						for line in f:
							(E3, E3_pval, E3_fc, target, target_pval, target_fc) = line.split()
							if E3 == scp_E3 and target == scp_target:
								o.write(E3 + "\t" + target + "\t" + target_pval + "\t" + cancer_type + "\n")



df = pd.read_csv("../ProcessedData/single_cancer_protacs_pval.txt", sep = "\t", header = None)

with open("../ProcessedData/single_cancer_protacs_pval.txt", "w") as o:
	sorted_df = df.sort_values(df.columns[2])
	sorted_df = sorted_df.to_string(header=False, index=False)
	o.write(sorted_df)

	
