library(data.table)

data = fread(snakemake@input[[1]])
uniqueData = data.frame(unique(data$enyz))
colnames(uniqueData) = c('Uniprot')

mapping = fread(snakemake@input[[2]], header=FALSE)
colnames(mapping) = c('Uniprot', 'HGNC')

joinedData = merge(x = uniqueData, y = mapping, by = 'Uniprot', all.x=TRUE)

fwrite(list(joinedData$HGNC), snakemake@output[[1]])

