#If you want to run it and make all of the figures (rather than just one), use this command: snakemake --cores 1
#It's easiest to just run all of them, but I know that you might want to do just one for debugging, so here is how to do just one:
# If you want to run a single one, replace <output file> with the name of the file for the figure in this command: snakemake --cores 1 <output file>
# The output file needs to be in the format of ../Figures/{type}_volcano.png, for example: snakemake --cores 1 ../Figures/clear_cell_renal_cell_carcinoma_(kidney)_volcano.png

library(tidyverse)


input = read.csv(snakemake@input[[1]])

#input$diffexpressed <- "NO"
#input$diffexpressed[input$Fold_Change < -0.6 & input$P-value < 0.05] <- "DOWN" 


#input$delabel <- NA
#input$delabel[input$diffexpressed != "NO"] <- input$gene


pdf(file = snakemake@output[[1]])
ggplot(data = input, aes(x = Fold_Change, y = -log10(P.value))) + 
	geom_point() + 
	theme_minimal() +
	#geom_text_repel() +
	scale_color_manual(values=c("blue", "black", "red")) + 
	#geom_vline(xintercept=c(-0.6,0.6), col="red") + 
	#geom_hline(yintercept = -log(0.05), col="red") +
	labs(x = "log2(fold change)", y = "-log10(p-value)")
	
#ggsave(snakemake@output[[1]])
dev.off()

#write_csv(input, "dummy.txt")
