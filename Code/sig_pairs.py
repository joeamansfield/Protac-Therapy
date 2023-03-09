import sys
import os

#create dictionary of E3 ligase and target protein pairs
def create_pairs_dict(filename):
    pairs_dict = {}
    with open(filename) as f:
        for line in f:
            pair = line.split()
	    key = pair[0]
	    val = pair[1]
            if key not in pairs_dict:
                pairs_dict[key] = [val]
            else:
                pairs_dict[key].append(val)

    return pairs_dict


#filter by significant p-values and fold changes
def filter_sig(filename):
    val_dict = {}
    filename = "../ProcessedData/pvalues/" + filename
    with open(filename) as f:
	next(f)
	line = next(f)
        (sig_pval, sig_fc) = line.split(',')
	#sig_pval = line.split(',')[0]
	sig_pval = float(sig_pval)
	sig_fc = float(sig_fc)
        next(f)
	next(f)
        for line in f:
            (gene, pval, fc) = line.split(',')
	    pval = float(pval)
	    fc = float(fc)
            if pval <= sig_pval and fc > 0:
                val_dict[gene] = [pval, fc]

    return val_dict


#find significant pairs
def find_sig_pairs(pairs_dict, val_dict):
    sig_pairs = []
    sig_pairs_vals = []
    for key in pairs_dict:
        if key not in val_dict:
            continue
        else: 
            for val in pairs_dict[key]:
                if val in val_dict:
                    sig_pairs.append([key, val])
                    sig_pairs_vals.append([[key, val_dict[key][0], val_dict[key][1]], [val, val_dict[val][0], val_dict[val][1]]])


    return sig_pairs, sig_pairs_vals



#pass in the name of the file with the E3 ligase and target protein pairs as first argument
#pass in directory with cancer type pvalue files as second argument 
    #(cutoff vals for p-vals and fc should be the second line of these files)

pairs_file = "../ProcessedData/E3Sub_pairs_full.txt"
pval_dir = "../ProcessedData/pvalues"

pairs_dict = create_pairs_dict(pairs_file)

for filename in os.listdir(pval_dir):
    f = os.path.join(pval_dir, filename)
    if True:
        val_dict = filter_sig(filename)
        sig_pairs, sig_pairs_vals = find_sig_pairs(pairs_dict, val_dict)

        outfile1 = "../ProcessedData/sig_pairs/" + filename.split(".")[0] + "_sig_pairs.txt"
        with open(outfile1, 'w') as f:
            #write E3  target protein
            f.write('\n'.join('{}\t{}'.format(p[0],p[1]) for p in sig_pairs))

        outfile2 = "../ProcessedData/sig_pairs/" + filename.split(".")[0] + "_sig_pairs_vals.txt"
        with open(outfile2, 'w') as f:
            #write E3  pval  fc  target protein  pval  fc
            f.write('\n'.join('{}\t{}\t{}\t{}\t{}\t{}'.format(p[0][0],p[0][1],p[0][2],p[1][0],p[1][1],p[1][2]) for p in sig_pairs_vals))

