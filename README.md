# NBA-Data
Since my interest for data started from watching sports games and ESPN all the time, I thought it would only be right to work on a project including those things. In this project, I have compiled stats from the NBA dating back to the 1999-00 season (around when I first started watching basketball). 

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
  
  All data comes from "www.basketball-reference.com/"
