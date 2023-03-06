library(data.table)

data = fread(snakemake@input[[1]], header=FALSE)
data = data.frame(data)

out = c("Gene", "P-value", "Fold_Change")

for (i in 3:nrow(data)) {
	tumor = as.list(as.data.frame(t(data[i, which(data[2,] == "Tumor")])))
	normal = as.list(as.data.frame(t(data[i, which(data[2,] == "Normal")])))
	tumor = unlist(lapply(tumor[[1]], function(x){x[x != ""]}))
	normal = unlist(lapply(normal[[1]], function(x){x[x != ""]}))
	if (length(tumor) > 1 && length(normal) > 1) {
		result = t.test(as.numeric(normal), as.numeric(tumor))
		foldChange = (log2(result$estimate[[2]]) - log2(result$estimate[[1]]))
		out = rbind(out, c(data[i,1], result$p.value, foldChange))
	}
}
if (length(out) > 3) {
	names = out[1,]
	out = data.table(out[-c(1),])
	setnames(out, names)
} else {
	out = list("Not enough data")
}

out = out[is.finite(as.numeric(out$Fold_Change)),]

positiveFoldChange = out$Fold_Change[which(as.numeric(out$Fold_Change) > 0)]

writeLines(c('pvalue_cutoff,fc_cutoff', 
	paste0(toString(0.05/nrow(out)), ',', toString(quantile(as.numeric(positiveFoldChange))[4])), '#######'), 
	file(snakemake@output[[1]]))

fwrite(out, snakemake@output[[1]], append = TRUE, col.names=TRUE)

