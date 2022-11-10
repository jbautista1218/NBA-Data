# NBA-Data

### Introduction 
Since my interest for data started from keeping up with stats for sports as a kid, I thought it would be interesting to work on a project using that data. In this project, I have compiled stats from the NBA dating back to the 1999-00 season (around when I first started watching basketball) until the 2021-2022 season. I used various Python tools to pull the data from the internet, clean/organize the data, and used Machine-learning toolkits in Python to give MVP predictions based on player and team statistics. The data was also exported into SQL and Tableau for data analysis and visualization, to gain insights on trends and relationships throughout the NBA seasons.

## Observations



#### Included Files:

  Python:
  
    NBA_WebScrape.py (packages used: BeautifulSoup, Selenium, pandas)
      Used to create the following .csv files:
        mvps.csv
        players.csv
        team_abbrv.csv
        teams.csv
    DataCleaning.py (packages used: pandas)
      Used to create the following .csv files:
        NBA_data.csv
    MVP_ML.py (in-progress) (packages used: scikit-learn)
  
  MySQL:
  
    NBA_Table_Creation.sql
    NBAsql.sql

Link to Tableau Data Visualizations:
  https://public.tableau.com/views/HistoricalNBAData/MVPDash?:language=en-US&:display_count=n&:origin=viz_share_link

Future plans:
  - Compile more data
      - Include more seasons
      - Advanced team stats
      - Advanced player stats
      - Per-game stats
  - Utilizing Python machine learning tools (scikit)
      - MVP predictions (in-progress)
  - More Data Visualizations
  
  Credit: All data comes from "www.basketball-reference.com/"
