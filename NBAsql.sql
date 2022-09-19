-- ALL STATS FROM 1999-2000 TO 2021-2022 SEASONS

-- Top 25 Scorers
SELECT Player, Tm, Pos, PTS, FG, FGA, FT, FTA, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year
FROM nba_data.stats
ORDER BY PTS desc
LIMIT 25;

-- Ranks each season's top scorers
WITH PTS_Rank AS(
SELECT Player, Tm, Pos, PTS, FG, FGA, FT, FTA, `eFG%`, Year,
RANK() OVER (PARTITION BY Year ORDER BY PTS desc) as PTS_Leader
FROM nba_data.stats)
-- Gets every year's top scoring leader
SELECT Player, Tm, Pos, PTS, FG, FGA, FT, FTA, `eFG%`, Year
FROM PTS_Rank
WHERE PTS_Leader = 1
ORDER BY Year asc;

-- Top 25 3PT shooters
SELECT Player, Tm, Pos, PTS, 3P, 3PA, `3P%`, Year
FROM nba_data.stats
ORDER BY 3P desc
LIMIT 25;

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

-- Top 25 passers
SELECT Player, Tm, Pos, AST, TOV, Year
FROM nba_data.stats
ORDER BY AST desc
LIMIT 25;

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

-- Top 25 rebounders
SELECT Player, Tm, Pos, TRB, DRB, ORB, Year
FROM nba_data.stats
ORDER BY TRB desc
LIMIT 25;

-- Ranks each season's top rebounders
WITH REB_Rank AS(
SELECT Player, Tm, Pos, TRB, DRB, ORB, Year,
RANK() OVER (PARTITION BY Year ORDER BY TRB desc) as REB_Leader
FROM nba_data.stats)
-- Gets every year's top rebound leader
SELECT Player, Tm, Pos, TRB, DRB, ORB, Year
FROM REB_Rank
WHERE REB_Leader = 1
ORDER BY Year asc;

-- Ranks each season's top steal leaders
WITH STL_Rank AS(
SELECT Player, Tm, Pos, STL, Year,
RANK() OVER (PARTITION BY Year ORDER BY STL desc) as STL_Leader
FROM nba_data.stats)
-- Gets every year's top steal leader
SELECT Player, Tm, Pos, STL, Year
FROM STL_Rank
WHERE STL_Leader = 1
ORDER BY Year asc;

-- Ranks each season's top block leaders
WITH BLK_Rank AS(
SELECT Player, Tm, Pos, BLK, Year,
RANK() OVER (PARTITION BY Year ORDER BY BLK desc) as BLK_Leader
FROM nba_data.stats)
-- Gets every year's top steal leader
SELECT Player, Tm, Pos, BLK, Year
FROM BLK_Rank
WHERE BLK_Leader = 1
ORDER BY Year asc;

-- Player Efficiency Rating(PER) sums up all of a player’s positive and negative accomplishments, and returns a per-minute rating of a player’s performance
-- Statistics lack team pace data; PER favors players on a team with a higher pace, although still fairly accurate

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

-- Players who averaged a Triple-Double for the entire season
SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year
FROM nba_data.stats
WHERE PTS > 10 and AST > 10 and TRB > 10
ORDER BY Year asc;

-- Ranks each season's top MVP vote getters
WITH MVP_Rank AS(
SELECT Player, Tm, Pos, PER, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, `W/L%`, Share, Year,
RANK() OVER (PARTITION BY Year ORDER BY Share desc) as MVP_Leader
FROM nba_data.stats
WHERE MP > 20)
-- MVP winner for each year
SELECT Player, Tm, Pos, PER, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, `W/L%`, Year
FROM MVP_Rank
WHERE MVP_Leader = 1
ORDER BY Year asc;


-- Simple Rating System(SRS) shows the average margin of victory for a team
-- Top 10 most dominant teams of the past 20 years
SELECT  Team, W, L, `W/L%`, `PS/G`, `PA/G`, SRS, Year
FROM stats
GROUP BY SRS
ORDER BY SRS desc
LIMIT 10;

-- Top 10 winningest teams of the past 20 years
SELECT  Team, W, L, `W/L%`, `PS/G`, `PA/G`, SRS, Year
FROM stats
GROUP BY SRS
ORDER BY `W/L%` desc
LIMIT 10;

-- Top 10 worst teams of the past 20 years
SELECT  Team, W, L, `W/L%`, `PS/G`, `PA/G`, SRS, Year
FROM stats
GROUP BY SRS
ORDER BY `W/L%` asc
LIMIT 10;

-- Top 10 PTS Leaders for each team
SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year, PTS_Leader
FROM (
	SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year,
	RANK() OVER (PARTITION BY Tm ORDER BY Pts desc) as PTS_Leader
	FROM nba_data.stats
    ) as PTS
WHERE PTS_Leader <= 10;

-- Top 10 AST Leaders for each team
SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year, AST_Leader
FROM (
	SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year,
	RANK() OVER (PARTITION BY Tm ORDER BY AST desc) as AST_Leader
	FROM nba_data.stats
    ) as AST
WHERE AST_Leader <= 10;

-- Top 10 TRB Leaders for each team
SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year, TRB_Leader
FROM (
	SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year,
	RANK() OVER (PARTITION BY Tm ORDER BY TRB desc) as TRB_Leader
	FROM nba_data.stats
    ) as TRB
WHERE TRB_Leader <= 10;

-- Top 10 BLK Leaders for each team
SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year, BLK_Leader
FROM (
	SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year,
	RANK() OVER (PARTITION BY Tm ORDER BY BLK desc) as BLK_Leader
	FROM nba_data.stats
    ) as BLK
WHERE BLK_Leader <= 10;

-- Top 10 STL Leaders for each team
SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year, STL_Leader
FROM (
	SELECT Player, Tm, Pos, PTS, `eFG%`, AST, TRB, BLK, STL, TOV, PF, MP, Year,
	RANK() OVER (PARTITION BY Tm ORDER BY STL desc) as STL_Leader
	FROM nba_data.stats
    ) as STL
WHERE STL_Leader <= 10;