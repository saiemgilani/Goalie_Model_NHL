import requests
import matplotlib.pyplot as plt
import json
import pandas as pd

import matplotlib.colors as cm
import numpy as np
import pyodbc
import sys
from pandas import DataFrame
from matplotlib import pyplot as plt
from textwrap import wrap

cnxn = pyodbc.connect('Trusted_Connection=yes', 
                    DSN = 'hockey', 
                    driver = '{ODBC Driver 13 for SQL Server}', 
                    server = 'saiemasus', 
                    database = 'hockey')     

querystring = """ select team, time, homeTeamGoals, awayTeamGoals, location, event,
goal, shotRebound, shotPlayContinuedOutsideZone, shotPlayContinuedInZone, 
shotGoalieFroze, shotPlayStopped, shotGeneratedRebound, xCord, yCord, shotAngle,shotAngleAdjusted, 
shotAnglePlusRebound,shotAngleReboundRoyalRoad,shotDistance,shotType,shotOnEmptyNet,shotRebound,
shotAnglePlusReboundSpeed, shotRush, speedFromLastEvent, xGoal, xFroze, xRebound, 
xPlayContinuedInZone, xPlayContinuedOutsideZone, xPlayStopped, xShotWasOnGoal, 
isHomeTeam, shotWasOnGoal, teamCode, goalieIdForShot, goalieNameForShot, 
shooterPlayerId, shooterName, shooterLeftRight
from shots 
"""

cursor = cnxn.cursor()
cursor.execute(querystring)


tables=cursor.fetchall()
d = []
for row in tables:
    d.append({'team': row.team, 
             'time': row.time, 
             'homeTeamGoals': row.homeTeamGoals, 
             'awayTeamGoals': row.awayTeamGoals, 
             'location': row.location, 
             'event': row.event,
             'goal': row.goal, 
             'shotRebound': row.shotRebound, 
             'shotPlayContinuedOutsideZone': row.shotPlayContinuedOutsideZone, 
             'shotPlayContinuedInZone': row.shotPlayContinuedInZone, 
             'shotGoalieFroze': row.shotGoalieFroze,
             'shotPlayStopped': row.shotPlayStopped, 
             'shotGeneratedRebound': row.shotGeneratedRebound,
             'xCord': row.xCord, 
             'yCord': row.yCord,
             'shotAngle': row.shotAngle,
             'shotAngleAdjusted': row.shotAngleAdjusted, 
             'shotAnglePlusRebound': row.shotAnglePlusRebound,
             'shotAngleReboundRoyalRoad': row.shotAngleReboundRoyalRoad,
             'shotDistance': row.shotDistance, 
             'shotType': row.shotType,
             'shotOnEmptyNet': row.shotOnEmptyNet,
             'shotRebound': row.shotRebound,
             'shotAnglePlusReboundSpeed': row.shotAnglePlusReboundSpeed, 
             'shotRush': row.shotRush, 
             'speedFromLastEvent': row.speedFromLastEvent, 
             'xGoal': row.xGoal, 
             'xFroze': row.xFroze, 
             'xRebound': row.xRebound, 
             'xPlayContinuedInZone':row.xPlayContinuedInZone, 
             'xPlayContinuedOutsideZone':row.xPlayContinuedOutsideZone, 
             'xPlayStopped':row.xPlayStopped, 
             'xShotWasOnGoal':row.xShotWasOnGoal, 
             'isHomeTeam':row.isHomeTeam, 
             'shotWasOnGoal':row.shotWasOnGoal, 
             'teamCode':row.teamCode, 
             'goalieIdForShot':row.goalieIdForShot, 
             'goalieNameForShot':row.goalieNameForShot, 
             'shooterPlayerId':row.shooterPlayerId, 
             'shooterName':row.shooterName, 
             'shooterLeftRight':row.shooterLeftRight})
    
df = pd.DataFrame(d)
print(df.describe())

cnxn.close()
