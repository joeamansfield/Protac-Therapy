## About 550 of these uniprot ids do not map to HGNC, so they have not been included unfortunately

library(data.table)

data = fread(snakemake@input[[1]])
uniqueData = data.frame(unique(data$sub))
colnames(uniqueData) = c('Uniprot')

mapping = fread(snakemake@input[[2]], header=FALSE)
colnames(mapping) = c('Uniprot', 'HGNC')

joinedData = merge(x = uniqueData, y = mapping, by = 'Uniprot', all.x=TRUE)

fwrite(list(na.omit(joinedData$HGNC)), snakemake@output[[1]])