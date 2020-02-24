USE [Hockey]
GO

/****** Object:  Table [dbo].[Player_Stats]    Script Date: 11/9/2019 7:27:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Player_Stats](
	[Player_Year] [bigint] NULL,
	[Use_Year] [bigint] NULL,
	[Player_Rk] [bigint] NULL,
	[Skater] [varchar](29) NULL,
	[Skater_Age] [bigint] NULL,
	[Skater_Tm] [varchar](3) NULL,
	[Skater_Pos] [varchar](2) NULL,
	[Skater_GP] [bigint] NULL,
	[Skater_G] [bigint] NULL,
	[Skater_A] [bigint] NULL,
	[Skater_PTS] [bigint] NULL,
	[Skater_PM] [bigint] NULL,
	[Skater_PIM] [bigint] NULL,
	[Skater_PS] [float] NULL,
	[Skater_EV] [bigint] NULL,
	[Special_Teams_PP] [bigint] NULL,
	[Special_Teams_SH] [bigint] NULL,
	[Skater_GW] [bigint] NULL,
	[Assists_EV] [bigint] NULL,
	[Assists_PP] [bigint] NULL,
	[Assists_SH] [bigint] NULL,
	[Skater_Shots] [bigint] NULL,
	[S_Pct] [float] NULL,
	[TOI] [bigint] NULL,
	[ATOI] [time](0) NULL,
	[BLK] [bigint] NULL,
	[HIT] [bigint] NULL,
	[FOW] [bigint] NULL,
	[FOL] [bigint] NULL,
	[FO_Pct] [float] NULL,
	[Adv_GP] [bigint] NULL,
	[Corsi_EV_CF] [bigint] NULL,
	[Corsi_EV_CA] [bigint] NULL,
	[Corsi_EV_CF%] [float] NULL,
	[Corsi_EV_CF_PCT_rel] [float] NULL,
	[Fenwick_EV_FF] [bigint] NULL,
	[Fenwick_EV_FA] [bigint] NULL,
	[Fenwick_EV_FF_PCT] [float] NULL,
	[Fenwick_EV_FF_PCT_rel] [float] NULL,
	[oiSH_PCT] [float] NULL,
	[oiSV_PCT] [float] NULL,
	[PDO] [float] NULL,
	[oZS_PCT] [float] NULL,
	[dZS_PCT] [float] NULL,
	[TOI_60] [float] NULL,
	[TOI_EV] [float] NULL,
	[TK] [bigint] NULL,
	[GV] [bigint] NULL,
	[Exp_PM] [decimal](10, 3) NULL,
	[SAtt] [bigint] NULL,
	[Thru_PCT] [float] NULL,
	[Player_and_Page] [varchar](39) NULL,
	[Player_Page] [varchar](9) NULL
) ON [PRIMARY]
GO


