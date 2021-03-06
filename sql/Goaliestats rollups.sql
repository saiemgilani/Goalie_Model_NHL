USE HOCKEY

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
  where use_season<2012
  group by goalie