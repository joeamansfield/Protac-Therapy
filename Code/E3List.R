library(data.table)

data = fread(snakemake@input[[1]])

fwrite(list(unique(data$enyz)), snakemake@output[[1]])

