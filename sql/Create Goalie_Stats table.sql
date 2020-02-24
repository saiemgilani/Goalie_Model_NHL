USE [Hockey]
GO

/****** Object:  Table [dbo].[Goalie_Stats]    Script Date: 11/9/2019 4:39:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Goalie_Stats](
	[Goalie_Season] [bigint] NULL,
	[Use_Season] [bigint] NULL,
	[Goalie_Rk] [bigint] NULL,
	[Goalie] [varchar](22) NULL,
	[Goalie_Page] [varchar](9) NULL,
	[Goalie_Age] [bigint] NULL,
	[Goalie_Tm] [varchar](3) NULL,
	[Goalie_GP] [bigint] NULL,
	[Goalie_GS] [bigint] NULL,
	[Goalie_W] [bigint] NULL,
	[Goalie_L] [bigint] NULL,
	[Goalie_T_O] [bigint] NULL,
	[Goalie_GA] [bigint] NULL,
	[Goalie_SA] [bigint] NULL,
	[Goalie_SV] [bigint] NULL,
	[SV_PCT] [float] NULL,
	[GAA] [float] NULL,
	[SO] [bigint] NULL,
	[GPS] [float] NULL,
	[MIN] [bigint] NULL,
	[QS] [bigint] NULL,
	[QS_PCT] [float] NULL,
	[RBS] [bigint] NULL,
	[GA_PCT] [bigint] NULL,
	[GSAA] [float] NULL,
	[Goalie_G] [bigint] NULL,
	[Goalie_A] [bigint] NULL,
	[Goalie_PTS] [bigint] NULL,
	[Goalie_PIM] [bigint] NULL
) ON [PRIMARY]
GO


