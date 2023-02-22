library(data.table)

data = fread(snakemake@input[[1]], header=FALSE)
data = data.frame(data)

out = c("Gene", "P-value", "Fold_Change")

for (i in 3:nrow(data)) {
	tumor = as.list(as.data.frame(t(data[i, which(data[2,] == "Tumor")])))
	normal = as.list(as.data.frame(t(data[i, which(data[2,] == "Normal")])))
	result = t.test(as.numeric(normal[[1]]), as.numeric(tumor[[1]]), alternative = c('l'))
	foldCchange = log2(result$estimate[[2]]/result$estimate[[1]])
	out = rbind(out, c(data[i,1], result$p.value, foldCchange))	
}

fwrite(out, snakemake@output[[1]])

