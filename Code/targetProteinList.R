library(data.table)

data = fread(snakemake@input[[1]])

fwrite(list(unique(data$sub)), snakemake@output[[1]])