import pandas as pd

mvps = pd.read_csv("mvps.csv")
# only keep relevant data from mvp table
mvps = mvps[["Player", "Year", "Pts Won", "Pts Max", "Share"]]

players = pd.read_csv("players.csv")
# remove unnecessary columns and maintain consistent naming conventions for players
del players["Unnamed: 0"]
del players["Rk"]
players["Player"] = players["Player"].str.replace("*", "", regex=False)


#  define function to reformat "team" column
#  if a player played for multiple teams, change to team the player finished the season with
def single_team(df):
    if df.shape[0] == 1:
        return df
    else:
        row = df[df["Tm"] == "TOT"]
        row["Tm"] = df.iloc[-1, :]["Tm"]
        return row


players = players.groupby(["Player", "Year"]).apply(single_team)

# drops 1st 2 indices (redundant player & year columns)
players.index = players.index.droplevel()
players.index = players.index.droplevel()

# merge mvp voting data to players table by player and season
players_mvp = players.merge(mvps, how="outer", on=["Player", "Year"])
# fill missing values for players with no mvp votes
players_mvp[["Pts Won", "Pts Max", "Share"]] = players_mvp[["Pts Won", "Pts Max", "Share"]].fillna(0)


teams = pd.read_csv("teams.csv")
# remove "division" headers found in the teams table
teams = teams[~teams["Team"].str.contains("Division")].copy()
# maintain consistent naming conventions for teams
teams["Team"] = teams["Team"].str.replace("*", "", regex=False)

# reformat table to have team names & appropriate abbreviations
team_abbrv = {}
with open("team_abbrv.csv") as x:
    lines = x.readlines()
    for line in lines:
        abbrev,name = line.replace("\n","").split(",")
        team_abbrv[abbrev] = name
players_mvp["Team"] = players_mvp["Tm"].map(team_abbrv)

# merge all data together
NBA_data = players_mvp.merge(teams, how="outer", on=["Team", "Year"])

# delete unnecessary column data
del NBA_data["Unnamed: 0"]

# convert to correct data types
NBA_data = NBA_data.apply(pd.to_numeric, errors='ignore')
NBA_data["GB"] = pd.to_numeric(NBA_data["GB"].str.replace("—","0"))

NBA_data.to_csv("NBA_data.csv")

# show how each stat is correlated to mvp voting share
print(NBA_data.corr()["Share"])