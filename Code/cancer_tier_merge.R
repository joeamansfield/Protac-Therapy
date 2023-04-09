library(tidyverse)

args = commandArgs(trailingOnly=TRUE)

cancer_census = read_csv(args[1], col_names = TRUE)
validated = read_tsv(args[2], col_names = FALSE) %>%
  mutate(`Existing Protac` = 'Yes')
potential = read_tsv(args[3], col_names = FALSE) %>%
  mutate(`Existing Protac` = 'No')
all_protac = rbind(validated, potential)
colnames(all_protac) = c('E3 Ligase', 'Substrate', 'Cancer Types', 'Existing Protac')
all_protac = all_protac %>%
  mutate(`E3 Tier` = ifelse(.$`E3 Ligase` %in% cancer_census$`Gene Symbol`, cancer_census$Tier, NA)) %>%
  mutate(`Substrate Tier` = ifelse(.$`Substrate` %in% cancer_census$`Gene Symbol`, cancer_census$Tier, NA))
all_protac$`E3 Tier` = factor(all_protac$`E3 Tier`, levels = c('1', '2', NA))
all_protac$`Substrate Tier` = factor(all_protac$`Substrate Tier`, levels = c('1', '2', NA))
all_protac = all_protac[,c(1, 5, 2, 6, 4, 3)]
all_protac = all_protac %>%
  arrange(`Substrate`) %>%
  arrange(`E3 Ligase`) %>%
  arrange(`E3 Tier`) %>%
  arrange(`Substrate Tier`)
write.table(all_protac, file = args[4], sep = '\t')

