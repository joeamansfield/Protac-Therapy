import pandas as pd
data = pd.read_csv("Data\data_merged.txt", sep = '\t')
print(list(set(data['CANCER_TYPE_DETAILED'])))