import pandas as pd
import janitor as jn

RNAdata = pd.read_csv("Data\pancan_pcawg_2020\data_mrna_seq_fpkm.txt", sep = '\t')
RNAdata = RNAdata.pivot_longer(index = "Hugo_Symbol", names_to = ("SAMPLE_ID"))
#print(RNAdata.head(15))
clindata = pd.read_csv("Data\pancan_pcawg_2020\data_clinical_sample.txt", sep = '\t')
clindata.columns = clindata.iloc[3]
clindata = clindata.iloc[4:]
clindata = clindata.reindex(columns = ['SAMPLE_ID', 'CANCER_TYPE', 'CANCER_TYPE_DETAILED'])
#print(clindata.head(5))
merged = pd.merge(RNAdata, clindata, how = 'inner', on='SAMPLE_ID')
merged.to_csv("Data\data_merged.txt", sep = '\t')