import os


#val_types_dir = "../ProcessedData/val_protacs"


#protact_dict = {}

#for filename in os.listdir(val_types_dir):
 #   file = os.path.join(val_types_dir, filename)

  #  cancertype = filename.split(".")[0]

   # with open(file) as f:
    #        for line in f:
     #           (E3, target) = line.split()
#		key = E3 + "\t" + target
 #               if key not in protact_dict:
  #                  protact_dict[key] = [cancertype]
   #             else:
    #                protact_dict[key].append(cancertype)
#	    for p in protact_dict:
#		if len(protact_dict[p]) > 0:
			
#print(protact_dict)

#outfile = "../ProcessedData/val_protacs/merged_types_pvals.txt"
#with open(outfile, 'w') as f:
    #write E3  target protein   cancer type(s)
 #   f.write('\n'.join('{}\t{}'.format(p,protact_dict[p]) for p in protact_dict))


merged_types_data = "../ProcessedData/val_protacs/merged_types.txt"

sig_pairs_dir = "../ProcessedData/sig_pairs"



with open(merged_types_data) as m:
	for line in m:
		(E3, target, cancertypes) = line.split()
		cancer_list = cancertypes.split(",")
		print(cancer_list)



#for filename in os.listdir(sig_pairs_dir):
#	file = os.path.join(sig_pairs_dir, filename)

#	with open(file) as f:
#		for line in f:
#			line = line.split()
#			E3 = line[0]	
#			target = 



