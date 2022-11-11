# NBA-Data

### Introduction 
Since my interest for data started from keeping up with stats for sports as a kid, I thought it would be interesting to work on a project using that data. In this project, I have compiled stats from the NBA dating back to the 1999-00 season (around when I first started watching basketball) until the 2021-2022 season. I used various Python tools to pull the data from the internet, clean/organize the data, and used Machine-learning toolkits in Python to give MVP predictions based on player and team statistics. The data was also exported into SQL and Tableau for data analysis and visualization, to gain insights on trends and relationships throughout the NBA seasons.

### Observations

As expected, when using the ridge regression and random forest regression, it was able to give some fairly accurate predictions as I increased the machine-learning training period (include more historical data). Also the added predictors (stat ratios) really added to the average precision rating of each prediction, giving a quantitative way to demonstrate how much better a player's stats were compared to the league average of that season.

Of course it wasn't able to give 100% accurate results, but with sports and many other things, there is the human factor that is extremely difficult to put into measurable numbers and variables in an easy and consumable way. 

Some context has to be put behind every result. Something that can't be easily quantified are "storylines" that occur during a season that have to be accounted for. Things like a player coming back from an injury to lead his team throughout the season, or struggles within a team where an MVP-caliber player might be the focus and "life" of a team although they might not come out of the season with better results than their competitors. There is also a well-known idea of "voter fatigue" where a player is held in such high regard for so long that their greatness just becomes the norm and expected of them, eventually becoming outshadowed by someone else thats new and also exciting to watch. Also, voters for the MVP race may value certain things over others, such as team success vs personal success or maybe a prioritization of offensive capabilities over defensive capabilities. These are all huge talking points during a season and can heavily effect how an athlete is percieved by the fanbase and media, especially when it comes to MVP voting where subjectivity can play a major role.

All of those factors may sway the decision between two very comparable athletes.

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
    MVP_prediction.ipynb (packages used: scikit-learn)
  
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
  - More Data Visualizations
  
  Credit: All data comes from "www.basketball-reference.com/"
