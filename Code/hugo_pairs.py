uth_dict = {}
with open("../ProcessedData/UniprotMappingSubset.txt") as f:
    for line in f:
       (key, val) = line.split()
       uth_dict[key] = val


ifile=open("../ProcessedData/E3Sub_pairs.txt", "r")
lines=ifile.readlines()
pairs_list=[tuple(line.strip().split()) for line in lines]


hugo_pairs = []

for p in pairs_list:
    try:
   	hugo_pairs.append([uth_dict[p[0]], uth_dict[p[1]]])
    except:
	continue;


with open("../ProcessedData/hugo_pairs.txt", 'w') as fp:
    fp.write('\n'.join('{}\t{}'.format(x[0],x[1]) for x in hugo_pairs))
