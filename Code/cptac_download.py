import pandas as pd
import cptac
import os
import sys
print(sys.argv)
cancerSets = []
cancerTypes = [
'breast_cancer',
'clear_cell_renal_cell_carcinoma_(kidney)',
'colorectal_cancer',
'endometrial_carcinoma_(uterine)',
'glioblastoma',
'head_and_neck_squamous_cell_carcinoma',
'lung_squamous_cell_carcinoma',
'lung_adenocarcinoma',
'high_grade_serous_ovarian_cancer',
'pancreatic_ductal_adenocarcinoma']
cptac.download(dataset="brca") #breast cancer
cancerSets.append(cptac.Brca())
cptac.download(dataset="ccrcc") #clear cell renal cell carcinoma (kidney)
cancerSets.append(cptac.Ccrcc())
cptac.download(dataset="colon") #colorectal cancer
cancerSets.append(cptac.Colon())
cptac.download(dataset="endometrial") #endometrial carcinoma (uterine)
cancerSets.append(cptac.Endometrial())
cptac.download(dataset="gbm") #glioblastoma
cancerSets.append(cptac.Gbm())
cptac.download(dataset="hnscc") #head and neck squamous cell carcinoma
cancerSets.append(cptac.Hnscc())
cptac.download(dataset="lscc") #lung squamous cell carcinoma
cancerSets.append(cptac.Lscc())
cptac.download(dataset="luad") #lung adenocarcinoma
cancerSets.append(cptac.Luad())
cptac.download(dataset="ovarian") #high grade serous ovarian cancer
cancerSets.append(cptac.Ovarian())
cptac.download(dataset="pdac") #pancreatic ductal adenocarcinom
cancerSets.append(cptac.Pdac())

outdir = sys.argv[-1]
folders = outdir.split('/')
if folders[1] not in os.listdir(folders[0]):
    os.mkdir('/'.join([folders[0], folders[1]]))
if folders[2] not in os.listdir('/'.join([folders[0], folders[1]])):
    os.mkdir(outdir)

fileList = sys.argv[1:-1]

for i in range((len(cancerSets))):
    cancerSets[i] = cancerSets[i].join_metadata_to_omics(metadata_df_name='clinical',omics_df_name='transcriptomics',metadata_cols = ["Sample_Tumor_Normal"])
    cancerSets[i].to_csv(fileList[i])