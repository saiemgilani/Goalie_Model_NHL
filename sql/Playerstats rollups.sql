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
 
      
