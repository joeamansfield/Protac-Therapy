import sys
import os

#create dictionary of all E3 ligase and target protein pairs
def create_pairs_dict(filename):
    pairs_dict = {}
    with open(filename) as f:
        for line in f:
            pair = line.split()
	    key = pair[0].upper()
	    val = pair[1].upper()
            if key not in pairs_dict:
                pairs_dict[key] = [val]
            else:
                pairs_dict[key].append(val)

    return pairs_dict



#filter by significant p-values and fold changes
def filter_sig(filename):
    sig_genes_dict = {}
    filename = "../ProcessedData/pvalues/" + filename
    with open(filename) as f:
	next(f)
	line = next(f)
        #(sig_pval, sig_fc) = line.split(',')
	sig_pval = line.split(',')[0]
	sig_pval = float(sig_pval)
	#sig_fc = float(sig_fc)
        next(f)
	next(f)
        for line in f:
            (gene, pval, fc) = line.split(',')
	    pval = float(pval)
	    fc = float(fc)
            if pval <= sig_pval and fc > 0:
                sig_genes_dict[gene.upper()] = [pval, fc]

    return sig_genes_dict


#find significant pairs
def find_sig_pairs(pairs_dict, sig_genes_dict):
    sig_pairs = []
    for E3 in pairs_dict:
        if E3 not in sig_genes_dict:
            continue
        else: 
            for sub in pairs_dict[E3]:
                if sub in sig_genes_dict: # add paired genes with p-values to list
                    sig_pairs.append([[E3, sig_genes_dict[E3][0]], [sub, sig_genes_dict[sub][0]]])


    return sig_pairs


#split into validated existing protac pairs and potential new pairs
def validate_protacs(protact_dict, sig_pairs):
    val_protacs = []
    potential_protacs = []
    for p in sig_pairs:
	E3 = p[0][0]
	sub = p[1][0] 
	if E3 in protact_dict and sub in protact_dict[E3]:
	    val_protacs.append([[E3, p[0][1]], [sub, p[1][1]]])
	else:
	    potential_protacs.append([[E3, p[0][1]], [sub, p[1][1]]])

    return val_protacs, potential_protacs


#pass in the name of the file with the E3 ligase and target protein pairs as first argument
#pass in directory with cancer type pvalue files as second argument 
    #(cutoff vals for p-vals and fc should be the second line of these files)


os.system("mkdir ../ProcessedData/sig_pairs")
os.system("mkdir ../ProcessedData/sig_pairs/val_protacs")
os.system("mkdir ../ProcessedData/sig_pairs/potential_protacs")

pairs_file = "../ProcessedData/E3Sub_pairs_full.txt"
pval_dir = "../ProcessedData/pvalues"
existing_protacs = "../ProcessedData/existing_protacs.txt"

pairs_dict = create_pairs_dict(pairs_file)
protac_dict = create_pairs_dict(existing_protacs)

for filename in os.listdir(pval_dir):
    f = os.path.join(pval_dir, filename)
    if True:
        sig_genes_dict = filter_sig(filename)
        sig_pairs = find_sig_pairs(pairs_dict, sig_genes_dict)

	val_protacs, potential_protacs = validate_protacs(protac_dict, sig_pairs)

        outfile1 = "../ProcessedData/sig_pairs/val_protacs/" + filename.split(".")[0]
        with open(outfile1, 'w') as f:
            #write E3  p-val  target protein  p-val
            f.write('\n'.join('{}\t{}\t{}\t{}'.format(p[0][0],p[0][1],p[1][0],p[1][1]) for p in val_protacs))

        outfile2 = "../ProcessedData/sig_pairs/potential_protacs/" + filename.split(".")[0]
        with open(outfile2, 'w') as f:
            #write E3  pval  target protein  pval 
            f.write('\n'.join('{}\t{}\t{}\t{}'.format(p[0][0],p[0][1],p[1][0],p[1][1]) for p in potential_protacs))

