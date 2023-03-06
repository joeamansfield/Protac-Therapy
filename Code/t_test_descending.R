library(tidyverse)




#cancerTypesSubset = [
#'clear_cell_renal_cell_carcinoma_(kidney)',
#'endometrial_carcinoma_(uterine)',
#'glioblastoma',
#'head_and_neck_squamous_cell_carcinoma',
#'lung_squamous_cell_carcinoma',
#]

for (i in 1:length(snakemake@input)) {
	infile = read_csv(snakemake@input[[i]]) %>%
		arrange(V1) %>%
		head(10)
	
	write_csv(infile, snakemake@output[[i]])
}

# lung = read_csv("../ProcessedData/pvalues/lung_squamous_cell_carcinoma.txt") %>%
# 	arrange(V1) %>%
# 	head(10)



# kidney = read_csv("../ProcessedData/pvalues/clear_cell_renal_cell_carcinoma_(kidney).txt") %>%
# 	arrange(V1) %>%
# 	head(10)




# glioblastoma = read_csv("../ProcessedData/pvalues/glioblastoma.txt") %>%
# 	arrange(V1) %>%
# 	head(10)




# head_and_neck = read_csv("../ProcessedData/pvalues/head_and_neck_squamous_cell_carcinoma.txt") %>%
# 	arrange(V1) %>%
# 	head(10)




# uterine = read_csv("../ProcessedData/pvalues/endometrial_carcinoma_(uterine).txt") %>%
# 	arrange(V1) %>%
# 	head(10)





# write_csv(lung,"../ProcessedData/sorted_pvalues/lung.csv")
# write_csv(kidney,"../ProcessedData/sorted_pvalues/kidney.csv")
# write_csv(glioblastoma,"../ProcessedData/sorted_pvalues/glioblastoma.csv")
# write_csv(head_and_neck,"../ProcessedData/sorted_pvalues/head_and_neck.csv")
# write_csv(uterine,"../ProcessedData/sorted_pvalues/uterine.csv")
