-- ALL STATS FROM 1999-2000 TO 2021-2022 SEASONS

-- Ranks each season's top scorers
WITH PTS_Rank AS(
SELECT Player, Tm, Pos, PTS, `eFG%`, Year,
RANK() OVER (PARTITION BY Year ORDER BY PTS desc) as PTS_Leader
FROM nba_data.stats)
-- Gets every year's top scoring leader
SELECT Player, Tm, Pos, PTS, `eFG%`, Year
FROM PTS_Rank
WHERE PTS_Leader = 1
ORDER BY Year asc;

-- Ranks each season's top 3PT shooters
WITH 3PT_Rank AS(
SELECT Player, Tm, Pos, PTS, 3P, 3PA, `3P%`, Year,
RANK() OVER (PARTITION BY Year ORDER BY 3P desc) as 3PT_Leader
FROM nba_data.stats)
-- Gets every year's top 3PT leader
SELECT Player, Tm, Pos, PTS, 3P, 3PA, `3P%`, Year
FROM 3PT_Rank
WHERE 3PT_Leader = 1
ORDER BY Year asc;

-- Ranks each season's assist leaders
WITH AST_Rank AS(
SELECT Player, Tm, Pos, AST, TOV, Year,
RANK() OVER (PARTITION BY Year ORDER BY AST desc) as AST_Leader
FROM nba_data.stats)
-- Gets every year's top assist leader
SELECT Player, Tm, Pos, AST, TOV, Year
FROM AST_Rank
WHERE AST_Leader = 1
ORDER BY Year asc;

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
 
-- Top 25 player PER ratings
SELECT Player, Tm, Pos, PER, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year
FROM nba_data.stats
WHERE MP > 20 -- Filter outlier PER calculations from production in low minutes (low sample size)
ORDER BY PER desc
LIMIT 25;

-- Ranks each season's top PER leaders
WITH PER_Rank AS(
SELECT Player, Tm, Pos, PER, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year,
RANK() OVER (PARTITION BY Year ORDER BY PER desc) as PER_Leader
FROM nba_data.stats
WHERE MP > 20)
-- Top PER leader for each year
SELECT Player, Tm, Pos, PER, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year
FROM PER_Rank
WHERE PER_Leader = 1
ORDER BY Year asc;

-- Simple Rating System(SRS) shows the average margin of victory for a team
-- Top 10 most dominant teams of the past 20 years
SELECT  Team, W, L, `W/L%`, `PS/G`, `PA/G`, SRS, Year
FROM stats
GROUP BY SRS
ORDER BY SRS desc
LIMIT 10;

-- Top 10 worst teams of the past 20 years
SELECT  Team, W, L, `W/L%`, `PS/G`, `PA/G`, SRS, Year
FROM stats
GROUP BY SRS
ORDER BY SRS asc
LIMIT 10;