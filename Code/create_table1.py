import pandas as pd

df = pd.read_table('../ProcessedData/tiered_pairs.tsv')

val_df_full = df[(df['Existing Protac'] == 'Yes') & (df['E3 Tier'] == 1) & (df['Substrate Tier'] == 1)] 

val_df = val_df_full.drop(['E3 Tier', 'Substrate Tier', 'Existing Protac'], axis = 1).reset_index(drop=True)
val_df.index = val_df.index + 1

val_df['Cancer Types'] = val_df['Cancer Types'].str.replace('_', ' ')
val_df['Cancer Types'] = val_df['Cancer Types'].str.replace(r'\(.+?\)', '', regex=True)

val_df.to_csv("../ProcessedData/val_protacs_table.csv", sep='\t', index=False, encoding='utf-8')

dfStyler = val_df.style.set_properties(**{'text-align': 'center'})
dfStyler.set_table_styles([dict(selector='th', props=[('text-align', 'center')])])

