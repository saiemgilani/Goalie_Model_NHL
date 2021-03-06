USE HOCKEY

declare @thruYear bigint = 2018;

declare @sql nvarchar(max)
while (@thruYear>2006)
begin
set @sql=('
drop table if exists #goalie_stats;
drop table if exists #player_stats;
drop table if exists #shots_with_stats;

select x.*
into #goalie_stats
from (
SELECT 
       [Goalie]
      ,sum([Goalie_GP]) as Goalie_GP
      ,sum([Goalie_GS]) as Goalie_GS
      ,sum([Goalie_W]) as Goalie_W
      ,sum([Goalie_L]) as Goalie_L
      ,sum([Goalie_T_O]) as Goalie_T_O
      ,sum([Goalie_GA]) as Goalie_GA
      ,sum([Goalie_SA]) as Goalie_SA
      ,sum([Goalie_SV]) as Goalie_SV
	  ,cast(isnull(100*sum(cast([Goalie_SV] as decimal(10,3)))/NULLIF(cast(sum([Goalie_SA]) as decimal(10,3)),0),0.0) as decimal(10,3)) as SV_PCT
      ,cast(isnull(100*sum(cast([Goalie_GA] as decimal(10,3)))/NULLIF(cast(sum([MIN]) as decimal(10,3)),0),0.0) as decimal(10,3)) as GAA
      ,sum([SO]) as SO
      ,sum([GPS]) as GPS
      ,sum([MIN]) as [MIN]
      ,sum([QS]) as QS
      ,cast(isnull(100*sum(cast([QS] as decimal(10,3)))/NULLIF(cast(sum([Goalie_GS]) as decimal(10,3)),0),0.0) as decimal(10,3)) as QS_PCT
      ,sum([RBS]) as RBS
      ,avg(cast([GA_PCT] as decimal(10,3))) as GA_PCT
      ,sum([GSAA]) as GSAA
      ,sum([Goalie_G]) as Goalie_G
      ,sum([Goalie_A]) as Goalie_A
      ,sum([Goalie_PTS]) as Goalie_PTS
      ,sum([Goalie_PIM]) as Goalie_PIM
	  
  FROM [Hockey].[dbo].[Goalie_Stats]
  where use_season<= '+cast(@thruYear as varchar(5))+'
  group by goalie) x

select x.*
into #player_stats
from (SELECT 
      [Skater]
      ,sum([Skater_GP]) as Skater_GP
      ,sum([Skater_G]) as Skater_G
      ,sum([Skater_A]) as Skater_Ast
      ,sum([Skater_PTS]) as Skater_Pts
      ,sum([Skater_PM]) as Skater_Plus_Minus
      ,sum([Skater_PIM]) as Skater_Pen_In_Min
      ,sum([Skater_PS]) as Skater_PShares
      ,sum([Skater_EV]) as Skater_EV_G
      ,sum([Special_Teams_PP]) as Special_Teams_PP_G
      ,sum([Special_Teams_SH]) as Special_Teams_SH_G
      ,sum([Skater_GW]) as Skater_GWinners
      ,sum([Assists_EV]) as Assists_EV
      ,sum([Assists_PP]) as Assists_PP
      ,sum([Assists_SH]) as Assists_SH
      ,sum([Skater_Shots]) as Skater_Shots
      ,cast(isnull(100*sum(cast([Skater_G] as decimal(10,3)))/NULLIF(cast(sum([Skater_Shots]) as decimal(10,3)),0),0.0) as decimal(10,3)) as S_Pct
      ,cast(sum([TOI]) as decimal(10,0)) as TOI
      ,FORMAT(cast(DATEADD(SECOND, 60*isnull(cast(sum(TOI) as decimal(10,3))/NULLIF(cast(sum([Skater_GP]) as decimal(10,3)),0),0.0),0) as time(0)),N''mm\:ss'') as ATOI
      ,sum([BLK]) as BLK
      ,sum([HIT]) as HIT
      ,sum([FOW]) as FOW
      ,sum([FOL]) as FOL
      ,cast(isnull(100*cast(sum([FOW]) as decimal(10,3))/NULLIF(cast((sum(FOW)+sum(FOL)) as decimal(10,3)),0),0.0) as decimal(10,3)) as FO_Pct
      ,sum([Adv_GP]) as Adv_GP
      ,sum([Corsi_EV_CF]) as Corsi_EV_CF 
      ,sum([Corsi_EV_CA]) as Corsi_EV_CA
      ,cast(isnull(100*cast(sum([Corsi_EV_CF]) as decimal(10,3))/NULLIF(cast((sum([Corsi_EV_CF])+sum([Corsi_EV_CA])) as decimal(10,3)),0),0.0) as decimal(10,3)) as Corsi_EV_CF_PCT
      ,cast(avg([Corsi_EV_CF_PCT_rel]) as decimal(10,3)) as Corsi_EV_CF_PCT_rel
      ,sum([Fenwick_EV_FF]) as Fenwick_EV_FF
      ,sum([Fenwick_EV_FA]) as Fenwick_EV_FA
      ,cast(isnull(100*cast(sum(Fenwick_EV_FF) as decimal(10,3))/NULLIF(cast((sum(Fenwick_EV_FF)+sum(Fenwick_EV_FA)) as decimal(10,3)),0),0.0) as decimal(10,3)) as Fenwick_EV_FF_PCT
      ,cast(avg([Fenwick_EV_FF_PCT_rel]) as decimal(10,3)) as [Fenwick_EV_FF_PCT_rel]
      ,cast(avg([oiSH_PCT]) as decimal(10,3)) as oiSH_PCT
      ,cast(avg([oiSV_PCT]) as decimal(10,3)) as oiSV_PCT
      ,cast(avg([oiSH_PCT]) + avg([oiSV_PCT]) as decimal(10,3)) as [PDO]
      ,cast(avg([oZS_PCT]) as decimal(10,3)) as oZS_PCT
      ,cast(avg([dZS_PCT]) as decimal(10,3)) as dZS_PCT
      ,cast(avg([TOI_60]) as decimal(10,3)) as TOI_60
      ,cast(avg([TOI_EV]) as decimal(10,3)) as TOI_EV
      ,sum([TK]) as TK
      ,sum([GV]) as GV
      ,cast(isnull(cast(sum(cast([Exp_PM] as decimal(10,3))) as decimal(10,3)),0.0) as decimal(10,3)) as Exp_PM
      ,sum([SAtt]) as SAtt
      ,cast(isnull(cast(avg(cast(SAtt as decimal(10,3)) * cast(Thru_PCT as decimal(10,3))) as decimal(10,3))/NULLIF(cast(sum(SAtt) as decimal(10,3)),0),0.0) as decimal(10,3)) as [Thru_PCT]
  FROM [Hockey].[dbo].[Player_Stats]
  where use_year <= '+cast(@thruYear as varchar(5))+'
  group by [Skater]) x


SELECT a.[shotID]
      ,a.[homeTeamCode]
      ,a.[awayTeamCode]
      ,a.[season]
      ,a.[isPlayoffGame]
      ,a.[game_id]
      ,a.[homeTeamWon]
      ,a.[id]
      ,a.[time]
      ,a.[timeUntilNextEvent]
      ,a.[timeSinceLastEvent]
      ,a.[period]
      ,a.[team]
      ,a.[location]
      ,a.[event]
      ,a.[goal]
      ,a.[shotPlayContinuedOutsideZone]
      ,a.[shotPlayContinuedInZone]
      ,a.[shotGoalieFroze]
      ,a.[shotPlayStopped]
      ,a.[shotGeneratedRebound]
      ,a.[homeTeamGoals]
      ,a.[awayTeamGoals]
      ,a.[xCord]
      ,a.[yCord]
      ,a.[xCordAdjusted]
      ,a.[yCordAdjusted]
      ,a.[shotAngle]
      ,a.[shotAngleAdjusted]
      ,a.[shotAnglePlusRebound]
      ,a.[shotAngleReboundRoyalRoad]
      ,a.[shotDistance]
      ,a.[shotType]
      ,a.[shotOnEmptyNet]
	  ,a.[shotRebound]
      ,a.[shotAnglePlusReboundSpeed]
      ,a.[shotRush]
      ,a.[speedFromLastEvent]
      ,a.[lastEventxCord]
      ,a.[lastEventyCord]
      ,a.[distanceFromLastEvent]
      ,a.[lastEventShotAngle]
      ,a.[lastEventShotDistance]
      ,a.[lastEventCategory]
      ,a.[lastEventTeam]
      ,a.[homeEmptyNet]
      ,a.[awayEmptyNet]
      ,a.[homeSkatersOnIce]
      ,a.[awaySkatersOnIce]
      ,a.[awayPenalty1TimeLeft]
      ,a.[awayPenalty1Length]
      ,a.[homePenalty1TimeLeft]
      ,a.[homePenalty1Length]
      ,a.[playerPositionThatDidEvent]
      ,a.[playerNumThatDidEvent]
      ,a.[playerNumThatDidLastEvent]
      ,a.[lastEventxCord_adjusted]
      ,a.[lastEventyCord_adjusted]
      ,a.[timeSinceFaceoff]
      ,a.[goalieIdForShot]
      ,a.[goalieNameForShot]
      ,a.[shooterPlayerId]
      ,a.[shooterName]
      ,a.[shooterLeftRight]
      ,a.[shooterTimeOnIce]
      ,a.[shooterTimeOnIceSinceFaceoff]
      ,a.[shootingTeamForwardsOnIce]
      ,a.[shootingTeamDefencemenOnIce]
      ,a.[shootingTeamAverageTimeOnIce]
      ,a.[shootingTeamAverageTimeOnIceOfForwards]
      ,a.[shootingTeamAverageTimeOnIceOfDefencemen]
      ,a.[shootingTeamMaxTimeOnIce]
      ,a.[shootingTeamMaxTimeOnIceOfForwards]
      ,a.[shootingTeamMaxTimeOnIceOfDefencemen]
      ,a.[shootingTeamMinTimeOnIce]
      ,a.[shootingTeamMinTimeOnIceOfForwards]
      ,a.[shootingTeamMinTimeOnIceOfDefencemen]
      ,a.[shootingTeamAverageTimeOnIceSinceFaceoff]
      ,a.[shootingTeamAverageTimeOnIceOfForwardsSinceFaceoff]
      ,a.[shootingTeamAverageTimeOnIceOfDefencemenSinceFaceoff]
      ,a.[shootingTeamMaxTimeOnIceSinceFaceoff]
      ,a.[shootingTeamMaxTimeOnIceOfForwardsSinceFaceoff]
      ,a.[shootingTeamMaxTimeOnIceOfDefencemenSinceFaceoff]
      ,a.[shootingTeamMinTimeOnIceSinceFaceoff]
      ,a.[shootingTeamMinTimeOnIceOfForwardsSinceFaceoff]
      ,a.[shootingTeamMinTimeOnIceOfDefencemenSinceFaceoff]
      ,a.[defendingTeamForwardsOnIce]
      ,a.[defendingTeamDefencemenOnIce]
      ,a.[defendingTeamAverageTimeOnIce]
      ,a.[defendingTeamAverageTimeOnIceOfForwards]
      ,a.[defendingTeamAverageTimeOnIceOfDefencemen]
      ,a.[defendingTeamMaxTimeOnIce]
      ,a.[defendingTeamMaxTimeOnIceOfForwards]
      ,a.[defendingTeamMaxTimeOnIceOfDefencemen]
      ,a.[defendingTeamMinTimeOnIce]
      ,a.[defendingTeamMinTimeOnIceOfForwards]
      ,a.[defendingTeamMinTimeOnIceOfDefencemen]
      ,a.[defendingTeamAverageTimeOnIceSinceFaceoff]
      ,a.[defendingTeamAverageTimeOnIceOfForwardsSinceFaceoff]
      ,a.[defendingTeamAverageTimeOnIceOfDefencemenSinceFaceoff]
      ,a.[defendingTeamMaxTimeOnIceSinceFaceoff]
      ,a.[defendingTeamMaxTimeOnIceOfForwardsSinceFaceoff]
      ,a.[defendingTeamMaxTimeOnIceOfDefencemenSinceFaceoff]
      ,a.[defendingTeamMinTimeOnIceSinceFaceoff]
      ,a.[defendingTeamMinTimeOnIceOfForwardsSinceFaceoff]
      ,a.[defendingTeamMinTimeOnIceOfDefencemenSinceFaceoff]
      ,a.[offWing]
      ,a.[arenaAdjustedShotDistance]
      ,a.[arenaAdjustedXCord]
      ,a.[arenaAdjustedYCord]
	  ,a.[arenaAdjustedXCordABS]
      ,a.[arenaAdjustedYCordAbs]
	  ,case when [period] = 1 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 1 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 1 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 1 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 1 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 1 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 2 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 2 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 2 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 2 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 2 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 2 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 3 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 3 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 3 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 3 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 3 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 3 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 4 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 4 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 4 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 4 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 4 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 4 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 5 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 5 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 5 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 5 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 5 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 5 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 6 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 6 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 6 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 6 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 6 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
			when [period] = 6 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedXCord] as decimal(10,2))
		end as oneSdArenaAdjustedXCord
	  ,case when [period] = 1 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 1 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 1 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 1 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 1 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 1 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 2 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 2 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 2 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 2 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 2 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 2 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 3 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 3 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 3 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 3 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 3 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 3 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
		    when [period] = 4 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 4 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 4 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 4 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 4 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 4 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 5 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 5 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 5 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 5 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 5 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 5 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
		    when [period] = 6 and team = ''AWAY'' and [location] = ''HOMEZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 6 and team = ''AWAY'' and [location] = ''Neu. Zone'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 6 and team = ''AWAY'' and [location] = ''AWAYZONE'' 
				then cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 6 and team = ''HOME'' and [location] = ''HOMEZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 6 and team = ''HOME'' and [location] = ''Neu. Zone'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
			when [period] = 6 and team = ''HOME'' and [location] = ''AWAYZONE'' 
				then -cast(a.[arenaAdjustedYCord] as decimal(10,2))
		end as oneSdArenaAdjustedYCord
      ,a.[timeDifferenceSinceChange]
      ,a.[averageRestDifference]
      ,a.[xGoal]
      ,a.[xFroze]
      ,a.[xRebound]
      ,a.[xPlayContinuedInZone]
      ,a.[xPlayContinuedOutsideZone]
      ,a.[xPlayStopped]
      ,a.[xShotWasOnGoal]
      ,a.[isHomeTeam]
      ,a.[shotWasOnGoal]
      ,a.[teamCode]
      
      --,a.[homeTeamID]
      --,a.[awayTeamID]
      --,a.[teamID]
      --,a.[locationID]
      --,a.[eventID]
      --,a.[shotTypeID]
      --,a.[lastEventCategoryID]
      --,a.[lastEventTeamID]
      --,a.[teamCodeID]
      --,a.[playerPositionThatDidEventID]
      --,a.[shooterLeftRightID]
	  ,b.[Skater]
      ,b.[Skater_GP]
      ,b.[Skater_G]
      ,b.[Skater_Ast]
      ,b.[Skater_Pts]
      ,b.[Skater_Plus_Minus]
      ,b.[Skater_Pen_In_Min]
      ,b.[Skater_PShares]
      ,b.[Skater_EV_G]
      ,b.[Special_Teams_PP_G]
      ,b.[Special_Teams_SH_G]
      ,b.[Skater_GWinners]
      ,b.[Assists_EV]
      ,b.[Assists_PP]
      ,b.[Assists_SH]
      ,b.[Skater_Shots]
      ,b.[S_Pct]
      ,b.[TOI]
      ,b.[ATOI]
      ,b.[BLK]
      ,b.[HIT]
      ,b.[FOW]
      ,b.[FOL]
      ,b.[FO_Pct]
      ,b.[Adv_GP]
      ,b.[Corsi_EV_CF]
      ,b.[Corsi_EV_CA]
      ,b.[Corsi_EV_CF_PCT]
      ,b.[Corsi_EV_CF_PCT_rel]
      ,b.[Fenwick_EV_FF]
      ,b.[Fenwick_EV_FA]
      ,b.[Fenwick_EV_FF_PCT]
      ,b.[Fenwick_EV_FF_PCT_rel]
      ,b.[oiSH_PCT]
      ,b.[oiSV_PCT]
      ,b.[PDO]
      ,b.[oZS_PCT]
      ,b.[dZS_PCT]
      ,b.[TOI_60]
      ,b.[TOI_EV]
      ,b.[TK]
      ,b.[GV]
      ,b.[Exp_PM]
      ,b.[SAtt]
      ,b.[Thru_PCT]
      ,c.[Goalie]
      ,c.[Goalie_GP]
      ,c.[Goalie_GS]
      ,c.[Goalie_W]
      ,c.[Goalie_L]
      ,c.[Goalie_T_O]
      ,c.[Goalie_GA]
      ,c.[Goalie_SA]
      ,c.[Goalie_SV]
      ,c.[SV_PCT]
      ,c.[GAA]
      ,c.[SO]
      ,c.[GPS]
      ,c.[MIN]
      ,c.[QS]
      ,c.[QS_PCT]
      ,c.[RBS]
      ,c.[GA_PCT]
      ,c.[GSAA]
      ,c.[Goalie_G]
      ,c.[Goalie_A]
      ,c.[Goalie_PTS]
      ,c.[Goalie_PIM]
  into #shots_with_stats
  FROM [Hockey].[dbo].[shots] a 
  left join #player_stats b
  on a.shooterName = b.skater 
  left join #goalie_stats c
  on a.goalieNameForShot = c.Goalie 
  where a.season = '+cast(@thruYear as varchar(5))+'

  INSERT INTO [dbo].[shots_with_stats]
           ([shotID]
           ,[homeTeamCode]
           ,[awayTeamCode]
           ,[season]
           ,[isPlayoffGame]
           ,[game_id]
           ,[homeTeamWon]
           ,[id]
           ,[time]
           ,[timeUntilNextEvent]
           ,[timeSinceLastEvent]
           ,[period]
           ,[team]
           ,[location]
           ,[event]
           ,[goal]
           ,[shotPlayContinuedOutsideZone]
           ,[shotPlayContinuedInZone]
           ,[shotGoalieFroze]
           ,[shotPlayStopped]
           ,[shotGeneratedRebound]
           ,[homeTeamGoals]
           ,[awayTeamGoals]
           ,[xCord]
           ,[yCord]
           ,[xCordAdjusted]
           ,[yCordAdjusted]
           ,[shotAngle]
           ,[shotAngleAdjusted]
           ,[shotAnglePlusRebound]
           ,[shotAngleReboundRoyalRoad]
           ,[shotDistance]
           ,[shotType]
           ,[shotOnEmptyNet]
           ,[shotRebound]
           ,[shotAnglePlusReboundSpeed]
           ,[shotRush]
           ,[speedFromLastEvent]
           ,[lastEventxCord]
           ,[lastEventyCord]
           ,[distanceFromLastEvent]
           ,[lastEventShotAngle]
           ,[lastEventShotDistance]
           ,[lastEventCategory]
           ,[lastEventTeam]
           ,[homeEmptyNet]
           ,[awayEmptyNet]
           ,[homeSkatersOnIce]
           ,[awaySkatersOnIce]
           ,[awayPenalty1TimeLeft]
           ,[awayPenalty1Length]
           ,[homePenalty1TimeLeft]
           ,[homePenalty1Length]
           ,[playerPositionThatDidEvent]
           ,[playerNumThatDidEvent]
           ,[playerNumThatDidLastEvent]
           ,[lastEventxCord_adjusted]
           ,[lastEventyCord_adjusted]
           ,[timeSinceFaceoff]
           ,[goalieIdForShot]
           ,[goalieNameForShot]
           ,[shooterPlayerId]
           ,[shooterName]
           ,[shooterLeftRight]
           ,[shooterTimeOnIce]
           ,[shooterTimeOnIceSinceFaceoff]
           ,[shootingTeamForwardsOnIce]
           ,[shootingTeamDefencemenOnIce]
           ,[shootingTeamAverageTimeOnIce]
           ,[shootingTeamAverageTimeOnIceOfForwards]
           ,[shootingTeamAverageTimeOnIceOfDefencemen]
           ,[shootingTeamMaxTimeOnIce]
           ,[shootingTeamMaxTimeOnIceOfForwards]
           ,[shootingTeamMaxTimeOnIceOfDefencemen]
           ,[shootingTeamMinTimeOnIce]
           ,[shootingTeamMinTimeOnIceOfForwards]
           ,[shootingTeamMinTimeOnIceOfDefencemen]
           ,[shootingTeamAverageTimeOnIceSinceFaceoff]
           ,[shootingTeamAverageTimeOnIceOfForwardsSinceFaceoff]
           ,[shootingTeamAverageTimeOnIceOfDefencemenSinceFaceoff]
           ,[shootingTeamMaxTimeOnIceSinceFaceoff]
           ,[shootingTeamMaxTimeOnIceOfForwardsSinceFaceoff]
           ,[shootingTeamMaxTimeOnIceOfDefencemenSinceFaceoff]
           ,[shootingTeamMinTimeOnIceSinceFaceoff]
           ,[shootingTeamMinTimeOnIceOfForwardsSinceFaceoff]
           ,[shootingTeamMinTimeOnIceOfDefencemenSinceFaceoff]
           ,[defendingTeamForwardsOnIce]
           ,[defendingTeamDefencemenOnIce]
           ,[defendingTeamAverageTimeOnIce]
           ,[defendingTeamAverageTimeOnIceOfForwards]
           ,[defendingTeamAverageTimeOnIceOfDefencemen]
           ,[defendingTeamMaxTimeOnIce]
           ,[defendingTeamMaxTimeOnIceOfForwards]
           ,[defendingTeamMaxTimeOnIceOfDefencemen]
           ,[defendingTeamMinTimeOnIce]
           ,[defendingTeamMinTimeOnIceOfForwards]
           ,[defendingTeamMinTimeOnIceOfDefencemen]
           ,[defendingTeamAverageTimeOnIceSinceFaceoff]
           ,[defendingTeamAverageTimeOnIceOfForwardsSinceFaceoff]
           ,[defendingTeamAverageTimeOnIceOfDefencemenSinceFaceoff]
           ,[defendingTeamMaxTimeOnIceSinceFaceoff]
           ,[defendingTeamMaxTimeOnIceOfForwardsSinceFaceoff]
           ,[defendingTeamMaxTimeOnIceOfDefencemenSinceFaceoff]
           ,[defendingTeamMinTimeOnIceSinceFaceoff]
           ,[defendingTeamMinTimeOnIceOfForwardsSinceFaceoff]
           ,[defendingTeamMinTimeOnIceOfDefencemenSinceFaceoff]
           ,[offWing]
           ,[arenaAdjustedShotDistance]
           ,[arenaAdjustedXCord]
           ,[arenaAdjustedYCord]
           ,[arenaAdjustedXCordABS]
           ,[arenaAdjustedYCordAbs]
           ,[oneSdArenaAdjustedXCord]
           ,[oneSdArenaAdjustedYCord]
           ,[timeDifferenceSinceChange]
           ,[averageRestDifference]
           ,[xGoal]
           ,[xFroze]
           ,[xRebound]
           ,[xPlayContinuedInZone]
           ,[xPlayContinuedOutsideZone]
           ,[xPlayStopped]
           ,[xShotWasOnGoal]
           ,[isHomeTeam]
           ,[shotWasOnGoal]
           ,[teamCode]
           ,[Skater]
           ,[Skater_GP]
           ,[Skater_G]
           ,[Skater_Ast]
           ,[Skater_Pts]
           ,[Skater_Plus_Minus]
           ,[Skater_Pen_In_Min]
           ,[Skater_PShares]
           ,[Skater_EV_G]
           ,[Special_Teams_PP_G]
           ,[Special_Teams_SH_G]
           ,[Skater_GWinners]
           ,[Assists_EV]
           ,[Assists_PP]
           ,[Assists_SH]
           ,[Skater_Shots]
           ,[S_Pct]
           ,[TOI]
           ,[ATOI]
           ,[BLK]
           ,[HIT]
           ,[FOW]
           ,[FOL]
           ,[FO_Pct]
           ,[Adv_GP]
           ,[Corsi_EV_CF]
           ,[Corsi_EV_CA]
           ,[Corsi_EV_CF_PCT]
           ,[Corsi_EV_CF_PCT_rel]
           ,[Fenwick_EV_FF]
           ,[Fenwick_EV_FA]
           ,[Fenwick_EV_FF_PCT]
           ,[Fenwick_EV_FF_PCT_rel]
           ,[oiSH_PCT]
           ,[oiSV_PCT]
           ,[PDO]
           ,[oZS_PCT]
           ,[dZS_PCT]
           ,[TOI_60]
           ,[TOI_EV]
           ,[TK]
           ,[GV]
           ,[Exp_PM]
           ,[SAtt]
           ,[Thru_PCT]
           ,[Goalie]
           ,[Goalie_GP]
           ,[Goalie_GS]
           ,[Goalie_W]
           ,[Goalie_L]
           ,[Goalie_T_O]
           ,[Goalie_GA]
           ,[Goalie_SA]
           ,[Goalie_SV]
           ,[SV_PCT]
           ,[GAA]
           ,[SO]
           ,[GPS]
           ,[MIN]
           ,[QS]
           ,[QS_PCT]
           ,[RBS]
           ,[GA_PCT]
           ,[GSAA]
           ,[Goalie_G]
           ,[Goalie_A]
           ,[Goalie_PTS]
           ,[Goalie_PIM])
	select * from #shots_with_stats ')


EXEC(@sql)
set @thruYear = @thruYear - 1;
End