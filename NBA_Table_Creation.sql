USE nba_data;

CREATE TABLE if not exists stats (
PlayerID    text,
Player      text,
Pos         text,
Age          int,
Tm          text,
G            int,
GS           int,
MP         double,
FG         double,
FGA        double,
`FG%`      double,
3P         double,
3PA        double,
`3P%`      double,
2P         double,
2PA        double,
`2P%`      double,
`eFG%`     double,
FT         double,
FTA        double,
`FT%`      double,
ORB        double,
DRB        double,
TRB        double,
AST        double,
STL        double,
BLK        double,
TOV        double,
PF         double,
PTS        double,
Year         int,
`Pts Won`  double,
`Pts Max`  double,
Share      double,
Team        text,
W            int,
L            int,
`W/L%`     double,
GB         double,
`PS/G`     double,
`PA/G`     double,
SRS        double);

LOAD DATA LOCAL INFILE 'C:/Users/JustinB/PycharmProjects/NBA_Data/NBA_Data.csv'
INTO TABLE stats
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 rows;