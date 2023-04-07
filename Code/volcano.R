#If you want to run it and make all of the figures (rather than just one), use this command: snakemake --cores 1
#It's easiest to just run all of them, but I know that you might want to do just one for debugging, so here is how to do just one:
# If you want to run a single one, replace <output file> with the name of the file for the figure in this command: snakemake --cores 1 <output file>
# The output file needs to be in the format of ../Figures/{type}_volcano.png, for example: snakemake --cores 1 ../Figures/clear_cell_renal_cell_carcinoma_(kidney)_volcano.png

library(tidyverse)
library(data.table)
library(viridis)
library(ggrepel)

input = data.frame(fread(snakemake@input[[1]], skip=3))
e3list = read_csv(snakemake@input[[2]], col_names = FALSE)
labels = read_csv(snakemake@input[[3]], col_names = FALSE)


#input$diffexpressed <- "NO"
#input$diffexpressed[input$Fold_Change < -0.6 & input$P-value < 0.05] <- "DOWN" 


#input$delabel <- NA
#input$delabel[input$diffexpressed != "NO"] <- input$gene


pdf(file = snakemake@output[[1]])

#input$E3_target) <- "NO"
#de$
foldChangePos = input$Fold_Change[which(input$Fold_Change > 0)]
foldCutoff = 0

input = input %>%
	mutate(Genes = ifelse(.$P.value > (.05/nrow(input)) | .$Fold_Change < foldCutoff, 'Insignificant E3s and Substrates',
		ifelse(.$Gene %in% e3list$X1, 'Significant E3s', 'Significant Substrates'))) %>%
	mutate(Label = ifelse(.$Gene %in% labels$X1, .$Gene, NA))
input$Genes = factor(input$Genes, levels = c('Significant E3s', 'Significant Substrates', 'Insignificant E3s and Substrates'))
# colors = rev(viridis_pal(option="D")(3))
# temp = colors[1]
# colors[1] = colors[2]
# colors[2] = temp
# colors[3] = 
colors = c('#21908CFF', '#FFA500', '#A0A0A0')
plotTitle = paste0("Perturbed E3 Ligases and their Substrates in ", str_to_title(paste(str_split(snakemake@wildcards[[1]], pattern = '_')[[1]], collapse = " ")))
ggplot(data = input, aes(x = Fold_Change, y = -log10(P.value), col = Genes)) + 
	ggtitle(plotTitle) +
	geom_point(size = .3) + 
	theme_minimal() +
	geom_text_repel(aes(label = Label),
    show.legend = FALSE, size = 2.5,
    max.time = 5, max.iter = 1e6) +
	# scale_color_viridis(discrete=TRUE, direction = -1) +
	scale_color_manual(values=colors) +
	#geom_hline(yintercept = -log10(0.05/nrow(input)), col="red") +
	#geom_vline(xintercept = foldCutoff, col="red", linetype = "dashed") +
	labs(x = "Fold Change (log2)", y = "Significance (-log10(p-value))")
	
#ggsave(snakemake@output[[1]])
dev.off()

#write_csv(input, "dummy.txt")
