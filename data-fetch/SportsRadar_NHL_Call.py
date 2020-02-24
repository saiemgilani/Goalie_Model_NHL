import http.client
import json
import io
import codecs
import requests
game_ids_2015 = []
game_ids_2016 = []
game_ids_2017 = []
game_ids_2018 = []
for j in range(2015,2019):
    with open(str(j)+"_NHL_RegSeason_Schedule.json", "r") as read_file:
        data = json.load(read_file)


        for i in range(len(data["games"])):
            if j == 2018:
                game_ids_2018.append(data["games"][i]["id"])
            if j == 2017:
                game_ids_2017.append(data["games"][i]["id"])
            if j == 2016:
                game_ids_2016.append(data["games"][i]["id"])
            if j == 2015:
                game_ids_2015.append(data["games"][i]["id"])
            
print(len(game_ids_2015))        
print(len(game_ids_2016))        
print(len(game_ids_2017))                
print(len(game_ids_2018)) 

try:
    to_unicode = unicode
except NameError:
    to_unicode = str

for i in range(939,len(game_ids_2018)):

    pbp_json = requests.get("https://api.sportradar.us/nhl/trial/v6/en/games/"+str(game_ids_2018[i]) +"/pbp.json?api_key=zc5u6gc4bb84me6qw6vsvtgc")

    
    data = pbp_json.json()
    game_file = "pbp_2018_"+ str(i) +".json"


    with open(game_file, 'w') as f:
        json.dump(data, f)
            
    # Read JSON file
    with open(game_file) as data_file:
        data_loaded = json.load(data_file)

    print(i,": ",data == data_loaded)