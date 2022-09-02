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

-- Player Efficiency Rating(PER) sums up all of a player’s positive and negative accomplishments, and returns a per-minute rating of a player’s performance
-- Statistics lack team pace data; PER favors players on a team with a higher pace, although still fairly accurate
ALTER TABLE stats
ADD PER double NULL;
UPDATE stats 
SET PER = (((FG * 85.910)
+ (STL * 53.897)
+ (3P * 51.757)
+ (FT * 46.845)
+ (BLK * 39.190)
+ (ORB * 39.190)
+ (AST * 34.677)
+ (DRB * 14.707)
- (PF * 17.174)
- ((FTA - FT) * 20.091)
- ((FGA - FG) * 39.190)
- (TOV * 53.897))
* (1 / MP));