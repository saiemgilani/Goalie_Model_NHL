USE HOCKEY

SELECT 
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
      ,FORMAT(cast(DATEADD(SECOND, 60*isnull(cast(sum(TOI) as decimal(10,3))/NULLIF(cast(sum([Skater_GP]) as decimal(10,3)),0),0.0),0) as time(0)),N'mm\:ss') as ATOI
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
      ,cast(isnull(100*cast(sum(cast([Exp_PM] as decimal(10,3))) as decimal(10,3)),0.0) as decimal(10,3)) as Exp_PM
      ,sum([SAtt]) as SAtt
      ,cast(isnull(cast(avg(cast(SAtt as decimal(10,3)) * cast(Thru_PCT as decimal(10,3))) as decimal(10,3))/NULLIF(cast(sum(SAtt) as decimal(10,3)),0),0.0) as decimal(10,3)) as [Thru_PCT]
	  
  FROM [Hockey].[dbo].[Player_Stats]
  where use_year < 2011
  group by 
     [Skater]
 

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
  where use_season<2018
  group by goalie