import pandas as pd

df = pd.read_table('../ProcessedData/tieredpairs.tsv')

new_df_full = df[(df['Existing Protac'] == 'No') & (df['E3 Tier'] == 1) & (df['Substrate Tier'] == 1)
 & (df['Num Cancer Types'] > 2)] 

new_df = new_df_full.drop(['E3 Tier', 'Substrate Tier', 'Existing Protac'], axis = 1).reset_index(drop=True)
new_df.index = new_df.index + 1

new_df['Cancer Types'] = new_df['Cancer Types'].str.replace('_', ' ')
new_df['Cancer Types'] = new_df['Cancer Types'].str.replace(r'\(.+?\)', '', regex=True)

new_df.to_csv("../ProcessedData/new_protacs_table.csv", sep='\t', index=False, encoding='utf-8')

dfStyler = new_df.style.set_properties(**{'text-align': 'center'})
dfStyler.set_table_styles([dict(selector='th', props=[('text-align', 'center')])])
