
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from itertools import combinations


def to_le(df,feature):
    le = LabelEncoder()
    le.fit(df[feature])
    df[feature + "_labels_encoding"] = le.transform(df[feature])
    return df

def interaction_order(df,list_of_categ_var, order):
    
    initial_list_df = list_of_categ_var
    all_interactions = list(combinations(list_of_categ_var,order))


    for i in range(0, len(all_interactions)):

        for each in list(all_interactions[i]):
            for each in range(0,order):
                
                var_inter_name = "_+_".join(list(all_interactions[i]))
                if each == 0:
                    df[var_inter_name] = df[list(all_interactions[i])[each]]
                else:
                    df[var_inter_name] = df[var_inter_name] + '_' + df[list(all_interactions[i])[each]]

    # Keep only interaction variables in the dataframe
    df = df.drop(initial_list_df, axis=1)
    return df