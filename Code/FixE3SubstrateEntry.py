# The last line has some missing values, so it was not being included when the R function read it in, so I added NA values rather than empty values to it, so it had enough values to be included

with open(snakemake.input[0], 'r') as file:
    with open(snakemake.output[0], 'w') as outfile:
        for line in file:
            temp = line.split()
            if len(temp) == 10:
                temp += ['NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA']
                outfile.write('\t'.join(temp))
            else:
                outfile.write(line)
