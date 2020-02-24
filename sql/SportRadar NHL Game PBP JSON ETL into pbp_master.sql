USE Hockey
declare @i int = 0
declare @pbpjson nvarchar(max)
declare @sql varchar(max)
while (@i<1275)
begin
set @sql=('
				DROP TABLE IF EXISTS dbo.#json_1;
				DROP TABLE IF EXISTS dbo.#json_2;
				CREATE TABLE #json_1 (
									PBPJSON NVARCHAR(MAX) 
				) 
				

				 Insert INTO #json_1 (PBPJSON)
				 SELECT  bulkcolumn
				from openrowset (Bulk ''C:\Users\saiem\Documents\GT Analytics Courses\_Data Visualization and Analytics - CSE6242\Saiem\Project-NHL-Shooting\PBP_JSON_DATA\2018\pbp_2018_'+ cast(@i as varchar(5)) +'.json'',Single_Clob) as j;
				
				DROP TABLE IF EXISTS dbo.#json_2;


select		   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team''),''$.name'') as on_ice_home_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team''),''$.market'') as on_ice_home_market,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team''),''$.id'') as on_ice_home_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team''),''$.sr_id'') as on_ice_home_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team''),''$.reference'') as on_ice_home_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[0]''),''$.full_name'') as home_player0_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[0]''),''$.jersey_number'') as home_player0_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[0]''),''$.position'') as home_player0_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[0]''),''$.primary_position'') as home_player0_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[0]''),''$.id'') as home_player0_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[0]''),''$.sr_id'') as home_player0_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[0]''),''$.reference'') as home_player0_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[1]''),''$.full_name'') as home_player1_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[1]''),''$.jersey_number'') as home_player1_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[1]''),''$.position'') as home_player1_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[1]''),''$.primary_position'') as home_player1_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[1]''),''$.id'') as home_player1_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[1]''),''$.sr_id'') as home_player1_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[1]''),''$.reference'') as home_player1_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[2]''),''$.full_name'') as home_player2_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[2]''),''$.jersey_number'') as home_player2_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[2]''),''$.position'') as home_player2_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[2]''),''$.primary_position'') as home_player2_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[2]''),''$.id'') as home_player2_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[2]''),''$.sr_id'') as home_player2_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[2]''),''$.reference'') as home_player2_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[3]''),''$.full_name'') as home_player3_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[3]''),''$.jersey_number'') as home_player3_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[3]''),''$.position'') as home_player3_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[3]''),''$.primary_position'') as home_player3_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[3]''),''$.id'') as home_player3_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[3]''),''$.sr_id'') as home_player3_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[3]''),''$.reference'') as home_player3_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[4]''),''$.full_name'') as home_player4_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[4]''),''$.jersey_number'') as home_player4_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[4]''),''$.position'') as home_player4_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[4]''),''$.primary_position'') as home_player4_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[4]''),''$.id'') as home_player4_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[4]''),''$.sr_id'') as home_player4_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[4]''),''$.reference'') as home_player4_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[5]''),''$.full_name'') as home_player5_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[5]''),''$.jersey_number'') as home_player5_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[5]''),''$.position'') as home_player5_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[5]''),''$.primary_position'') as home_player5_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[5]''),''$.id'') as home_player5_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[5]''),''$.sr_id'') as home_player5_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[0].team.players[5]''),''$.reference'') as home_player5_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team''),''$.name'') as on_ice_away_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team''),''$.market'') as on_ice_away_market,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team''),''$.id'') as on_ice_away_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team''),''$.sr_id'') as on_ice_away_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team''),''$.reference'') as on_ice_away_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[0]''),''$.full_name'') as away_player0_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[0]''),''$.jersey_number'') as away_player0_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[0]''),''$.position'') as away_player0_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[0]''),''$.primary_position'') as away_player0_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[0]''),''$.id'') as away_player0_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[0]''),''$.sr_id'') as away_player0_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[0]''),''$.reference'') as away_player0_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[1]''),''$.full_name'') as away_player1_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[1]''),''$.jersey_number'') as away_player1_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[1]''),''$.position'') as away_player1_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[1]''),''$.primary_position'') as away_player1_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[1]''),''$.id'') as away_player1_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[1]''),''$.sr_id'') as away_player1_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[1]''),''$.reference'') as away_player1_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[2]''),''$.full_name'') as away_player2_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[2]''),''$.jersey_number'') as away_player2_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[2]''),''$.position'') as away_player2_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[2]''),''$.primary_position'') as away_player2_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[2]''),''$.id'') as away_player2_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[2]''),''$.sr_id'') as away_player2_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[2]''),''$.reference'') as away_player2_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[3]''),''$.full_name'') as away_player3_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[3]''),''$.jersey_number'') as away_player3_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[3]''),''$.position'') as away_player3_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[3]''),''$.primary_position'') as away_player3_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[3]''),''$.id'') as away_player3_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[3]''),''$.sr_id'') as away_player3_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[3]''),''$.reference'') as away_player3_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[4]''),''$.full_name'') as away_player4_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[4]''),''$.jersey_number'') as away_player4_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[4]''),''$.position'') as away_player4_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[4]''),''$.primary_position'') as away_player4_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[4]''),''$.id'') as away_player4_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[4]''),''$.sr_id'') as away_player4_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[4]''),''$.reference'') as away_player4_reference,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[5]''),''$.full_name'') as away_player5_name,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[5]''),''$.jersey_number'') as away_player5_no,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[5]''),''$.position'') as away_player5_position,

			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[5]''),''$.primary_position'') as away_player5_primary_position,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[5]''),''$.id'') as away_player5_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[5]''),''$.sr_id'') as away_player5_sr_id,
			   JSON_VALUE(JSON_Query([events].[on_ice],''$[1].team.players[5]''),''$.reference'') as away_player5_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team''),''$.name'') as in_penalty_penalty0_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team''),''$.market'') as in_penalty_penalty0_market,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team''),''$.id'') as in_penalty_penalty0_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team''),''$.sr_id'') as in_penalty_penalty0_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team''),''$.reference'') as in_penalty_penalty0_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[0]''),''$.full_name'') as penalty0_player0_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[0]''),''$.jersey_number'') as penalty0_player0_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[0]''),''$.position'') as penalty0_player0_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[0]''),''$.primary_position'') as penalty0_player0_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[0]''),''$.id'') as penalty0_player0_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[0]''),''$.sr_id'') as penalty0_player0_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[0]''),''$.reference'') as penalty0_player0_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[1]''),''$.full_name'') as penalty0_player1_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[1]''),''$.jersey_number'') as penalty0_player1_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[1]''),''$.position'') as penalty0_player1_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[1]''),''$.primary_position'') as penalty0_player1_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[1]''),''$.id'') as penalty0_player1_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[1]''),''$.sr_id'') as penalty0_player1_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[1]''),''$.reference'') as penalty0_player1_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[2]''),''$.full_name'') as penalty0_player2_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[2]''),''$.jersey_number'') as penalty0_player2_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[2]''),''$.position'') as penalty0_player2_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[2]''),''$.primary_position'') as penalty0_player2_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[2]''),''$.id'') as penalty0_player2_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[2]''),''$.sr_id'') as penalty0_player2_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[2]''),''$.reference'') as penalty0_player2_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[3]''),''$.full_name'') as penalty0_player3_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[3]''),''$.jersey_number'') as penalty0_player3_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[3]''),''$.position'') as penalty0_player3_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[3]''),''$.primary_position'') as penalty0_player3_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[3]''),''$.id'') as penalty0_player3_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[3]''),''$.sr_id'') as penalty0_player3_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[3]''),''$.reference'') as penalty0_player3_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[4]''),''$.full_name'') as penalty0_player4_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[4]''),''$.jersey_number'') as penalty0_player4_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[4]''),''$.position'') as penalty0_player4_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[4]''),''$.primary_position'') as penalty0_player4_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[4]''),''$.id'') as penalty0_player4_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[4]''),''$.sr_id'') as penalty0_player4_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[4]''),''$.reference'') as penalty0_player4_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[5]''),''$.full_name'') as penalty0_player5_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[5]''),''$.jersey_number'') as penalty0_player5_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[5]''),''$.position'') as penalty0_player5_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[5]''),''$.primary_position'') as penalty0_player5_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[5]''),''$.id'') as penalty0_player5_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[5]''),''$.sr_id'') as penalty0_player5_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[0].team.players[5]''),''$.reference'') as penalty0_player5_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team''),''$.name'') as in_penalty_penalty1_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team''),''$.market'') as in_penalty_penalty1_market,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team''),''$.id'') as in_penalty_penalty1_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team''),''$.sr_id'') as in_penalty_penalty1_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team''),''$.reference'') as in_penalty_penalty1_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[0]''),''$.full_name'') as penalty1_player0_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[0]''),''$.jersey_number'') as penalty1_player0_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[0]''),''$.position'') as penalty1_player0_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[0]''),''$.primary_position'') as penalty1_player0_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[0]''),''$.id'') as penalty1_player0_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[0]''),''$.sr_id'') as penalty1_player0_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[0]''),''$.reference'') as penalty1_player0_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[1]''),''$.full_name'') as penalty1_player1_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[1]''),''$.jersey_number'') as penalty1_player1_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[1]''),''$.position'') as penalty1_player1_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[1]''),''$.primary_position'') as penalty1_player1_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[1]''),''$.id'') as penalty1_player1_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[1]''),''$.sr_id'') as penalty1_player1_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[1]''),''$.reference'') as penalty1_player1_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[2]''),''$.full_name'') as penalty1_player2_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[2]''),''$.jersey_number'') as penalty1_player2_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[2]''),''$.position'') as penalty1_player2_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[2]''),''$.primary_position'') as penalty1_player2_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[2]''),''$.id'') as penalty1_player2_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[2]''),''$.sr_id'') as penalty1_player2_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[2]''),''$.reference'') as penalty1_player2_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[3]''),''$.full_name'') as penalty1_player3_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[3]''),''$.jersey_number'') as penalty1_player3_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[3]''),''$.position'') as penalty1_player3_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[3]''),''$.primary_position'') as penalty1_player3_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[3]''),''$.id'') as penalty1_player3_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[3]''),''$.sr_id'') as penalty1_player3_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[3]''),''$.reference'') as penalty1_player3_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[4]''),''$.full_name'') as penalty1_player4_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[4]''),''$.jersey_number'') as penalty1_player4_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[4]''),''$.position'') as penalty1_player4_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[4]''),''$.primary_position'') as penalty1_player4_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[4]''),''$.id'') as penalty1_player4_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[4]''),''$.sr_id'') as penalty1_player4_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[4]''),''$.reference'') as penalty1_player4_reference,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[5]''),''$.full_name'') as penalty1_player5_name,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[5]''),''$.jersey_number'') as penalty1_player5_no,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[5]''),''$.position'') as penalty1_player5_position,

			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[5]''),''$.primary_position'') as penalty1_player5_primary_position,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[5]''),''$.id'') as penalty1_player5_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[5]''),''$.sr_id'') as penalty1_player5_sr_id,
			   JSON_VALUE(JSON_Query([events].[in_penalty],''$[1].team.players[5]''),''$.reference'') as penalty1_player5_reference,
			   [boxscore].id as gameid,
			   [boxscore].sr_id as gamesr_id,
			   [boxscore].[status] as status,
			   [boxscore].coverage as coverage,
			   [boxscore].scheduled as scheduled,
			   [boxscore].start_time as start_time,
			   [boxscore].end_time as end_time,
			   [boxscore].attendance as attendance,
			   [boxscore].total_game_duration as total_game_duration,
			   [boxscore].[period] as current_period,
			   [boxscore].[clock] as time_left,
			   [boxscore].entry_mode as entry_mode,
			   [boxscore].reference as reference,
			   
			   [home].[market] as home_market,
			   [home].[name] as home_name,
			   [home].[sr_id] as home_sr_id,
			   [home].[id] as home_id,
			   [home].[points] as home_points,
			   [home].[strength] as home_cur_strength,
			   [home].[reference] as home_reference,
			   [away].[market] as away_market,
			   [away].[name] as away_name,
			   [away].[sr_id] as away_sr_id,
			   [away].[id] as away_id,
			   [away].[points] as away_points,
			   [away].[strength] as away_cur_strength,
			   [away].[reference] as away_reference,
			   [periods].[type] as pd_type,
			   [periods].[id] as pd_id,
			   [periods].[number] as pd_no,
			   [periods].[sequence] as pd_seq,
			   [home_scoring].[market] as hm_market,
			   [home_scoring].[name] as hm_name,
			   [home_scoring].[id] as hm_id,
			   [home_scoring].[points] as pd_hm_points,
			   [home_scoring].[reference] as hm_reference,
			   [away_scoring].[market] as aw_market,
			   [away_scoring].[name] as aw_name,
			   [away_scoring].[id] as aw_id,
			   [away_scoring].[points] as pd_aw_points,
			   [away_scoring].[reference] as aw_reference,
			   [events].[id] as events_id,
			   [events].[official] as events_official,
			   [events].[clock] as events_clock,
			   [events].[description] as events_description,
			   [events].[event_type] as events_type,
			   [events].[stoppage_type] as stoppage_type,
			   [events].[strength] as events_strength,
			   [events].[updated] as events_updated,
			   [events].[wall_clock] as wall_clock,
			   [events].[players[0]].full_name] as events_participant0,
			   [events].[players[0]].jersey_number] as events_participant0_jersey_number,
			   [events].[players[0]].id] as events_participant0_id,
			   [events].[players[0]].sr_id] as events_participant0_sr_id,
			   [events].[players[0]].reference] as events_participant0_reference,
			   [events].[players[1]].full_name] as events_participant1,
			   [events].[players[1]].jersey_number] as events_participant1_jersey_number,
			   [events].[players[1]].id] as events_participant1_id,
			   [events].[players[1]].sr_id] as events_participant1_sr_id,
			   [events].[players[1]].reference] as events_participant1_reference,
			   [events].[players[2]].full_name] as events_participant2,
			   [events].[players[2]].jersey_number] as events_participant2_jersey_number,
			   [events].[players[2]].id] as events_participant2_id,
			   [events].[players[2]].sr_id] as events_participant2_sr_id,
			   [events].[players[2]].reference] as events_participant2_reference,		
			   [events].[players[3]].full_name] as events_participant3,
			   [events].[players[3]].jersey_number] as events_participant3_jersey_number,
			   [events].[players[3]].id] as events_participant3_id,
			   [events].[players[3]].sr_id] as events_participant3_sr_id,
			   [events].[players[3]].reference] as events_participant3_reference,	
			   [events].[players[4]].full_name] as events_participant4,
			   [events].[players[4]].jersey_number] as events_participant4_jersey_number,
			   [events].[players[4]].id] as events_participant4_id,
			   [events].[players[4]].sr_id] as events_participant4_sr_id,
			   [events].[players[4]].reference] as events_participant4_reference,			  
			   [events].[players[5]].full_name] as events_participant5,
			   [events].[players[5]].jersey_number] as events_participant5_jersey_number,
			   [events].[players[5]].id] as events_participant5_id,
			   [events].[players[5]].sr_id] as events_participant5_sr_id,
			   [events].[players[5]].reference] as events_participant5_reference,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0]''),''$.type'') as stat_type_0,
--			   [statistics].[type] as stat_type,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0]''),''$.strength'') as stat_strength_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0]''),''$.zone'') as stat_zone_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0]''),''$.saved'') as saved_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0]''),''$.win'') as faceoff_win_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0]''),''$.goal'') as stat_goal_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0]''),''$.severity'') as penalty_severity_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0]''),''$.minutes'') as penalty_minutes_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].team''),''$.name'') as stat_team_name_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].team''),''$.market'') as stat_team_market_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].team''),''$.id'') as stat_team_id_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].team''),''$.sr_id'') as stat_team_sr_id_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].team''),''$.reference'') as stat_team_reference_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].player''),''$.full_name'') as stat_player_name_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].player''),''$.jersey_number'') as stat_player_num_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].player''),''$.id'') as stat_player_id_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].player''),''$.sr_id'') as stat_player_sr_id_0,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[0].player''),''$.reference'') as stat_player_reference_0,

			   JSON_VALUE(JSON_Query([events].[statistics],''$[1]''),''$.type'') as stat_type_1,
--			   [statistics].[type] as stat_type,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1]''),''$.strength'') as stat_strength_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1]''),''$.zone'') as stat_zone_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1]''),''$.saved'') as saved_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1]''),''$.win'') as faceoff_win_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1]''),''$.goal'') as stat_goal_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1]''),''$.severity'') as penalty_severity_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1]''),''$.minutes'') as penalty_minutes_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].team''),''$.name'') as stat_team_name_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].team''),''$.market'') as stat_team_market_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].team''),''$.id'') as stat_team_id_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].team''),''$.sr_id'') as stat_team_sr_id_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].team''),''$.reference'') as stat_team_reference_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].player''),''$.full_name'') as stat_player_name_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].player''),''$.jersey_number'') as stat_player_num_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].player''),''$.id'') as stat_player_id_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].player''),''$.sr_id'') as stat_player_sr_id_1,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[1].player''),''$.reference'') as stat_player_reference_1,

			   JSON_VALUE(JSON_Query([events].[statistics],''$[2]''),''$.type'') as stat_type_2,
--			   [statistics].[type] as stat_type,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2]''),''$.strength'') as stat_strength_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2]''),''$.zone'') as stat_zone_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2]''),''$.saved'') as saved_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2]''),''$.win'') as faceoff_win_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2]''),''$.goal'') as stat_goal_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2]''),''$.severity'') as penalty_severity_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2]''),''$.minutes'') as penalty_minutes_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].team''),''$.name'') as stat_team_name_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].team''),''$.market'') as stat_team_market_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].team''),''$.id'') as stat_team_id_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].team''),''$.sr_id'') as stat_team_sr_id_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].team''),''$.reference'') as stat_team_reference_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].player''),''$.full_name'') as stat_player_name_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].player''),''$.jersey_number'') as stat_player_num_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].player''),''$.id'') as stat_player_id_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].player''),''$.sr_id'') as stat_player_sr_id_2,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[2].player''),''$.reference'') as stat_player_reference_2,

			   JSON_VALUE(JSON_Query([events].[statistics],''$[3]''),''$.type'') as stat_type_3,
--			   [statistics].[type] as stat_type,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3]''),''$.strength'') as stat_strength_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3]''),''$.zone'') as stat_zone_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3]''),''$.saved'') as saved_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3]''),''$.win'') as faceoff_win_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3]''),''$.goal'') as stat_goal_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3]''),''$.severity'') as penalty_severity_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3]''),''$.minutes'') as penalty_minutes_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].team''),''$.name'') as stat_team_name_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].team''),''$.market'') as stat_team_market_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].team''),''$.id'') as stat_team_id_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].team''),''$.sr_id'') as stat_team_sr_id_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].team''),''$.reference'') as stat_team_reference_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].player''),''$.full_name'') as stat_player_name_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].player''),''$.jersey_number'') as stat_player_num_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].player''),''$.id'') as stat_player_id_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].player''),''$.sr_id'') as stat_player_sr_id_3,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[3].player''),''$.reference'') as stat_player_reference_3,

			   JSON_VALUE(JSON_Query([events].[statistics],''$[4]''),''$.type'') as stat_type_4,
--			   [statistics].[type] as stat_type,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4]''),''$.strength'') as stat_strength_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4]''),''$.zone'') as stat_zone_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4]''),''$.saved'') as saved_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4]''),''$.win'') as faceoff_win_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4]''),''$.goal'') as stat_goal_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4]''),''$.severity'') as penalty_severity_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4]''),''$.minutes'') as penalty_minutes_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].team''),''$.name'') as stat_team_name_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].team''),''$.market'') as stat_team_market_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].team''),''$.id'') as stat_team_id_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].team''),''$.sr_id'') as stat_team_sr_id_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].team''),''$.reference'') as stat_team_reference_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].player''),''$.full_name'') as stat_player_name_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].player''),''$.jersey_number'') as stat_player_num_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].player''),''$.id'') as stat_player_id_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].player''),''$.sr_id'') as stat_player_sr_id_4,
			   JSON_VALUE(JSON_Query([events].[statistics],''$[4].player''),''$.reference'') as stat_player_reference_4,

			   [attribution].[name] as attr_name,
			   [attribution].[market] as attr_market,
			   [attribution].[team_goal] as attr_goal_side,
			   [attribution].[id] as attr_id,
			   [attribution].[sr_id] as attr_sr_id,
			   [attribution].[reference] as attr_reference,
			   [location].[coord_x],
			   [location].[coord_y],
			   [location].[action_area],
			   [details].[shot_type] as shot_type,
			   [details].[distance] as distance,
			   [details].[stoppage_type] as stoppage_type_detail,
			   [details].[goal_zone] as goal_zone,
			   [details].[penalty_code] as penalty_code,
			   [details].[duration] as duration,
			   [details].[penalty_type] as penalty_type,
			   [details].[reason] as reason,
			   ''pbp_2018_'+ cast(@i as varchar(5)) +''' as file_name
			   into #json_2
		from #json_1
		outer apply openjson(pbpjson,''$'') with(
				 [id] NVARCHAR(36) ,
				 [status] NVARCHAR(6) ,
				 [coverage] NVARCHAR(4),
				 [scheduled] NVARCHAR(25),
				 [start_time] NVARCHAR(25),
				 [end_time] NVARCHAR(25),
				 [attendance] INT,
				 [clock] NVARCHAR(5),
				 [total_game_duration] NVARCHAR(25),
				 [period] INT,
				 [sr_id] NVARCHAR(25),
				 [reference] INT,
				 [entry_mode] NVARCHAR(6),
				 [home] NVARCHAR(MAX) as json,
				 [away] NVARCHAR(MAX) as json,
				 [periods] NVARCHAR(MAX) as json,
				 [deleted_events] NVARCHAR(MAX) as json)		as [boxscore]
		outer apply openjson([boxscore].[home]) with(
				[market] NVARCHAR(MAX),
				[name] NVARCHAR(MAX),
				[points] INT,
				[strength] NVARCHAR(MAX),
				[id] NVARCHAR(MAX),
				[sr_id] NVARCHAR(MAX),
				[reference] NVARCHAR(MAX))						as [home]
		outer apply openjson([boxscore].[away])with(
				[market] NVARCHAR(MAX),
				[name] NVARCHAR(MAX),
				[points] INT,
				[strength] NVARCHAR(MAX),
				[id] NVARCHAR(MAX),
				[sr_id] NVARCHAR(MAX),
				[reference] NVARCHAR(MAX))						as [away]
		outer apply openjson([boxscore].[periods]) with(
				[type] NVARCHAR(MAX),
				[id] NVARCHAR(MAX),
				[number] INT,
				[sequence] INT,
				[scoring] NVARCHAR(MAX) as JSON,
				[events] NVARCHAR(MAX) as JSON)					as [periods]
		outer apply openjson([periods].[scoring]) with(
				[home] NVARCHAR(MAX) as JSON,
				[away] NVARCHAR(MAX) as JSON)					as [scoring]
		outer apply openjson([scoring].[home]) with(
				[market] NVARCHAR(MAX),
				[name] NVARCHAR(MAX),
				[id] NVARCHAR(MAX),
				[points] INT,
				[reference] NVARCHAR(MAX))						as [home_scoring]
		outer apply openjson([scoring].[away]) with(
				[market] NVARCHAR(MAX),
				[name] NVARCHAR(MAX),
				[id] NVARCHAR(MAX),
				[points] INT,
				[reference] NVARCHAR(MAX))						as [away_scoring]
		outer APPLY OPENJSON([periods].[events],''$'') WITH(
				[id] NVARCHAR(MAX),
				[official] NVARCHAR(MAX),
				[clock] TIME,
				[description] NVARCHAR(MAX),
				[event_type] NVARCHAR(MAX),
				[stoppage_type] NVARCHAR(MAX),
				[strength] NVARCHAR(MAX),
				[zone] NVARCHAR(MAX),
				[wall_clock] NVARCHAR(MAX),
				[updated] NVARCHAR(MAX),
				[players[0]].full_name] NVARCHAR(MAX)		''$.players[0].full_name'',
				[players[0]].jersey_number] INT				''$.players[0].jersey_number'',
				[players[0]].id] NVARCHAR(MAX)				''$.players[0].id'',
				[players[0]].sr_id] NVARCHAR(MAX)			''$.players[0].sr_id'',
				[players[0]].reference] NVARCHAR(MAX)		''$.players[0].reference'',
				[players[1]].full_name] NVARCHAR(MAX)		''$.players[1].full_name'',
				[players[1]].jersey_number] INT				''$.players[1].jersey_number'',
				[players[1]].id] NVARCHAR(MAX)				''$.players[1].id'',
				[players[1]].sr_id] NVARCHAR(MAX)			''$.players[1].sr_id'',
				[players[1]].reference] NVARCHAR(MAX)		''$.players[1].reference'',
				[players[2]].full_name] NVARCHAR(MAX)		''$.players[2].full_name'',
				[players[2]].jersey_number] INT				''$.players[2].jersey_number'',
				[players[2]].id] NVARCHAR(MAX)				''$.players[2].id'',
				[players[2]].sr_id] NVARCHAR(MAX)			''$.players[2].sr_id'',
				[players[2]].reference] NVARCHAR(MAX)		''$.players[2].reference'',
				[players[3]].full_name] NVARCHAR(MAX)		''$.players[3].full_name'',
				[players[3]].jersey_number] INT				''$.players[3].jersey_number'',
				[players[3]].id] NVARCHAR(MAX)				''$.players[3].id'',
				[players[3]].sr_id] NVARCHAR(MAX)			''$.players[3].sr_id'',
				[players[3]].reference] NVARCHAR(MAX)		''$.players[3].reference'',
				[players[4]].full_name] NVARCHAR(MAX)		''$.players[4].full_name'',
				[players[4]].jersey_number] INT				''$.players[4].jersey_number'',
				[players[4]].id] NVARCHAR(MAX)				''$.players[4].id'',
				[players[4]].sr_id] NVARCHAR(MAX)			''$.players[4].sr_id'',
				[players[4]].reference] NVARCHAR(MAX)		''$.players[4].reference'',
				[players[5]].full_name] NVARCHAR(MAX)		''$.players[5].full_name'',
				[players[5]].jersey_number] INT				''$.players[5].jersey_number'',
				[players[5]].id] NVARCHAR(MAX)				''$.players[5].id'',
				[players[5]].sr_id] NVARCHAR(MAX)			''$.players[5].sr_id'',
				[players[5]].reference] NVARCHAR(MAX)		''$.players[5].reference'',
				[attribution] NVARCHAR(MAX) as JSON,
				[location] NVARCHAR(MAX) as JSON,
				[details] NVARCHAR(MAX) as JSON,
				[players] NVARCHAR(MAX) as JSON,
				[on_ice] NVARCHAR(MAX) as JSON,
				[in_penalty] NVARCHAR(MAX) as JSON,
				[statistics] NVARCHAR(MAX) as JSON,
				[updated] NVARCHAR(MAX))						as [events]
		outer APPLY OPENJSON([events].[attribution]) WITH(
				[name] NVARCHAR(MAX),
				[market] NVARCHAR(MAX),
				[team_goal] NVARCHAR(MAX),
				[id] NVARCHAR(MAX),
				[sr_id] NVARCHAR(MAX),
				[reference] NVARCHAR(MAX))						as [attribution]
		outer APPLY OPENJSON([events].[location]) WITH(
				[coord_x] INT,
				[coord_y] INT,
				[action_area] NVARCHAR(MAX))					as [location]
		outer APPLY OPENJSON([events].[details]) WITH(
				[shot_type] NVARCHAR(MAX),
				[distance] NVARCHAR(MAX),
				[stoppage_type] NVARCHAR(MAX),
				[goal_zone] NVARCHAR(MAX),
				[penalty_code] NVARCHAR(MAX),
				[duration] NVARCHAR(MAX),
				[penalty_type] NVARCHAR(MAX),
				[reason] NVARCHAR(MAX))							as [details]
INSERT INTO [dbo].[pbp_master] ([on_ice_home_name]
							  ,[on_ice_home_market]
							  ,[on_ice_home_id]
							  ,[on_ice_home_sr_id]
							  ,[on_ice_home_reference]
							  ,[home_player0_name]
							  ,[home_player0_no]
							  ,[home_player0_position]
							  ,[home_player0_primary_position]
							  ,[home_player0_id]
							  ,[home_player0_sr_id]
							  ,[home_player0_reference]
							  ,[home_player1_name]
							  ,[home_player1_no]
							  ,[home_player1_position]
							  ,[home_player1_primary_position]
							  ,[home_player1_id]
							  ,[home_player1_sr_id]
							  ,[home_player1_reference]
							  ,[home_player2_name]
							  ,[home_player2_no]
							  ,[home_player2_position]
							  ,[home_player2_primary_position]
							  ,[home_player2_id]
							  ,[home_player2_sr_id]
							  ,[home_player2_reference]
							  ,[home_player3_name]
							  ,[home_player3_no]
							  ,[home_player3_position]
							  ,[home_player3_primary_position]
							  ,[home_player3_id]
							  ,[home_player3_sr_id]
							  ,[home_player3_reference]
							  ,[home_player4_name]
							  ,[home_player4_no]
							  ,[home_player4_position]
							  ,[home_player4_primary_position]
							  ,[home_player4_id]
							  ,[home_player4_sr_id]
							  ,[home_player4_reference]
							  ,[home_player5_name]
							  ,[home_player5_no]
							  ,[home_player5_position]
							  ,[home_player5_primary_position]
							  ,[home_player5_id]
							  ,[home_player5_sr_id]
							  ,[home_player5_reference]
							  ,[on_ice_away_name]
							  ,[on_ice_away_market]
							  ,[on_ice_away_id]
							  ,[on_ice_away_sr_id]
							  ,[on_ice_away_reference]
							  ,[away_player0_name]
							  ,[away_player0_no]
							  ,[away_player0_position]
							  ,[away_player0_primary_position]
							  ,[away_player0_id]
							  ,[away_player0_sr_id]
							  ,[away_player0_reference]
							  ,[away_player1_name]
							  ,[away_player1_no]
							  ,[away_player1_position]
							  ,[away_player1_primary_position]
							  ,[away_player1_id]
							  ,[away_player1_sr_id]
							  ,[away_player1_reference]
							  ,[away_player2_name]
							  ,[away_player2_no]
							  ,[away_player2_position]
							  ,[away_player2_primary_position]
							  ,[away_player2_id]
							  ,[away_player2_sr_id]
							  ,[away_player2_reference]
							  ,[away_player3_name]
							  ,[away_player3_no]
							  ,[away_player3_position]
							  ,[away_player3_primary_position]
							  ,[away_player3_id]
							  ,[away_player3_sr_id]
							  ,[away_player3_reference]
							  ,[away_player4_name]
							  ,[away_player4_no]
							  ,[away_player4_position]
							  ,[away_player4_primary_position]
							  ,[away_player4_id]
							  ,[away_player4_sr_id]
							  ,[away_player4_reference]
							  ,[away_player5_name]
							  ,[away_player5_no]
							  ,[away_player5_position]
							  ,[away_player5_primary_position]
							  ,[away_player5_id]
							  ,[away_player5_sr_id]
							  ,[away_player5_reference]
							  ,[in_penalty_penalty0_name]
							  ,[in_penalty_penalty0_market]
							  ,[in_penalty_penalty0_id]
							  ,[in_penalty_penalty0_sr_id]
							  ,[in_penalty_penalty0_reference]
							  ,[penalty0_player0_name]
							  ,[penalty0_player0_no]
							  ,[penalty0_player0_position]
							  ,[penalty0_player0_primary_position]
							  ,[penalty0_player0_id]
							  ,[penalty0_player0_sr_id]
							  ,[penalty0_player0_reference]
							  ,[penalty0_player1_name]
							  ,[penalty0_player1_no]
							  ,[penalty0_player1_position]
							  ,[penalty0_player1_primary_position]
							  ,[penalty0_player1_id]
							  ,[penalty0_player1_sr_id]
							  ,[penalty0_player1_reference]
							  ,[penalty0_player2_name]
							  ,[penalty0_player2_no]
							  ,[penalty0_player2_position]
							  ,[penalty0_player2_primary_position]
							  ,[penalty0_player2_id]
							  ,[penalty0_player2_sr_id]
							  ,[penalty0_player2_reference]
							  ,[penalty0_player3_name]
							  ,[penalty0_player3_no]
							  ,[penalty0_player3_position]
							  ,[penalty0_player3_primary_position]
							  ,[penalty0_player3_id]
							  ,[penalty0_player3_sr_id]
							  ,[penalty0_player3_reference]
							  ,[penalty0_player4_name]
							  ,[penalty0_player4_no]
							  ,[penalty0_player4_position]
							  ,[penalty0_player4_primary_position]
							  ,[penalty0_player4_id]
							  ,[penalty0_player4_sr_id]
							  ,[penalty0_player4_reference]
							  ,[penalty0_player5_name]
							  ,[penalty0_player5_no]
							  ,[penalty0_player5_position]
							  ,[penalty0_player5_primary_position]
							  ,[penalty0_player5_id]
							  ,[penalty0_player5_sr_id]
							  ,[penalty0_player5_reference]
							  ,[in_penalty_penalty1_name]
							  ,[in_penalty_penalty1_market]
							  ,[in_penalty_penalty1_id]
							  ,[in_penalty_penalty1_sr_id]
							  ,[in_penalty_penalty1_reference]
							  ,[penalty1_player0_name]
							  ,[penalty1_player0_no]
							  ,[penalty1_player0_position]
							  ,[penalty1_player0_primary_position]
							  ,[penalty1_player0_id]
							  ,[penalty1_player0_sr_id]
							  ,[penalty1_player0_reference]
							  ,[penalty1_player1_name]
							  ,[penalty1_player1_no]
							  ,[penalty1_player1_position]
							  ,[penalty1_player1_primary_position]
							  ,[penalty1_player1_id]
							  ,[penalty1_player1_sr_id]
							  ,[penalty1_player1_reference]
							  ,[penalty1_player2_name]
							  ,[penalty1_player2_no]
							  ,[penalty1_player2_position]
							  ,[penalty1_player2_primary_position]
							  ,[penalty1_player2_id]
							  ,[penalty1_player2_sr_id]
							  ,[penalty1_player2_reference]
							  ,[penalty1_player3_name]
							  ,[penalty1_player3_no]
							  ,[penalty1_player3_position]
							  ,[penalty1_player3_primary_position]
							  ,[penalty1_player3_id]
							  ,[penalty1_player3_sr_id]
							  ,[penalty1_player3_reference]
							  ,[penalty1_player4_name]
							  ,[penalty1_player4_no]
							  ,[penalty1_player4_position]
							  ,[penalty1_player4_primary_position]
							  ,[penalty1_player4_id]
							  ,[penalty1_player4_sr_id]
							  ,[penalty1_player4_reference]
							  ,[penalty1_player5_name]
							  ,[penalty1_player5_no]
							  ,[penalty1_player5_position]
							  ,[penalty1_player5_primary_position]
							  ,[penalty1_player5_id]
							  ,[penalty1_player5_sr_id]
							  ,[penalty1_player5_reference]
							  ,[gameid]
							  ,[gamesr_id]
							  ,[status]
							  ,[coverage]
							  ,[scheduled]
							  ,[start_time]
							  ,[end_time]
							  ,[attendance]
							  ,[total_game_duration]
							  ,[current_period]
							  ,[time_left]
							  ,[entry_mode]
							  ,[reference]
							  ,[home_market]
							  ,[home_name]
							  ,[home_sr_id]
							  ,[home_id]
							  ,[home_points]
							  ,[home_cur_strength]
							  ,[home_reference]
							  ,[away_market]
							  ,[away_name]
							  ,[away_sr_id]
							  ,[away_id]
							  ,[away_points]
							  ,[away_cur_strength]
							  ,[away_reference]
							  ,[pd_type]
							  ,[pd_id]
							  ,[pd_no]
							  ,[pd_seq]
							  ,[hm_market]
							  ,[hm_name]
							  ,[hm_id]
							  ,[pd_hm_points]
							  ,[hm_reference]
							  ,[aw_market]
							  ,[aw_name]
							  ,[aw_id]
							  ,[pd_aw_points]
							  ,[aw_reference]
							  ,[events_id]
							  ,[events_official]
							  ,[events_clock]
							  ,[events_description]
							  ,[events_type]
							  ,[stoppage_type]
							  ,[events_strength]
							  ,[events_updated]
							  ,[wall_clock]
							  ,[events_participant0]
							  ,[events_participant0_jersey_number]
							  ,[events_participant0_id]
							  ,[events_participant0_sr_id]
							  ,[events_participant0_reference]
							  ,[events_participant1]
							  ,[events_participant1_jersey_number]
							  ,[events_participant1_id]
							  ,[events_participant1_sr_id]
							  ,[events_participant1_reference]
							  ,[events_participant2]
							  ,[events_participant2_jersey_number]
							  ,[events_participant2_id]
							  ,[events_participant2_sr_id]
							  ,[events_participant2_reference]
							  ,[events_participant3]
							  ,[events_participant3_jersey_number]
							  ,[events_participant3_id]
							  ,[events_participant3_sr_id]
							  ,[events_participant3_reference]
							  ,[events_participant4]
							  ,[events_participant4_jersey_number]
							  ,[events_participant4_id]
							  ,[events_participant4_sr_id]
							  ,[events_participant4_reference]
							  ,[events_participant5]
							  ,[events_participant5_jersey_number]
							  ,[events_participant5_id]
							  ,[events_participant5_sr_id]
							  ,[events_participant5_reference]
							  ,[stat_type_0]
							  ,[stat_strength_0]
							  ,[stat_zone_0]
							  ,[saved_0]
							  ,[faceoff_win_0]
							  ,[stat_goal_0]
							  ,[penalty_severity_0]
							  ,[penalty_minutes_0]
							  ,[stat_team_name_0]
							  ,[stat_team_market_0]
							  ,[stat_team_id_0]
							  ,[stat_team_sr_id_0]
							  ,[stat_team_reference_0]
							  ,[stat_player_name_0]
							  ,[stat_player_num_0]
							  ,[stat_player_id_0]
							  ,[stat_player_sr_id_0]
							  ,[stat_player_reference_0]
							  ,[stat_type_1]
							  ,[stat_strength_1]
							  ,[stat_zone_1]
							  ,[saved_1]
							  ,[faceoff_win_1]
							  ,[stat_goal_1]
							  ,[penalty_severity_1]
							  ,[penalty_minutes_1]
							  ,[stat_team_name_1]
							  ,[stat_team_market_1]
							  ,[stat_team_id_1]
							  ,[stat_team_sr_id_1]
							  ,[stat_team_reference_1]
							  ,[stat_player_name_1]
							  ,[stat_player_num_1]
							  ,[stat_player_id_1]
							  ,[stat_player_sr_id_1]
							  ,[stat_player_reference_1]
							  ,[stat_type_2]
							  ,[stat_strength_2]
							  ,[stat_zone_2]
							  ,[saved_2]
							  ,[faceoff_win_2]
							  ,[stat_goal_2]
							  ,[penalty_severity_2]
							  ,[penalty_minutes_2]
							  ,[stat_team_name_2]
							  ,[stat_team_market_2]
							  ,[stat_team_id_2]
							  ,[stat_team_sr_id_2]
							  ,[stat_team_reference_2]
							  ,[stat_player_name_2]
							  ,[stat_player_num_2]
							  ,[stat_player_id_2]
							  ,[stat_player_sr_id_2]
							  ,[stat_player_reference_2]
							  ,[stat_type_3]
							  ,[stat_strength_3]
							  ,[stat_zone_3]
							  ,[saved_3]
							  ,[faceoff_win_3]
							  ,[stat_goal_3]
							  ,[penalty_severity_3]
							  ,[penalty_minutes_3]
							  ,[stat_team_name_3]
							  ,[stat_team_market_3]
							  ,[stat_team_id_3]
							  ,[stat_team_sr_id_3]
							  ,[stat_team_reference_3]
							  ,[stat_player_name_3]
							  ,[stat_player_num_3]
							  ,[stat_player_id_3]
							  ,[stat_player_sr_id_3]
							  ,[stat_player_reference_3]
							  ,[stat_type_4]
							  ,[stat_strength_4]
							  ,[stat_zone_4]
							  ,[saved_4]
							  ,[faceoff_win_4]
							  ,[stat_goal_4]
							  ,[penalty_severity_4]
							  ,[penalty_minutes_4]
							  ,[stat_team_name_4]
							  ,[stat_team_market_4]
							  ,[stat_team_id_4]
							  ,[stat_team_sr_id_4]
							  ,[stat_team_reference_4]
							  ,[stat_player_name_4]
							  ,[stat_player_num_4]
							  ,[stat_player_id_4]
							  ,[stat_player_sr_id_4]
							  ,[stat_player_reference_4]
							  ,[attr_name]
							  ,[attr_market]
							  ,[attr_goal_side]
							  ,[attr_id]
							  ,[attr_sr_id]
							  ,[attr_reference]
							  ,[coord_x]
							  ,[coord_y]
							  ,[action_area]
							  ,[shot_type]
							  ,[distance]
							  ,[stoppage_type_detail]
							  ,[goal_zone]
							  ,[penalty_code]
							  ,[duration]
							  ,[penalty_type]
							  ,[reason]
							  ,[file_name] )
	select [on_ice_home_name]
		  ,[on_ice_home_market]
		  ,[on_ice_home_id]
		  ,[on_ice_home_sr_id]
		  ,[on_ice_home_reference]
		  ,[home_player0_name]
		  ,[home_player0_no]
		  ,[home_player0_position]
		  ,[home_player0_primary_position]
		  ,[home_player0_id]
		  ,[home_player0_sr_id]
		  ,[home_player0_reference]
		  ,[home_player1_name]
		  ,[home_player1_no]
		  ,[home_player1_position]
		  ,[home_player1_primary_position]
		  ,[home_player1_id]
		  ,[home_player1_sr_id]
		  ,[home_player1_reference]
		  ,[home_player2_name]
		  ,[home_player2_no]
		  ,[home_player2_position]
		  ,[home_player2_primary_position]
		  ,[home_player2_id]
		  ,[home_player2_sr_id]
		  ,[home_player2_reference]
		  ,[home_player3_name]
		  ,[home_player3_no]
		  ,[home_player3_position]
		  ,[home_player3_primary_position]
		  ,[home_player3_id]
		  ,[home_player3_sr_id]
		  ,[home_player3_reference]
		  ,[home_player4_name]
		  ,[home_player4_no]
		  ,[home_player4_position]
		  ,[home_player4_primary_position]
		  ,[home_player4_id]
		  ,[home_player4_sr_id]
		  ,[home_player4_reference]
		  ,[home_player5_name]
		  ,[home_player5_no]
		  ,[home_player5_position]
		  ,[home_player5_primary_position]
		  ,[home_player5_id]
		  ,[home_player5_sr_id]
		  ,[home_player5_reference]
		  ,[on_ice_away_name]
		  ,[on_ice_away_market]
		  ,[on_ice_away_id]
		  ,[on_ice_away_sr_id]
		  ,[on_ice_away_reference]
		  ,[away_player0_name]
		  ,[away_player0_no]
		  ,[away_player0_position]
		  ,[away_player0_primary_position]
		  ,[away_player0_id]
		  ,[away_player0_sr_id]
		  ,[away_player0_reference]
		  ,[away_player1_name]
		  ,[away_player1_no]
		  ,[away_player1_position]
		  ,[away_player1_primary_position]
		  ,[away_player1_id]
		  ,[away_player1_sr_id]
		  ,[away_player1_reference]
		  ,[away_player2_name]
		  ,[away_player2_no]
		  ,[away_player2_position]
		  ,[away_player2_primary_position]
		  ,[away_player2_id]
		  ,[away_player2_sr_id]
		  ,[away_player2_reference]
		  ,[away_player3_name]
		  ,[away_player3_no]
		  ,[away_player3_position]
		  ,[away_player3_primary_position]
		  ,[away_player3_id]
		  ,[away_player3_sr_id]
		  ,[away_player3_reference]
		  ,[away_player4_name]
		  ,[away_player4_no]
		  ,[away_player4_position]
		  ,[away_player4_primary_position]
		  ,[away_player4_id]
		  ,[away_player4_sr_id]
		  ,[away_player4_reference]
		  ,[away_player5_name]
		  ,[away_player5_no]
		  ,[away_player5_position]
		  ,[away_player5_primary_position]
		  ,[away_player5_id]
		  ,[away_player5_sr_id]
		  ,[away_player5_reference]
		  ,[in_penalty_penalty0_name]
		  ,[in_penalty_penalty0_market]
		  ,[in_penalty_penalty0_id]
		  ,[in_penalty_penalty0_sr_id]
		  ,[in_penalty_penalty0_reference]
		  ,[penalty0_player0_name]
		  ,[penalty0_player0_no]
		  ,[penalty0_player0_position]
		  ,[penalty0_player0_primary_position]
		  ,[penalty0_player0_id]
		  ,[penalty0_player0_sr_id]
		  ,[penalty0_player0_reference]
		  ,[penalty0_player1_name]
		  ,[penalty0_player1_no]
		  ,[penalty0_player1_position]
		  ,[penalty0_player1_primary_position]
		  ,[penalty0_player1_id]
		  ,[penalty0_player1_sr_id]
		  ,[penalty0_player1_reference]
		  ,[penalty0_player2_name]
		  ,[penalty0_player2_no]
		  ,[penalty0_player2_position]
		  ,[penalty0_player2_primary_position]
		  ,[penalty0_player2_id]
		  ,[penalty0_player2_sr_id]
		  ,[penalty0_player2_reference]
		  ,[penalty0_player3_name]
		  ,[penalty0_player3_no]
		  ,[penalty0_player3_position]
		  ,[penalty0_player3_primary_position]
		  ,[penalty0_player3_id]
		  ,[penalty0_player3_sr_id]
		  ,[penalty0_player3_reference]
		  ,[penalty0_player4_name]
		  ,[penalty0_player4_no]
		  ,[penalty0_player4_position]
		  ,[penalty0_player4_primary_position]
		  ,[penalty0_player4_id]
		  ,[penalty0_player4_sr_id]
		  ,[penalty0_player4_reference]
		  ,[penalty0_player5_name]
		  ,[penalty0_player5_no]
		  ,[penalty0_player5_position]
		  ,[penalty0_player5_primary_position]
		  ,[penalty0_player5_id]
		  ,[penalty0_player5_sr_id]
		  ,[penalty0_player5_reference]
		  ,[in_penalty_penalty1_name]
		  ,[in_penalty_penalty1_market]
		  ,[in_penalty_penalty1_id]
		  ,[in_penalty_penalty1_sr_id]
		  ,[in_penalty_penalty1_reference]
		  ,[penalty1_player0_name]
		  ,[penalty1_player0_no]
		  ,[penalty1_player0_position]
		  ,[penalty1_player0_primary_position]
		  ,[penalty1_player0_id]
		  ,[penalty1_player0_sr_id]
		  ,[penalty1_player0_reference]
		  ,[penalty1_player1_name]
		  ,[penalty1_player1_no]
		  ,[penalty1_player1_position]
		  ,[penalty1_player1_primary_position]
		  ,[penalty1_player1_id]
		  ,[penalty1_player1_sr_id]
		  ,[penalty1_player1_reference]
		  ,[penalty1_player2_name]
		  ,[penalty1_player2_no]
		  ,[penalty1_player2_position]
		  ,[penalty1_player2_primary_position]
		  ,[penalty1_player2_id]
		  ,[penalty1_player2_sr_id]
		  ,[penalty1_player2_reference]
		  ,[penalty1_player3_name]
		  ,[penalty1_player3_no]
		  ,[penalty1_player3_position]
		  ,[penalty1_player3_primary_position]
		  ,[penalty1_player3_id]
		  ,[penalty1_player3_sr_id]
		  ,[penalty1_player3_reference]
		  ,[penalty1_player4_name]
		  ,[penalty1_player4_no]
		  ,[penalty1_player4_position]
		  ,[penalty1_player4_primary_position]
		  ,[penalty1_player4_id]
		  ,[penalty1_player4_sr_id]
		  ,[penalty1_player4_reference]
		  ,[penalty1_player5_name]
		  ,[penalty1_player5_no]
		  ,[penalty1_player5_position]
		  ,[penalty1_player5_primary_position]
		  ,[penalty1_player5_id]
		  ,[penalty1_player5_sr_id]
		  ,[penalty1_player5_reference]
		  ,[gameid]
		  ,[gamesr_id]
		  ,[status]
		  ,[coverage]
		  ,[scheduled]
		  ,[start_time]
		  ,[end_time]
		  ,[attendance]
		  ,[total_game_duration]
		  ,[current_period]
		  ,[time_left]
		  ,[entry_mode]
		  ,[reference]
		  ,[home_market]
		  ,[home_name]
		  ,[home_sr_id]
		  ,[home_id]
		  ,[home_points]
		  ,[home_cur_strength]
		  ,[home_reference]
		  ,[away_market]
		  ,[away_name]
		  ,[away_sr_id]
		  ,[away_id]
		  ,[away_points]
		  ,[away_cur_strength]
		  ,[away_reference]
		  ,[pd_type]
		  ,[pd_id]
		  ,[pd_no]
		  ,[pd_seq]
		  ,[hm_market]
		  ,[hm_name]
		  ,[hm_id]
		  ,[pd_hm_points]
		  ,[hm_reference]
		  ,[aw_market]
		  ,[aw_name]
		  ,[aw_id]
		  ,[pd_aw_points]
		  ,[aw_reference]
		  ,[events_id]
		  ,[events_official]
		  ,[events_clock]
		  ,[events_description]
		  ,[events_type]
		  ,[stoppage_type]
		  ,[events_strength]
		  ,[events_updated]
		  ,[wall_clock]
		  ,[events_participant0]
		  ,[events_participant0_jersey_number]
		  ,[events_participant0_id]
		  ,[events_participant0_sr_id]
		  ,[events_participant0_reference]
		  ,[events_participant1]
		  ,[events_participant1_jersey_number]
		  ,[events_participant1_id]
		  ,[events_participant1_sr_id]
		  ,[events_participant1_reference]
		  ,[events_participant2]
		  ,[events_participant2_jersey_number]
		  ,[events_participant2_id]
		  ,[events_participant2_sr_id]
		  ,[events_participant2_reference]
		  ,[events_participant3]
		  ,[events_participant3_jersey_number]
		  ,[events_participant3_id]
		  ,[events_participant3_sr_id]
		  ,[events_participant3_reference]
		  ,[events_participant4]
		  ,[events_participant4_jersey_number]
		  ,[events_participant4_id]
		  ,[events_participant4_sr_id]
		  ,[events_participant4_reference]
		  ,[events_participant5]
		  ,[events_participant5_jersey_number]
		  ,[events_participant5_id]
		  ,[events_participant5_sr_id]
		  ,[events_participant5_reference]
		  ,[stat_type_0]
		  ,[stat_strength_0]
		  ,[stat_zone_0]
		  ,[saved_0]
		  ,[faceoff_win_0]
		  ,[stat_goal_0]
		  ,[penalty_severity_0]
		  ,[penalty_minutes_0]
		  ,[stat_team_name_0]
		  ,[stat_team_market_0]
		  ,[stat_team_id_0]
		  ,[stat_team_sr_id_0]
		  ,[stat_team_reference_0]
		  ,[stat_player_name_0]
		  ,[stat_player_num_0]
		  ,[stat_player_id_0]
		  ,[stat_player_sr_id_0]
		  ,[stat_player_reference_0]
		  ,[stat_type_1]
		  ,[stat_strength_1]
		  ,[stat_zone_1]
		  ,[saved_1]
		  ,[faceoff_win_1]
		  ,[stat_goal_1]
		  ,[penalty_severity_1]
		  ,[penalty_minutes_1]
		  ,[stat_team_name_1]
		  ,[stat_team_market_1]
		  ,[stat_team_id_1]
		  ,[stat_team_sr_id_1]
		  ,[stat_team_reference_1]
		  ,[stat_player_name_1]
		  ,[stat_player_num_1]
		  ,[stat_player_id_1]
		  ,[stat_player_sr_id_1]
		  ,[stat_player_reference_1]
		  ,[stat_type_2]
		  ,[stat_strength_2]
		  ,[stat_zone_2]
		  ,[saved_2]
		  ,[faceoff_win_2]
		  ,[stat_goal_2]
		  ,[penalty_severity_2]
		  ,[penalty_minutes_2]
		  ,[stat_team_name_2]
		  ,[stat_team_market_2]
		  ,[stat_team_id_2]
		  ,[stat_team_sr_id_2]
		  ,[stat_team_reference_2]
		  ,[stat_player_name_2]
		  ,[stat_player_num_2]
		  ,[stat_player_id_2]
		  ,[stat_player_sr_id_2]
		  ,[stat_player_reference_2]
		  ,[stat_type_3]
		  ,[stat_strength_3]
		  ,[stat_zone_3]
		  ,[saved_3]
		  ,[faceoff_win_3]
		  ,[stat_goal_3]
		  ,[penalty_severity_3]
		  ,[penalty_minutes_3]
		  ,[stat_team_name_3]
		  ,[stat_team_market_3]
		  ,[stat_team_id_3]
		  ,[stat_team_sr_id_3]
		  ,[stat_team_reference_3]
		  ,[stat_player_name_3]
		  ,[stat_player_num_3]
		  ,[stat_player_id_3]
		  ,[stat_player_sr_id_3]
		  ,[stat_player_reference_3]
		  ,[stat_type_4]
		  ,[stat_strength_4]
		  ,[stat_zone_4]
		  ,[saved_4]
		  ,[faceoff_win_4]
		  ,[stat_goal_4]
		  ,[penalty_severity_4]
		  ,[penalty_minutes_4]
		  ,[stat_team_name_4]
		  ,[stat_team_market_4]
		  ,[stat_team_id_4]
		  ,[stat_team_sr_id_4]
		  ,[stat_team_reference_4]
		  ,[stat_player_name_4]
		  ,[stat_player_num_4]
		  ,[stat_player_id_4]
		  ,[stat_player_sr_id_4]
		  ,[stat_player_reference_4]
		  ,[attr_name]
		  ,[attr_market]
		  ,[attr_goal_side]
		  ,[attr_id]
		  ,[attr_sr_id]
		  ,[attr_reference]
		  ,[coord_x]
		  ,[coord_y]
		  ,[action_area]
		  ,[shot_type]
		  ,[distance]
		  ,[stoppage_type_detail]
		  ,[goal_zone]
		  ,[penalty_code]
		  ,[duration]
		  ,[penalty_type]
		  ,[reason]
		  ,[file_name]
		from #json_2
')
EXEC(@sql)
set @i = @i + 1;
End
--OUTPUT TO 'C:\\Users\\saiem\\Documents\\GT Analytics Courses\\_Data Visualization and Analytics - CSE6242\\Saiem\\Project-NHL-Shooting\\PBP_JSON_DATA\\2018\\pbp_2018_1.csv'
--FORMAT TEXT
--QUOTE '"'
--WITH COLUMN NAMES;
--select distinct events_id from #json_2


--delete from pbp_master where events_id is not null