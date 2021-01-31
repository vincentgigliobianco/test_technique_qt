
import pandas as pd
from sklearn.preprocessing import LabelEncoder


def to_le(df,feature):
    le = LabelEncoder()
    le.fit(df[feature])
    df[feature + "_labels_encoding"] = le.transform(df[feature])
    return df