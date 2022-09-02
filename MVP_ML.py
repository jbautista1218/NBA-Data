import pandas as pd

from DataCleaning import NBA_data
from sklearn.linear_model import Ridge

# Shows how each stat correlates to MVP voting share
NBA_data.corr()["Share"]
# Age        0.008057
# G          0.088301
# GS         0.165025
# MP         0.157000
# FG         0.266440
# FGA        0.240522
# FG%        0.058825
# 3P         0.114873
# 3PA        0.114308
# 3P%        0.034410
# 2P         0.262198
# 2PA        0.238222
# 2P%        0.056144
# eFG%       0.054662
# FT         0.314490
# FTA        0.319017
# FT%        0.041911
# ORB        0.086719
# DRB        0.208287
# TRB        0.179629
# AST        0.223678
# STL        0.165989
# BLK        0.126691
# TOV        0.245557
# PF         0.064903
# PTS        0.280857
# Year      -0.007246
# Pts Won    0.995744
# Pts Max    0.534968
# Share      1.000000
# W          0.117644
# L         -0.117014
# W/L%       0.119169
# GB        -0.093470
# PS/G       0.040734
# PA/G      -0.032792
# SRS        0.114493

# numerical data that contributes to MVP voting data
predictors = ['Age', 'G', 'GS', 'MP', 'FG', 'FGA', 'FG%', '3P',
              '3PA', '3P%', '2P', '2PA', '2P%', 'eFG%', 'FT', 'FTA', 'FT%', 'ORB',
              'DRB', 'TRB', 'AST', 'STL', 'BLK', 'TOV', 'PF', 'PTS', 'Year',
              'W', 'L', 'W/L%', 'GB', 'PS/G', 'PA/G', 'SRS']

# initialize training and testing data for machine learning predictions
train = NBA_data[NBA_data["Year"] < 2022]
test = NBA_data[NBA_data["Year"] == 2022]

# ridge regression model
regression = Ridge(alpha=.1)
regression.fit(train[predictors], train["Share"])

# mvp prediction
predictions = regression.predict(test[predictors])
predictions = pd.DataFrame(predictions, columns=["predictions"], index=test.index)
# concatenate with player's data
mvp_pred = pd.concat([test[["Player", "Share"]], predictions], axis=1)

# Add real MVP voting outcome & predicted MVP voting outcome
mvp_pred = mvp_pred.sort_values("Share", ascending=False)
mvp_pred["Rk"] = list(range(1, mvp_pred.shape[0]+1))
mvp_pred = mvp_pred.sort_values("predictions", ascending=False)
mvp_pred["Predicted Rk"] = list(range(1, mvp_pred.shape[0]+1))
