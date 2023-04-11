import os

val_types_dir = "../ProcessedData/sig_pairs/val_protacs"
potential_types_dir = "../ProcessedData/sig_pairs/potential_protacs"


# merge files for each cancer type into one, listing the types
# associated with each E3 - substrate pair
def merge_types(types_dir, suffix):
    protac_dict = {}

    for filename in os.listdir(types_dir):
        file = os.path.join(types_dir, filename)

        cancertype = filename.split(".")[0]

        with open(file) as f:
                for line in f:
                    (E3, target) = line.split()[0], line.split()[2]
                    key = E3 + "\t" + target
                    if key not in protac_dict:
                        protac_dict[key] = [cancertype]
                    else:
                        protac_dict[key].append(cancertype)

    #print(protac_dict)

    outfile = "../ProcessedData/merged_types_" + suffix + ".txt"
    with open(outfile, 'w') as f:
        #write E3  target protein   cancer type(s)
        f.write('\n'.join('{}\t{}\t{}'.format(p, len(protac_dict[p]), ", ".join(protac_dict[p])) for p in protac_dict))


merge_types(val_types_dir, "validated")

merge_types(potential_types_dir, "potential")

