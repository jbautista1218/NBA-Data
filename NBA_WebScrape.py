import os
import requests
import pandas as pd
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
import time

# looking at NBA stats from 2000-2022 seasons
years = list(range(2000, 2023))

# NBA MVP stats
mvp_url = "https://www.basketball-reference.com/awards/awards_{}.html"

# loop requests for each year's NBA MVP voting results
for year in years:
    url = mvp_url.format(year)
    data = requests.get(url)
    # save .html files
    with open("/Users/JustinB/PycharmProjects/NBA_Data/MVP/mvp{}.html".format(year), "w+", encoding="utf-8") as x:
        x.write(data.text)

# loop parse statements for each year's NBA MVP voting data
df = []
for year in years:
    with open("/Users/JustinB/PycharmProjects/NBA_Data/MVP/mvp{}.html".format(year), encoding="utf-8") as x:
        page = x.read()
    soup = BeautifulSoup(page, "html.parser")
    # remove unnecessary headers found in the html tables
    soup.find('tr', class_="over_header").decompose()
    mvp_data = soup.find_all(id="mvp")[0]
    mvp_df = pd.read_html(str(mvp_data))[0]
    mvp_df["Year"] = year
    df.append(mvp_df)

# concatenate all MVP data into a central dataset
mvps = pd.concat(df)
mvps.to_csv("mvps.csv")

# league-wide player stats
player_stats_url = "https://www.basketball-reference.com/leagues/NBA_{}_per_game.html"

# loop requests for each year's NBA player stats
for year in years:
    url = player_stats_url.format(year)
    data = requests.get(url)
    with open("/Users/JustinB/PycharmProjects/NBA_Data/Player_Stats/players{}".format(year), "w+",
              encoding="utf-8") as x:
        x.write(data.text)

# initialize chromedriver; allow for Chrome browser scripts
ser = Service("/Users/JustinB/Downloads/chromedriver/chromedriver.exe")
op = webdriver.ChromeOptions()
driver = webdriver.Chrome(service=ser, options=op)

# scrolls through page to render data
for year in years:
    url = player_stats_url.format(year)
    driver.get(url)
    driver.execute_script("window.scrollTo(1,10000)")
    time.sleep(2)
    with open("/Users/JustinB/PycharmProjects/NBA_Data/Player_Stats/players{}".format(year), "w+", encoding="utf-8") as x:
        x.write(driver.page_source)

# loop parse statements for each year's player stats
df = []
for year in years:
    with open("/Users/JustinB/PycharmProjects/NBA_Data/Player_Stats/players{}".format(year), encoding="utf-8") as x:
        page = x.read()
    soup = BeautifulSoup(page, 'html.parser')
    soup.find('tr', class_="thead").decompose()
    player_table = soup.find_all(id="per_game_stats")[0]
    player_df = pd.read_html(str(player_table))[0]
    player_df["Year"] = year
    df.append(player_df)

# concatenate all player data into a central dataset
players = pd.concat(df)
players.to_csv("players.csv")

team_stats_url = "https://www.basketball-reference.com/leagues/NBA_{}_standings.html"

# loop requests for each year's NBA team stats
for year in years:
    url = team_stats_url.format(year)
    data = requests.get(url)
    with open("/Users/JustinB/PycharmProjects/NBA_Data/Team_Stats/teams{}".format(year), "w+", encoding="utf-8") as x:
        x.write(data.text)

# loop parse statements for each year's team stats (East & West Conference Standings)
df = []
for year in years:
    with open("/Users/JustinB/PycharmProjects/NBA_Data/Team_Stats/teams{}".format(year), encoding="utf-8") as x:
        page = x.read()
    soup = BeautifulSoup(page, 'html.parser')
    soup.find('tr', class_="thead").decompose()

    # Eastern Conference teams
    e_table = soup.find_all(id="divs_standings_E")[0]
    e_df = pd.read_html(str(e_table))[0]
    e_df["Year"] = year
    e_df["Team"] = e_df["Eastern Conference"]
    del e_df["Eastern Conference"]
    df.append(e_df)
    # Western Conference teams

    w_table = soup.find_all(id="divs_standings_W")[0]
    w_df = pd.read_html(str(w_table))[0]
    w_df["Year"] = year
    w_df["Team"] = w_df["Western Conference"]
    del w_df["Western Conference"]
    df.append(w_df)

# concatenate all team data into a central dataset
teams = pd.concat(df)
teams.to_csv("teams.csv")
